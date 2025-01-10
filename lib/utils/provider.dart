import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:CUDI/widgets/cudi_inputs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../routes.dart';
import '../models/favorite.dart';
import '../models/menu.dart';
import '../models/order.dart';
import '../models/store.dart';
import '../models/user.dart';
import '../screens/my_cudi/cs/email_inquiry.dart';
import '../screens/auth/add_profile_screen.dart';
import '../widgets/cudi_util_widgets.dart';
import 'auth/authentication.dart';
import 'enum.dart';
import 'db/firebase_firestore.dart';

///
class UserProvider extends ChangeNotifier {
  static UserProvider of(BuildContext context) => context.read<UserProvider>();

  String _uid = '유저이메일아이디 받아오기 전';

  String get uid => _uid;

  late String _userEmail;

  String get userEmail => _currentUser.userEmail ?? "";

  User _currentUser = User();

  User get currentUser => _currentUser;

  Store _currentStore = Store();

  Store get currentStore => _currentStore;

  Menu _currentMenu = Menu();

  Menu get currentMenu => _currentMenu;

  List<Cart> _cart = [];

  List<Cart> get cart => _cart;

  // List<Cart>? _previousCart;
  // List<Cart>? _userCart;
  //
  // List<Cart>? get userCart => _userCart;

  bool _isCartAdded = false;

  bool get isCartAdded => _isCartAdded;

  // List<Cart>? get previousCart => _previousCart;

  OrderData _currentOD = OrderData();

  OrderData get currentOD => _currentOD;

  bool _isCartExist = false;

  bool get isCartExist => _isCartExist;

  // 미디어 쿼리
  double? _bodyHeight;

  double? get bodyHeight => _bodyHeight;

  void setSizes(BuildContext context) {
    _bodyHeight = MediaQuery.of(context).size.height -
        88.h -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
  }

  Future<void> setUid(String uid) async {
    _uid = uid;
    debugPrint('프로바이더에 유저 uid 저장됨: $_uid');
    notifyListeners();
  }

  Future<void> setCurrentStore(context, Store currentStore) async {
    _currentStore = currentStore;
    debugPrint(
        '프로바이더에 현재 스토어의 storeId, storeName 저장됨: ${currentStore.storeId}, ${currentStore.storeName}');
    // await FireStore.userUpdate(context, recentStore: {"recent_store" : FieldValue.arrayUnion([currentStore.storeId])});
    // await FireStore.userUpdate(context, recentStore: [currentStore.storeId ?? ""]);
    await FirebaseFirestore.instance.collection("user").doc(uid).update({
      "recent_store": FieldValue.arrayRemove([currentStore.storeId]),
    }).then((value) {
      print('순서를 위해서 스토어 삭제');
    });
    await FirebaseFirestore.instance.collection("user").doc(uid).update({
      "recent_store": FieldValue.arrayUnion([currentStore.storeId]),
    }).then((value) {
      print('최근 스토어 추가됨');
    });
    notifyListeners();
  }

  Future<void> setCurrentMenu(Menu currentMenu) async {
    _currentMenu = currentMenu;
    debugPrint('프로바이더에 현재 메뉴 저장됨: $currentMenu');
    notifyListeners();
  }

  Future<void> setCurrentOD(OrderData currentOD) async {
    _currentOD = currentOD;
    debugPrint('프로바이더에 현재 주문 저장됨: $currentOD');
    // FireStore.addOrder(_currentOD);
    notifyListeners();
  }

  Future<void> setCurrentUser() async {
    _currentUser = await FireStore.setUser(uid) ?? User();
    debugPrint('프로바이더에 현재 유저 초기화 됨: $currentUser');
    notifyListeners();
  }

  Future<void> setCart() async {
    _cart = await FireStore.getCart(uid);
    notifyListeners();
  }

  // Future<void> setUserCart() async {
  //   // _previousCart = _userCart; // 이전 카트 저장
  //   _userCart = await FireStore.getCart(uid);
  //   notifyListeners();
  //   // // 이전 카트와 현재 카트를 비교
  //   // if (previousCart != null && previousCart != _userCart) {
  //   //   // 카트가 변경되었을 때 원하는 동작 수행
  //   //   // 예: snackbar 표시, 다른 로직 실행 등
  //   //   print('카트가 변경되었습니다.');
  //   // }
  //   // notifyListeners();
  // }

  void setIsCartAdded(bool value) {
    _isCartAdded = value;
    print("setIsCartAdded: $_isCartAdded");
    notifyListeners();
  }

  Future<void> goStoreScreen(BuildContext context, Store store) async {
    await Provider.of<UserProvider>(context, listen: false)
        .setCurrentStore(context, store);
    Navigator.pushNamed(context, RouteName.store);
  }

  void goMenuScreen(BuildContext context, Menu menu) {
    Provider.of<UserProvider>(context, listen: false).setCurrentMenu(menu);
    Navigator.pushNamed(context, RouteName.menu);
  }

  Future<void> setIsCartExist() async {
    List<Cart> userCart = await FireStore.getCart(uid);
    _isCartExist = userCart.isNotEmpty;
    debugPrint('cart: $_isCartExist');
    notifyListeners();
  }
}

/// Util Provider
class UtilProvider extends ChangeNotifier {
  static UtilProvider of(BuildContext context) => context.read<UtilProvider>();

  /// 스토어
  List<Store> _storeList = [];

  List<Store> get storeList => _storeList;

  set storeList(List<Store> value) {
    _storeList = value;
    notifyListeners();
  }

  static Future<void> getAndSetStores(BuildContext context,
      {int? index, double? latitude, double? longitude}) async {
    List<Store> stores = [];

    try {
      if (index == 0) {
        stores = await FireStore.getRecentlyAddedStores();
      } else if (index == 1) {
        // Get most favorited stores
        stores = await FireStore.getMostFavoritedStores();
      } else if (index == 2) {
        stores = await FireStore.getNearbyStores(latitude ?? 0, longitude ?? 0);
      } else if (index == 3) {
        stores = await FireStore.getRecentStores(context);
      } else {
        stores = await FireStore.getStoreList();
      }

      // Update the storeList
      UtilProvider.of(context).storeList = stores;
    } catch (e) {
      print("Error getting and setting stores: $e");
    }
  }

  // static Future<void> getAndSetStores(BuildContext context,
  //     {int? index}) async {
  //   try {
  //     List<Store> stores = [];
  //
  //     if (index == 0) {
  //       // 최근 추가된 순서
  //       var querySnapshot = await FirebaseFirestore.instance
  //           .collection("store")
  //           .limit(10)
  //           .get();
  //       stores = querySnapshot.docs
  //           .map((doc) => Store.fromFirestore(doc, null))
  //           .toList();
  //     } else if (index == 1) {
  //       // 찜이 많은 순서
  //       var querySnapshot = await FirebaseFirestore.instance
  //           .collection("favorite")
  //           .orderBy("store_id", descending: true)
  //           .limit(20)
  //           .get();
  //
  //       // Set to keep track of unique store IDs
  //       Set<String> addedStoreIds = Set<String>();
  //
  //       // favorite 문서들을 Store로 변환하여 리스트에 추가
  //       for (var doc in querySnapshot.docs) {
  //         var storeId = doc["store_id"];
  //
  //         // Check if storeId has already been added
  //         if (!addedStoreIds.contains(storeId)) {
  //           // store_id를 사용하여 store 컬렉션에서 해당 store 가져오기
  //           var storeSnapshot = await FirebaseFirestore.instance
  //               .collection("store")
  //               .doc(storeId)
  //               .get();
  //
  //           if (storeSnapshot.exists) {
  //             // Store로 변환하여 리스트에 추가
  //             stores.add(Store.fromFirestore(storeSnapshot, null));
  //
  //             // Add the storeId to the set to mark it as added
  //             addedStoreIds.add(storeId);
  //           }
  //         }
  //       }
  //     } else if (index == 2) {
  //       // 최근 방문한 순서
  //       // 구현해야 할 내용 추가
  //     }
  //
  //     _storeList = stores;
  //   } catch (e) {
  //     print("Error completing: $e");
  //   }
  // }

  /// 찜
  List<Favorite> _favorites = [];

  List<Favorite> get favorites => _favorites;

  set favorites(List<Favorite> value) {
    _favorites = value;
    notifyListeners();
  }

  static Future<void> getFavorites(BuildContext context, String uid) async {
    try {
      var qerySnapshot = await FirebaseFirestore.instance
          .collection('favorite')
          .where("uid", isEqualTo: uid)
          .get();
      List<Favorite> favorites = qerySnapshot.docs
          .map((doc) => Favorite.fromFirestore(doc, null))
          .toList();

      UtilProvider.of(context).favorites = favorites;
      print('getFavorites complete');
    } catch (e) {
      print("Error completing: $e");
    }
  }

  // /// User docRef
  // Future<User?> userDocRef(String userEmailId) async {
  //   final ref = FirebaseFirestore.instance.collection("user").doc(userEmailId).withConverter(
  //     fromFirestore: User.fromFirestore,
  //     toFirestore: (User user, _) => user.toFirestore(),
  //   );
  //   final docSnap = await ref.get();
  //   final user = docSnap.data(); // Convert to City object
  //   if (user != null) {
  //     debugPrint('$user');
  //     return user;
  //   } else {
  //     debugPrint("No such user document.");
  //     return null;
  //   }
  // }

  bool _isView = false;

  bool get isView => _isView;

  void setView() {
    _isView = !_isView;
    notifyListeners();
  }

  bool? _isEmailValid;
  bool? _isEBeforeValid;
  bool? _isCertValid;

  bool? get isEmailValid => _isEmailValid;

  bool? get isEBeforeValid => _isEBeforeValid;

  bool? get isCertValid => _isCertValid;

  bool _isSent = false;

  bool get isSent => _isSent;

  bool _isEmailSent = false;
  String? _emailCode;
  bool? _isEmailCodeMatched;

  bool get isEmailSent => _isEmailSent;

  String? get emailCode => _emailCode;

  bool? get isEmailCodeMatched => _isEmailCodeMatched;

  final int countdownSeconds = 120;
  late int _secondsOutput;
  Timer? _countdownTimer;
  String _timeText = '';
  late String _certButtonTitle;
  String _verificationId = '';
  String _phoneNumber = '';
  String _resendMessage = '';
  String _uid = '';

  int get secondsOutput => _secondsOutput;

  Timer? get countdownTimer => _countdownTimer;

  String get timeText => _timeText;

  String get certButtonTitle => _isSent || _isEmailSent ? "인증완료" : "인증 번호 전송";

  String get verificationId => _verificationId;

  String get phoneNumber => _phoneNumber;

  String get resendMessage => _timeText == "0:00" ? "인증번호 재전송" : "";

  String get uid => _uid;

  void validateEmail(String value) {
    bool isValid =
        RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value);
    if (value.isNotEmpty) {
      _isEmailValid = isValid;
    } else {
      _isEmailValid = null;
    }
    notifyListeners();
  }

  void validateEBefore(String value) {
    bool isValid =
        RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value);
    if (value.isNotEmpty) {
      _isEmailValid = isValid;
    } else {
      _isEmailValid = null;
    }
    notifyListeners();
  }

  void validateCert(String value) {
    bool isValid = value.length >= 6;
    if (value.isNotEmpty) {
      _isCertValid = isValid;
    } else {
      _isCertValid = null;
    }
    notifyListeners();
  }

  // void setCertButtonTitle(String text) {
  //   _certButtonTitle = text;
  //   notifyListeners();
  // }

  void setIsSent(bool isSent) {
    _isSent = isSent;
    if (_isSent == true) {
      startCountdown();
    }
    notifyListeners();
  }

  void setIsEmailSent(bool isEmailSent) {
    _isEmailSent = isEmailSent;
    notifyListeners();
  }

  void setEmailCode(String emailCode) {
    _emailCode = emailCode;
    notifyListeners();
  }

  void setEmailUnmatched(bool unmatched) {
    _isEmailCodeMatched = unmatched;
    notifyListeners();
  }

  // "인증번호 전송" 함수
  void sendSMS(BuildContext context, List<bool>? checks,
      [String? phoneNumber]) {
    certController.clear();
    // 폰번호 포매팅
    _phoneNumber =
        '+82${phoneNumber?.replaceAll(' - ', '') ?? phoneController.text.replaceAll(' - ', '')}';
    // 파이어베이스 인증
    auth.FirebaseAuth authentication = auth.FirebaseAuth.instance;
    authentication
        .verifyPhoneNumber(
            phoneNumber: _phoneNumber,
            // 인증 문자 전송
            codeSent: (String verificationId, int? resendToken) async {
              cudiDialog(context, '인증번호', '인증번호가 전송되었습니다.', button1Text: '닫기');
              setIsSent(true);
              print(
                  'codeSent 인증 문자 전송, verificationId: $verificationId, resendToken: $resendToken');
              _verificationId = verificationId;
            },
            // 안드로이드 인증 성공
            verificationCompleted: (phoneAuthCredential) async {
              cudiDialog(context, '인증번호', '본인인증이 완료되었습니다.', button1Text: '닫기')
                  .then((value) {
                handleSignUp(context, []);
              });
            },
            verificationFailed: (auth.FirebaseAuthException error) {
              print('verificationFailed 인증 문자 전송 실패');
              if (error.code == 'too-many-requests') {
                cudiDialog(context, '인증번호',
                    '비정상적인 활동으로 인해 이 장치의 모든 요청을 차단했습니다. 나중에 다시 시도하세요.',
                    button1Text: '닫기');
              } else {
                cudiDialog(context, '인증번호', '인증번호 전송에 실패하였습니다.\n다시 시도해주세요.',
                    button1Text: '닫기');
                print('인증번호 전송에 실패하였습니다.\n다시 시도해주세요. $error');
              }
            },
            timeout: Duration(seconds: countdownSeconds),
            codeAutoRetrievalTimeout: (String verificationId) {
              print(
                  'codeAutoRetrievalTimeout 인증 문자 시간 초과, verificationId: $verificationId');
            })
        .catchError((error) {
      print('인증 실패: $error');
    });
  }

  // 인증 코드를 랜덤으로 생성하는 함수
  String generateRandomCode() {
    Random random = Random();
    return (100000 + random.nextInt(900000)).toString(); // 6자리 랜덤 코드 생성
  }

  // 이메일 인증코드 보내는 함수
  void sendEmail(BuildContext context, String email,
      {bool? isJoin, bool? isCode}) async {
    var p = UtilProvider.of(context);
    p.setIsSent(false);
    p.setIsEmailSent(false);

    // 랜덤으로 생성된 6자리 코드
    p.setEmailCode(generateRandomCode());

    final Map<String, dynamic> data = {
      'service_id': dotenv.env['E2_SERVICE_ID'],
      'template_id': dotenv.env['E2_TEMPLATE_ID'],
      'user_id': dotenv.env['E2_USER_ID'],
      'template_params': {
        'email': email,
        'message': p.emailCode,
      },
    };
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InAppWebViewExampleScreen(
                data: data, isJoin: isJoin, isCode: isCode)));
  }

  void verifyCode(BuildContext context, List<bool> checks, {bool? isModify}) {
    auth.PhoneAuthCredential credential = auth.PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: certController.text);

    auth.FirebaseAuth authentication = auth.FirebaseAuth.instance;

    authentication.signInWithCredential(credential).then((authResult) async {
      if (authResult.user != null) {
        _uid = authResult.user!.uid;
        print('사용자 인증 성공: $_uid');

        if (isModify != null && isModify) {
          handleModify(context, credential);
        } else {
          handleSignUp(context, checks);
        }
      } else {
        print('사용자 인증 실패');
      }
    }).catchError((error) {
      handleAuthenticationError(context, error);
    });
  }

  void handleModify(
      BuildContext context, auth.AuthCredential credential) async {
    // 동일한 전화번호를 가진 사용자가 이미 존재하는지 확인
    QuerySnapshot<Object?> querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('user_phone_number', isEqualTo: _phoneNumber)
        .get();

    if (querySnapshot.docs.isEmpty) {
      // 동일한 전화번호를 가진 사용자가 없으면 연락처 업데이트 수행
      Authentication().deleteCurrentUser(context, authCredential: credential);
      FireStore.userUpdate(context, phoneNumber: _phoneNumber, newUid: _uid)
          .then((value) {
        phoneController.clear();
        certController.clear();
        cudiDialog(
            context, "연락처 변경완료", "성공적으로 연락처가 변경되었습니다!\n내 정보 페이지로 가시겠습니까?",
            button1Function: () {
          setIsSent(false);
          Navigator.pop(context);
        }, button2Function: () {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.my, (route) => false);
        });
      });
    } else {
      // 동일한 전화번호를 가진 사용자가 이미 존재하면 적절한 메시지를 표시
      handleExistingUser(context);
    }
  }

  void handleSignUp(BuildContext context, List<bool> checks,
      {bool? isModify}) async {
    if (checks.isEmpty) {
      _uid = "인증 완료";
    }

    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection("user");
    QuerySnapshot<Object?> secessionUser = await usersCollection
        .where("user_phone_id", isEqualTo: _uid)
        // 같은 phone_id들 중에서 탈퇴시간 내림차순의 가장 첫번째 문서
        .orderBy("secession_time", descending: true)
        .get();

    if (secessionUser.docs.isNotEmpty) {
      Map<String, dynamic>? userData =
          secessionUser.docs[0].data() as Map<String, dynamic>?;
      handleSecessionUser(context, userData, checks, isModify: isModify);
    } else {
      handleNewUser(context, checks, isModify: isModify);
    }
  }

  void handleSecessionUser(
      BuildContext context, Map<String, dynamic>? userData, List<bool> checks,
      {bool? isModify}) {
    if (userData != null) {
      Timestamp? withdrawalTime = userData['secession_time'] as Timestamp?;

      if (withdrawalTime != null) {
        Timestamp now = Timestamp.now();
        Duration difference = now.toDate().difference(withdrawalTime.toDate());

        if (difference.inHours >= 24) {
          handleRejoin(context, checks, isModify: isModify);
        } else {
          handleRejoinUnavailable(context);
        }
      } else {
        handleRejoinUnavailable(context);
      }
    } else {
      // userData가 null이면 오류 처리
      print('오류: userData가 null입니다.');
    }
  }

  Future<void> handleRejoin(BuildContext context, List<bool> checks,
      {bool? isModify}) async {
    // 24시간 이후에 재가입 가능한 경우,  처리
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('user_phone_number', isEqualTo: _phoneNumber)
        .get();
    bool isExistUser = querySnapshot.docs.isEmpty;

    if (isExistUser) {
      handleNewUser(context, checks, isModify: isModify);
    } else {
      handleExistingUser(context);
    }
  }

  void handleRejoinUnavailable(BuildContext context) {
    cudiDialog(context, '재가입 불가', '탈퇴 후 24시간 이내 재가입 불가합니다.',
        button1Text: '닫기', button1Function: () => Navigator.pop(context));
  }

  void handleExistingUser(BuildContext context) {
    print('이미 등록된 유저');
    cudiDialog(context, '회원가입', '이미 등록된 유저입니다.',
        button1Text: '아이디, 비밀번호 찾기',
        button1Function: () {
          setIsSent(false);
          Navigator.pop(context);
          snackBar(context, '준비중입니다.');
        },
        button2Text: '닫기',
        button2Function: () {
          setIsSent(false);
          Navigator.pop(context);
        });
  }

  void handleNewUser(BuildContext context, List<bool> checks,
      {bool? isModify}) {
    print('등록되지 않은 유저');
    if (isModify != null && isModify) {
      // 유저 전화번호 업데이트
      FireStore.userUpdate(context, phoneNumber: _phoneNumber);
      Navigator.pop(context);
    } else {
      // 회원가입 진행
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AddProfileScreen(
            checks: checks,
            phoneNumber: _phoneNumber,
            uid: _uid,
          ),
        ),
      );
    }
  }

  void handleAuthenticationError(BuildContext context, dynamic error) {
    if (error.code == 'session-expired') {
      cudiDialog(
          context, '인증코드 만료', 'SMS 코드가 만료되었습니다. 다시 시도하려면 인증코드를 다시 요청하세요.',
          button1Text: '닫기', button1Function: () => Navigator.pop(context));
    } else {
      snackBar(context, '인증번호를 다시 확인해주세요.');
    }
  }

  Future<void> verifiedEmailCode(BuildContext context) async {
    UserProvider u = UserProvider.of(context);
    if (certController.text == emailCode) {
      _isEmailCodeMatched = false;

      String uPw = u.currentUser.userPassword ?? '';
      String newEmail = emailController.text;

      try {
        // 이미 가입된 이메일인지 확인
        List<String> providers = await auth.FirebaseAuth.instance
            .fetchSignInMethodsForEmail(emailController.text);

        if (providers.contains('password')) {
          // 해당 이메일로 이미 가입된 사용자가 있음
          snackBar(context, "이미 가입된 이메일입니다.");
          return;
        }

        // 가입되지 않은 경우, 이메일 변경 진행
        Authentication().deleteCurrentUser(context);
        String? newUserEmailId = await Authentication().signUp(newEmail, uPw);
        FireStore.userUpdate(context,
                newUserEmail: newEmail, newUserEmailId: newUserEmailId)
            .then((value) {
          u.setCurrentUser();
          cudiDialog(
              context, "이메일 변경완료", "성공적으로 이메일이 변경되었습니다!\n내 정보 페이지로 가시겠습니까?",
              button2Function: () {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteName.my, (route) => false);
          });
        });
      } catch (e) {
        if (e is auth.FirebaseAuthException) {
          print(
              'Firebase Auth Exception - Code: ${e.code}, Message: ${e.message}');
          if (e.code == "email-already-in-use") {
            snackBar(context, "이미 가입된 이메일입니다.");
          }
        } else {
          print('Unexpected Error: $e');
        }
      }

      //   // 파이어베이스 user 생성
      //   String? result = await Authentication().signUp(newEmail, uPw).then((newUid) {
      //     print("newUid: $newUid");
      //       // 파이어베이스 userDoc 변경 (이전 uid 사용, 새 uid 사용)
      //
      //   }).catchError((e) async {
      //     if (e is auth.FirebaseAuthException) {
      //       print(
      //           'Firebase Auth Exception - Code: ${e.code}, Message: ${e.message}');
      //       if (e.code == "email-already-in-use") {
      //         final auth.User? user = await Authentication().getUser();
      //         User userDoc = await FireStore.getUserDoc(user!.uid);
      //         if(userDoc == User()) {
      //           await user.delete();
      //           await Authentication()
      //               .signUp(emailController.text, uPw).then((newUid) {
      //             // 파이어베이스 userDoc 변경 (이전 uid 사용, 새 uid 사용)
      //             FireStore.userUpdate(context, uid, newUserEmail: newEmail, newUserEmailId: newUid).then((value) {
      //               cudiDialog(context, "이메일 변경완료", "성공적으로 이메일이 변경되었습니다!\n내 정보 페이지로 가시겠습니까?", button2Function: () {
      //                 Navigator.pushNamedAndRemoveUntil(context, RouteName.my, (route) => false);
      //               });
      //             });
      //           });
      //         } else {
      //           snackBar(context, "이미 사용중인 이메일입니다.");
      //         }
      //       }
      //     } else {
      //       print('Unexpected Error: $e');
      //     }
      //   });
      //   print("result: $result");
      //   if(result == null) snackBar(context, "이미 사용중인 이메일입니다.");
      // } else {
      //   setEmailUnmatched(true);
    }
  }

  Future<void> signInEmailChange() async {
    // Please verify the new email before changing email. 뜸..
    auth.User? user = auth.FirebaseAuth.instance.currentUser;
    if (user != null) {
      debugPrint('$user');
      await user.updateEmail(emailController.text).then((_) {
        debugPrint('user != null: $user');
      });
    } else {
      debugPrint('user == null: $user');
    }
  }

  Future<void> signInWithVerifyEmailAndPassword(BuildContext context) async {
    try {
      auth.UserCredential credential = await auth.FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: '123456');
      await credential.user!.sendEmailVerification();

      if (credential.user != null) {
        // emailVerified : false
        // debugPrint('${credential.user!.emailVerified}');
      }
      // debugPrint('emailVerified: ${credential.user?.emailVerified}');
    } on auth.FirebaseAuthException catch (error) {
      String? _errorCode;
      switch (error.code) {
        case "email-already-in-use":
          _errorCode = error.code;
          break;
        case "invalid-email":
          _errorCode = error.code;
          break;
        case "weak-password":
          _errorCode = error.code;
          break;
        case "operation-not-allowed":
          _errorCode = error.code;
          break;
        default:
          _errorCode = null;
      }
    }
  }

  void startCountdown() {
    // 기존 타이머가 실행 중인지 확인하고 취소
    if (_countdownTimer != null && _countdownTimer!.isActive) {
      _countdownTimer!.cancel();
    }

    _secondsOutput = countdownSeconds;
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _secondsOutput--; // 1초씩 감소
      if (_secondsOutput <= 0) {
        // 시간이 종료되면 타이머를 멈춥니다.
        timer.cancel();
      }

      // 시간을 분:초 형식으로 표시합니다.
      int minutes = _secondsOutput ~/ 60;
      int seconds = _secondsOutput % 60;
      _timeText = '$minutes:${seconds.toString().padLeft(2, '0')}';
      notifyListeners();
    });
  }

  bool? _isPasswordValid;
  bool? _isPWBeforeValid;
  bool? _isPWConfirmValid;
  String _message = "";

  bool? get isPasswordValid => _isPasswordValid;

  bool? get isPWBeforeValid => _isPWBeforeValid;

  bool? get isPWConfirmValid => _isPWConfirmValid;

  String get message => _message;

  void validatePassword(String value) {
    bool isValid = value.length >= 6;
    bool hasUpperCase = value.contains(RegExp(r'[A-Z]'));
    if (value.isNotEmpty) {
      _isPasswordValid = isValid;
      if (hasUpperCase) {
        _message = "Caps Lock 확인해 주세요.";
      } else {
        _message = "";
      }
    } else {
      _isPasswordValid = null;
    }
    notifyListeners();
  }

  void setMessage(String message) {
    _message = message;
    notifyListeners();
  }

  Future<void> validatePWBefore(String value) async {
    bool isValid = value.length >= 6;
    bool hasUpperCase = value.contains(RegExp(r'[A-Z]'));
    if (value.isNotEmpty) {
      _isPWBeforeValid = isValid;
      if (hasUpperCase) {
        _message = "Caps Lock 확인해 주세요.";
      } else {
        _message = "";
      }
    } else {
      _isPWBeforeValid = null;
    }
    notifyListeners();
  }

  Future<auth.UserCredential?> confirmPassword(
      BuildContext context, String value) async {
    try {
      final credential = await auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: Provider.of<UserProvider>(context, listen: false)
                  .currentUser
                  .userEmail
                  .toString(),
              password: value);
      debugPrint(credential.toString());
      return credential;
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('출력: No user found for that email.');
        return null;
      } else if (e.code == 'wrong-password') {
        debugPrint('출력: Wrong password provided for that user.');
        return null;
      }
    }
  }

  void validatePWConfirm(String value) {
    bool isValid = value.length >= 6;
    bool isConfirm = value == passwordController.text;
    bool hasUpperCase = value.contains(RegExp(r'[A-Z]'));
    if (value.isNotEmpty) {
      _isPWConfirmValid = isValid && isConfirm;
      if (isConfirm == false) {
        _message = "비밀번호가 일치하지 않습니다.";
        if (hasUpperCase) {
          _message = "Caps Lock 확인해 주세요.";
        } else {
          // _message = "";
        }
      } else {
        _message = "";
      }
    } else {
      _isPWConfirmValid = null;
    }
    notifyListeners();
  }

  bool? _isNicknameValid;

  bool? get isNicknameValid => _isNicknameValid;

  void validateNickname(String value) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('user_nickname', isEqualTo: value)
        .get();
    bool isValid = querySnapshot.docs.isEmpty;
    if (value.isNotEmpty) {
      _isNicknameValid = isValid;
    } else {
      _isNicknameValid = null;
    }
    notifyListeners();
  }

  bool? _isUserPWValid;

  bool? get isUserPWValid => _isUserPWValid;

  void validateUserPW(BuildContext context, String value) async {
    UserProvider userProvider = context.read<UserProvider>();
    bool isValid = value == userProvider.currentUser.userPassword;
    if (value.isNotEmpty) {
      _isUserPWValid = isValid;
    } else {
      _isUserPWValid = null;
    }

    notifyListeners();
  }

  bool? _isBirthValid;

  bool? get isBirthValid => _isBirthValid;

  void validateBirth(String value) async {
    bool isValid = value.length >= 10;
    if (value.isNotEmpty) {
      _isBirthValid = isValid;
    } else {
      _isBirthValid = null;
    }
    notifyListeners();
  }

  bool? _isPhoneValid;

  bool? get isPhoneValid => _isPhoneValid;

  void validatePhone(String value) async {
    bool isValid = value.length >= 16;
    if (value.isNotEmpty) {
      _isPhoneValid = isValid;
      if (isValid) {
        _phoneNumber = value;
      }
    } else {
      _isPhoneValid = null;
    }
    notifyListeners();
  }

  String? _gender;

  String? get gender => _gender;

  void setGender(String value) {
    if (_gender == value) {
      _gender = null;
    } else {
      _gender = value;
    }
    notifyListeners();
  }

  late Map<Object, Object?> _secessionData;

  Map<Object, Object?> get secessionData => _secessionData;

  void setSecessionData(Map<Object, Object?> data) {
    _secessionData = data;
    notifyListeners();
  }

  List<String> _dropdownItems = <String>['오류', '오류2', '오류3', '오류4'];
  String _selectedItem = '오류';
  String _selectedItem2 = "";

  List<String> get dropdownItems => _dropdownItems;

  String get selectedItem => _selectedItem;

  String get selectedItem2 => _selectedItem2;

  void setSelectedItem(String item) {
    _selectedItem = item;
    notifyListeners();
  }

  void setSelectedItem2(String item) {
    _selectedItem2 = item;
    notifyListeners();
  }

  /// Image picker
  final ImagePicker _picker = ImagePicker(); // 인스턴스 생성
  XFile? _pickedImage; // 고른 파일
  List<XFile?> _pickedImages = []; // 고른 파일 여러개

  XFile? get pickedImage => _pickedImage;

  List<XFile?> get pickedImages => _pickedImages;

  void setPickImage() {
    _pickedImage = null;
    notifyListeners();
  }

  void setPickImages() {
    _pickedImages = [];
    notifyListeners();
  }

  // // Firebase Storage에 이미지 업로드하는 함수
  // Future<void> uploadImageToFirebaseStorage(context, XFile imageFile) async {
  //   UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
  //   try {
  //     final Reference storageReference = FirebaseStorage.instance
  //         .ref()
  //         .child('images/${userProvider.userEmailId}_${DateTime.now()}.jpg'); // 원하는 대로 경로를 수정할 수 있습니다
  //
  //     final UploadTask uploadTask = storageReference.putFile(
  //         File(imageFile.path));
  //
  //     await uploadTask.whenComplete(() {
  //       print('이미지가 Firebase Storage에 업로드되었습니다');
  //     });
  //   } catch (e) {
  //     print('이미지 업로드 오류: $e');
  //   }
  // }
  Future<String?> uploadImageToFirebaseStorage(context, XFile imageFile) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    try {
      final String imageName =
          'images/${userProvider.currentUser.userEmailId}_${DateTime.now()}.jpg';
      final Reference storageReference =
          FirebaseStorage.instance.ref().child(imageName);

      final UploadTask uploadTask =
          storageReference.putFile(File(imageFile.path));

      await uploadTask.whenComplete(() {
        print('이미지가 Firebase Storage에 업로드되었습니다');
      });

      // 이미지 업로드 후 URL 반환
      String imageUrl = await storageReference.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('이미지 업로드 오류: $e');
      return null;
    }
  }

  // 이미지 여러개 불러오기 및 업로드
  Future<List<String>> getAndUploadMultiImages(BuildContext context) async {
    // final List<XFile> images = await _picker.pickMultiImage();
    List<XFile> images =
        _pickedImages.where((image) => image != null).cast<XFile>().toList();
    List<String> uploadedImageUrls = [];

    for (XFile imageFile in images) {
      String? imageUrl = await uploadImageToFirebaseStorage(context, imageFile);
      if (imageUrl != null) {
        uploadedImageUrls.add(imageUrl);
      }
    }
    // 파일 프로바이더 비우기
    setPickImages();
    return uploadedImageUrls;
  }

  // 갤러리에서 이미지 1개 불러오기
  Future<void> getImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    _pickedImage = pickedFile;
    // try {
    //   final XFile? pickedFile = await _picker.pickImage(source: source);
    //   _pickedImage = pickedFile;
    // } catch (e) {
    //   debugPrint('$e');
    // }
    notifyListeners();
  }

  // 이미지 여러개 불러오기
  void getMultiImage() async {
    final List<XFile> images = await _picker.pickMultiImage();
    _pickedImages.addAll(images);
    notifyListeners();
  }

  // Future<void> imagePickerFunction(BuildContext context, XFile? imageFile) async {
  //   UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
  //
  //   if(imageFile != null ) {
  //     // 이미지 업로드
  //     await uploadImageToFirebaseStorage(context, imageFile);
  //
  //     // 이미지 URL 가져오기
  //     String? imageUrl = await getImageUrlFromFirebaseStorage(
  //         'images/${userProvider.userEmailId}_${DateTime.now()}.jpg');
  //
  //     // 이미지 [user_img_url] 업데이트
  //     FireStore.userUpdate(context, userProvider.userEmailId, userImgUrl: imageUrl);
  //   } else {
  //     snackBar(context, '다시 시도해주십시오.');
  //   }
  // }

  OverlayEntry? _overlayEntry;

  // OverlayEntry? get overlayEntry => _overlayEntry;

  void showOverlay(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (BuildContext overlayContext) => Positioned(
        top: MediaQuery.of(overlayContext).size.height * 0.5,
        left: MediaQuery.of(overlayContext).size.width * 0.5,
        child: const CircularProgressIndicator(),
      ),
    );
    Overlay.of(context)?.insert(_overlayEntry!);
    notifyListeners();
  }

  void hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    notifyListeners();
  }

  Future<void> imagePickerFunction(
      BuildContext context, XFile? imageFile) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    showOverlay(context);
    if (imageFile != null) {
      // 이미지 업로드 및 URL 얻기
      String? imageUrl = await uploadImageToFirebaseStorage(context, imageFile);

      if (imageUrl != null) {
        // 이미지 [user_img_url] 업데이트
        FireStore.userUpdate(context, userImgUrl: imageUrl);
        // 유저 초기화
        userProvider.setCurrentUser();
        // 파일 프로바이더 비우기
        setPickImage();
        hideOverlay();
      } else {
        hideOverlay();
        snackBar(context, '이미지 업로드 중 오류가 발생했습니다.');
      }
    } else {
      hideOverlay();
      snackBar(context, '다시 시도해주십시오.');
    }
  }

  /// Switch
  bool? _pushNotificationConsent;
  bool? _promotionEventNotificationsConsent;
  bool? _locationServiceConsent;
  bool? _cupayNotificationsConsent;

  bool? get pushNotificationConsent => _pushNotificationConsent;

  bool? get promotionEventNotificationsConsent =>
      _promotionEventNotificationsConsent;

  bool? get locationServiceConsent => _locationServiceConsent;

  bool? get cupayNotificationsConsent => _cupayNotificationsConsent;

  void initSwitches(BuildContext context) {
    _pushNotificationConsent =
        UserProvider.of(context).currentUser.pushNotificationConsent;
    _promotionEventNotificationsConsent =
        UserProvider.of(context).currentUser.promotionEventNotificationsConsent;
    _locationServiceConsent =
        UserProvider.of(context).currentUser.locationServiceConsent;
    _cupayNotificationsConsent =
        UserProvider.of(context).currentUser.cupayNotificationsConsent;
  }

  void setSwitch(BuildContext context, String switchName) {
    String uid = UserProvider.of(context).uid ?? "";
    switch (switchName) {
      case 'pushNotificationConsent':
        _pushNotificationConsent = !_pushNotificationConsent!;
        updateUserConsents(context, uid,
            {'push_notification_consent': _pushNotificationConsent});
        break;
      case 'promotionEventNotificationsConsent':
        _promotionEventNotificationsConsent =
            !_promotionEventNotificationsConsent!;
        updateUserConsents(context, uid, {
          'promotion_event_notifications_consent':
              _promotionEventNotificationsConsent
        });
        break;
      case 'locationServiceConsent':
        _locationServiceConsent = !_locationServiceConsent!;
        updateUserConsents(context, uid,
            {'location_service_consent': _locationServiceConsent});
        break;
      case 'cupayNotificationsConsent':
        _cupayNotificationsConsent = !_cupayNotificationsConsent!;
        updateUserConsents(context, uid,
            {'cupay_notifications_consent': _cupayNotificationsConsent});
        break;
      default:
        throw ArgumentError('Invalid switch name: $switchName');
    }
  }

  Future<void> updateUserConsents(
      BuildContext context, String uid, Map<String, dynamic> consents) async {
    try {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(uid)
          .update(consents);
      // snackBar(context, "${consents.keys}가 ${consents.values}로 변경되었습니다.");
      snackBar(context, "변경되었습니다.");
      notifyListeners();
    } catch (e) {
      print("Error updating user consents: $e");
    }
  }

  /// Checks
  // 버튼 활성화하는 체크박스
  bool _allowButtonCheck = false;

  bool get allowButtonCheck => _allowButtonCheck;

  void setAllowButtonCheck(bool check) {
    _allowButtonCheck = !_allowButtonCheck;
    notifyListeners();
  }

  // 카페 신고
  List<bool?> _reportChecks = List.filled(6, null);

  List<bool?> get reportChecks => List.from(_reportChecks);

  bool? get reportCheck1 => _reportChecks[0];

  bool? get reportCheck2 => _reportChecks[1];

  bool? get reportCheck3 => _reportChecks[2];

  bool? get reportCheck4 => _reportChecks[3];

  bool? get reportCheck5 => _reportChecks[4];

  bool? get reportCheck6 => _reportChecks[5];

  void setReportChecks(List<bool?> checks) {
    _reportChecks = List.from(checks);
    notifyListeners();
  }

  // 회원 탈퇴
  List<bool?> _secessionChecks = List.filled(6, null);

  List<bool?> get secessionChecks => List.from(_secessionChecks);

  bool? get secessionCheck1 => _secessionChecks[0];

  bool? get secessionCheck2 => _secessionChecks[1];

  bool? get secessionCheck3 => _secessionChecks[2];

  bool? get secessionCheck4 => _secessionChecks[3];

  bool? get secessionCheck5 => _secessionChecks[4];

  void setSecessionChecks(List<bool?> checks) {
    _secessionChecks = List.from(checks);
    notifyListeners();
  }
}

class SelectedTagProvider extends ChangeNotifier {
  Set<Enum> filters = <Enum>{}; // 선택된 필터를 저장하는 집합
  Set<String> get koreanLabels =>
      filters.map((Enum e) => tagFilterLabels[e]!).toSet();
  Set<Enum>? previousFilters; // 이전 필터를 저장하는 변수

  void toggleFilter(dynamic filter, {location}) {
    if (filters.contains(filter)) {
      filters.remove(filter);
    } else {
      filters.add(filter);
    }
    notifyListeners();
  }

  void clearFilters() {
    filters.clear();
    notifyListeners();
  }
}

class OrderProvider extends ChangeNotifier {
  OrderData _order = OrderData();

  OrderData get order => _order;

  Future<void> setOrderData(OrderData orderData) async {
    _order = order;
    notifyListeners();
  }
}
