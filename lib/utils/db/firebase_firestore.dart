import 'package:CUDI/models/coupon.dart';
import 'package:CUDI/models/favorite.dart';
import 'package:CUDI/utils/provider.dart';
import 'package:CUDI/widgets/cudi_util_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import '../../models/cart.dart';
import '../../models/menu.dart';
import '../../models/payments.dart';
import '../../models/store.dart';
import '../../models/user.dart';
import '../../models/order.dart';
import 'dart:math' as math;

import '../push/notification_service.dart';

class FireStore {
  static FirebaseFirestore db = FirebaseFirestore.instance;
  static CollectionReference<Map<String, dynamic>> userRef = db.collection("user");
  static CollectionReference<Map<String, dynamic>> storeRef = db.collection("store");
  static CollectionReference<Map<String, dynamic>> favoriteRef = db.collection("favorite");
  static CollectionReference<Map<String, dynamic>> couponRef = db.collection("coupon");

  static final userConverter = userRef.withConverter<User>(
    fromFirestore: User.fromFirestore,
    toFirestore: (User user, _) => user.toFirestore(),
  );

  static final storeConverter = storeRef.withConverter<Store>(
    fromFirestore: Store.fromFirestore,
    toFirestore: (Store store, _) => store.toFirestore(),
  );

  static final favoriteConverter = favoriteRef.withConverter<Favorite>(
    fromFirestore: Favorite.fromFirestore,
    toFirestore: (Favorite favorite, _) => favorite.toFirestore(),
  );

  /// User
  static Future<String> addUser(User user) async {
    DocumentReference<User> newUser = await userConverter.add(user);
    debugPrint("addUser");
    return newUser.id;
  }

  static Future<DocumentSnapshot> getUserDoc(String userEmail) async {
    QuerySnapshot querySnapshot = await userRef
        .where("user_email", isEqualTo: userEmail)
        .get();
    return querySnapshot.docs.first;
  }

  static Future<User?> getUser(String userEmail) async {
    QuerySnapshot<User> querySnapshot = await userConverter
        .where("user_email", isEqualTo: userEmail)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      User user = querySnapshot.docs.first.data();
      return user;
    } else {
      return null;
    }
  }

  static Future<User?> setUser(String uid) async {
    DocumentSnapshot<User> documentSnapshot = await userConverter.doc(uid).get();
    return documentSnapshot.data();
  }

  static Future<void> userUpdate(
      BuildContext context,
      {
        String? nickName,
        String? birth,
        String? gender,
        String? phoneNumber,
        String? newUid,
        String? userImgUrl,
        String? newUserPw,
        String? newUserEmail,
        String? newUserEmailId,
        // Map<String, FieldValue>? recentStore,
        // List<String>? recentStore,
      }) async {
    User user = UserProvider.of(context).currentUser;
    QuerySnapshot query = await db.collection("user")
        .where("user_email", isEqualTo: user.userEmail)
        .where('user_email_id', isEqualTo: user.userEmailId).get();
    final ref = query.docs[0].reference;

    Map<String, dynamic> updatedData = User().toFirestore();

    // 사용자가 입력한 값이 null이 아닌 경우에만 해당 필드를 업데이트
    if (nickName != null) {
      updatedData["user_nickname"] = nickName;
    }
    if (birth != null) {
      updatedData["user_birth"] = birth;
    }
    if (gender != null) {
      updatedData["user_gender"] = gender;
    }
    if (phoneNumber != null) {
      updatedData["user_phone_number"] = phoneNumber;
    }
    if (newUid != null) {
      updatedData["user_id"] = newUid;
    }
    if (userImgUrl != null) {
      updatedData["user_img_url"] = userImgUrl;
    }
    if (newUserPw != null) {
      updatedData["user_password"] = newUserPw;
    }
    if (newUserEmail != null) {
      updatedData["user_email"] = newUserEmail;
    }
    if (newUserEmailId != null) {
      updatedData["user_email_id"] = newUserEmailId;
    }
    // if (recentStore != null) {
    //   updatedData["recent_store"] = recentStore;
    //   print('updatedData recentStore : $recentStore');
    // }

    await ref.update(updatedData).then((value) {
      debugPrint("Document successfully updated!");
      if (nickName != null ||
          birth != null ||
          gender != null ||
          userImgUrl != null) {
        snackBar(context, "회원정보가 업데이트되었습니다.");
        UserProvider.of(context).setCurrentUser();
      }
    }, onError: (e) {
      debugPrint("Error updating document: $e");
    });
  }

  // 계정 삭제
  static void userSecession(String userEmailId) async {
    try {
      // 현재 사용자 가져오기
      auth.User? user = auth.FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Firestore에서 해당 사용자의 문서 가져오기
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('user') // 컬렉션 이름
            .doc(user.uid) // UID에 해당하는 문서 가져오기
            .get();

        // 탈퇴일 추가
        await FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .update({
          'withdrawal_date': FieldValue.serverTimestamp(),
          // 필요한 경우 다른 필드 업데이트
          '다른필드1': null,
          // '다른필드2': null,
          // ...
        });

        // Firebase Authentication에서 사용자 삭제
        await user.delete();
      }
    } catch (e) {
      print('계정 삭제 중 오류 발생: $e');
    }
  }

  /// Store
  static Future<void> addStore(Store store) async {
    await storeConverter.add(store);
    debugPrint("addStore");
  }

  static Future<DocumentSnapshot> getStoreDoc(String storeId) async {
    DocumentSnapshot documentSnapshot = await storeRef
        .doc(storeId)
        .get().catchError((e) => print('error'));
    return documentSnapshot;
  }

  static Future<Store?> getStore(String storeId) async {
    DocumentSnapshot storeDoc = await getStoreDoc(storeId);
    if (storeDoc.exists) {
      debugPrint("getStore");
      return storeConverter.get() as Store?;
    } else {
      return null;
    }
  }

  static Future<List<Store>> getStoreList() async {
    QuerySnapshot<Store> querySnapshot = await storeConverter.limit(10).get();

    List<Store> storeList = querySnapshot.docs
        .map((doc) => doc.data())
        .toList();

    debugPrint('getStoreList');
    return storeList;
  }

  static Future<List<Store>> getTagStore(Set<String> tagFilterSet) async {

    if (tagFilterSet.isEmpty) {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await storeRef.get();
      List<Store> storeList = querySnapshot.docs
          .map((doc) => Store.fromFirestore(doc, null))
          .toList();
      debugPrint('Tag Empty => all stores');
      return storeList;
    } else {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await storeRef
          .where("store_tag_list", arrayContainsAny: tagFilterSet.toList())
          .get();
      List<Store> storeList = querySnapshot.docs
          .map((doc) => Store.fromFirestore(doc, null))
          .toList();
      debugPrint('Tag Not Empty => tag stores');
      return storeList;
    }
  }

  // 가까운 스토어 20개 가져오기
  static Future<List<Store>> getNearbyStores(
      double userLatitude, double userLongitude) async {

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await storeRef.get();

    List<Store> storeList = querySnapshot.docs
        .map((doc) => Store.fromFirestore(doc, null))
        .toList();

    // 위치 기반 정렬 추가
    storeList.sort((a, b) {
      double distanceToA = calculateDistance(
          userLatitude, userLongitude, a.latitude ?? 0, a.longitude ?? 0);
      double distanceToB = calculateDistance(
          userLatitude, userLongitude, b.latitude ?? 0, b.longitude ?? 0);
      return distanceToA.compareTo(distanceToB);
    });

    // 상위 20개 가게만 반환
    return storeList.take(20).toList();
  }

  // 두 지점 간의 거리 계산
  static double calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // 지구 반지름 (단위: 킬로미터)

    // 각도를 라디안으로 변환
    double lat1Rad = _degreesToRadians(lat1);
    double lon1Rad = _degreesToRadians(lon1);
    double lat2Rad = _degreesToRadians(lat2);
    double lon2Rad = _degreesToRadians(lon2);

    // 위도와 경도의 차이 계산
    double dLat = lat2Rad - lat1Rad;
    double dLon = lon2Rad - lon1Rad;

    // Haversine 공식 적용
    double a = (math.sin(dLat / 2) * math.sin(dLat / 2)) +
        math.cos(lat1Rad) *
            math.cos(lat2Rad) *
            (math.sin(dLon / 2) * math.sin(dLon / 2));
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }

  // 각도를 라디안으로 변환하는 보조 함수
  static double _degreesToRadians(double degrees) {
    return degrees * (math.pi / 180);
  }

  static Future<List<Store>> getRecentlyAddedStores() async {
    try {
      var querySnapshot = await storeRef.limit(10).get();

      return querySnapshot.docs
          .map((doc) => Store.fromFirestore(doc, null))
          .toList();
    } catch (e) {
      print("Error getting recently added stores: $e");
      return [];
    }
  }

  static Future<List<Store>> getMostFavoritedStores() async {
    List<Store> storeList = [];
    QuerySnapshot<Store> querySnapshot = await storeConverter.orderBy("favorite").get();
    for (var docSnapshot in querySnapshot.docs) {
      // print(docSnapshot.data().storeName);
      storeList.add(docSnapshot.data());
    }
    return storeList;
    // // store_id set(unique)
    // List<String> storeIdList = [];
    // QuerySnapshot querySnapshot = await storeRef.get();
    // for (var docSnapshot in querySnapshot.docs) {
    //   storeIdList.add(docSnapshot.id);
    // }
    //
    // Map<String, int> storeFavoriteMap = {};
    //
    // // favorite docs
    // QuerySnapshot<Favorite> querySnapshot2 = await favoriteConverter.get();
    // for (var docSnapshot in querySnapshot2.docs) {
    //   for (var i = 0; i < storeIdList.length; i++) {
    //     if(storeIdList[i] == docSnapshot.data().storeId) {
    //       storeFavoriteMap[i] = storeIdList[i] :  ;
    //     }
    //   }
    // }

      // var querySnapshot = await favoriteRef
      //     .orderBy("store_id")
      //     .get();
      // List<String> favoriteDataList = [];
      // for (var docSnapshot in querySnapshot.docs) {
      //   // print('${docSnapshot.data()["store_id"]}');
      //   // store_id만 리스트에 추가
      //   favoriteDataList.add(docSnapshot.data()["store_id"]);
      //   // 유니크 만들기
      //   List<String> uniqueStrings = favoriteDataList.toSet().toList();
      //
      // }
  }

  // static Future<void> getRecentStores(User user) async {
  static Future<List<Store>> getRecentStores(BuildContext context) async {
    UserProvider.of(context).setCurrentUser();
    List<Store> storeList = [];
    List<String>? userRecentStore = UserProvider.of(context).currentUser.recentStore;
    print('userRecentStore: $userRecentStore');
    // print('userRecentStore: ${user.recentStore}');
    for (var storeId in userRecentStore ?? []) {
      DocumentSnapshot<Store> querySnapshot = await storeConverter.doc(storeId).get();
      if(querySnapshot.data() != null) {
        storeList.add(querySnapshot.data()!);
      }
    }
    return storeList;
  }

  /// Favorite
  static Future<void> addFavorite(Favorite fav) async {
    final docRef = db.collection("favorite").withConverter(
          fromFirestore: Favorite.fromFirestore,
          toFirestore: (Favorite favorite, options) => favorite.toFirestore(),
        );
    await docRef.add(fav).then((documentSnapshot) =>
        debugPrint("Added Favorite doc with ID: ${documentSnapshot.id}"));
  }

  static Future<void> deleteFavorite(String uid, String storeId) async {
    try {
      // Get the document reference using the where clause
      debugPrint(storeId);
      QuerySnapshot querySnapshot = await favoriteRef
          .where("uid", isEqualTo: uid)
          .where("store_id", isEqualTo: storeId)
          .get();
      // debugPrint(querySnapshot.docs);

      // Check if any documents match the query
      if (querySnapshot.docs.isNotEmpty) {
        // Delete each matching document
        for (QueryDocumentSnapshot document in querySnapshot.docs) {
          await db.collection("favorite").doc(document.id).delete();
          debugPrint(document.id);
          debugPrint("Favorite doc deleted");
        }
      } else {
        debugPrint("No matching favorite found");
      }
    } catch (e) {
      debugPrint("Error deleting favorite: $e");
    }
  }

  // 즐겨찾기 토글 메서드
  static Future<void> toggleFavorite(
      bool isFavorite, String uid, String storeId) async {
    if (!isFavorite) {
      Favorite fav = Favorite(
        uid: uid,
        storeId: storeId,
        timestamp: Timestamp.now(),
      );
      await addFavorite(fav);
      NotificationService().showNotification(
        '로컬 푸시 알림 🔔',
        '❤️ 찜한 카페에 추가되었습니다.',
      );
    } else {
      await deleteFavorite(uid, storeId);
      NotificationService().showNotification(
        '로컬 푸시 알림 🔔',
        '찜한 카페에서 제거되었습니다.',
      );
    }
  }

  static Future<List<Store>> getUserFavoriteStores(String uid) async {
    try {
      // "favorite" 컬렉션에서 해당 사용자의 즐겨찾기 목록을 가져옴
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await favoriteRef
              .where('uid', isEqualTo: uid)
              .get();

      List<Store> userFavoriteStores = [];

      // 각 즐겨찾기 항목에 대해 "store" 컬렉션에서 스토어 정보를 가져옴
      for (QueryDocumentSnapshot<Map<String, dynamic>> favoriteDoc
          in querySnapshot.docs) {
        String storeId = favoriteDoc.get('store_id');

        // "store" 컬렉션에서 스토어 정보를 가져옴
        DocumentSnapshot<Map<String, dynamic>> storeDoc = await storeRef.doc(storeId).get();

        // Store 모델 클래스를 사용하여 가져온 스토어 정보를 변환
        Store store = Store.fromFirestore(storeDoc, null);

        // 사용자의 즐겨찾기 스토어 목록에 추가
        userFavoriteStores.add(store);
      }

      return userFavoriteStores;
    } catch (e) {
      print('Error getting user favorite stores: $e');
      // 에러 처리를 위해 예외를 던지거나, 빈 목록을 반환하거나, null을 반환하는 등의 방식을 선택할 수 있습니다.
      throw e; // 예외를 다시 던지거나, 빈 목록을 반환하거나, null을 반환하는 등의 방식을 선택할 수 있습니다.
    }
  }

  static Future<List<Favorite>> getUserFavoriteDesc(String uid) async {
    List<Favorite> favorites = [];
    favoriteRef
        .where("uid", isEqualTo: uid)
        .get()
        .then(
      (querySnapshot) {
        print("getUserFavoriteDesc: Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          // print('${docSnapshot.id} => ${docSnapshot.data()}');
          Favorite fav = Favorite.fromFirestore(docSnapshot, null);
          favorites.add(fav);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return favorites;
  }

  // 스토어의 favorite 개수 얻기
  static Future<int> getFavQuanWithStore(String storeId) async {
    QuerySnapshot querySnapshot = await favoriteRef
        .where("store_id", isEqualTo: storeId)
        .get();
    storeRef.doc(storeId).update({"favorite" : querySnapshot.size});
    debugPrint('fav quantity: ${querySnapshot.docs.length}');
    return querySnapshot.size;
  }

  /// Menu
  // 메뉴 저장
  static void addMenu(Menu menu, String? storeId) async {
    await storeRef
        .doc(storeId)
        .collection("menu")
        .withConverter(
            fromFirestore: Menu.fromFirestore,
            toFirestore: (Menu docs, options) => menu.toFirestore())
        .add(menu);
    debugPrint("메뉴 저장됨");
  }

  // 스토어의 총 메뉴 수
  static Future<void> countMenuDocs(String? storeId) async {
    final QuerySnapshot menuDocs = await FirebaseFirestore.instance
        .collection('store')
        .doc(storeId)
        .collection('menu')
        .get();

    final int documentCount = menuDocs.size;
    debugPrint('총 문서 개수: $documentCount');
  }

  // 카테고리로 메뉴 가져오기
  static Future<Map<String, List<Menu>>> getMenusGroupedByCategory(
      String? storeId) async {
    final menuRef = FirebaseFirestore.instance
        .collection("store")
        .doc(storeId)
        .collection("menu");

    final querySnapshot = await menuRef.get();
    Map<String, List<Menu>> menusByCategory = {}; // 리턴할 변수

    for (var docSnapshot in querySnapshot.docs) {
      var menu = Menu.fromFirestore(docSnapshot, null); // Menu 객체로 컨버팅
      var category = docSnapshot.data()[
          'menu_category']; // Firestore의 문서(snapshot)에서 'menu_category' 필드의 값을 가져오는 것

      if (category != null) {
        if (!menusByCategory.containsKey(category)) {
          menusByCategory[category] = []; // 해당 카테고리가 없다면 빈 리스트로 초기화
        }
        menusByCategory[category]!.add(menu); // 해당 카테고리 리스트에 메뉴 추가
      }
    }

    // debugPrint('카테고리 별 메뉴 리스트 작업 수행함');
    // debugPrint('Menus Grouped by Category: ${menusByCategory}');

    return menusByCategory;
  }

  // 메뉴 카테고리 한글로 넣기
  //// 카테고리가 커피인 문서
  static Future<void> debugPrintMenuCategoryLanguage(String? storeId) async {
    db
        .collection("store")
        .doc(storeId)
        .collection('menu')
        .where("menu_category", isEqualTo: 'coffee')
        .get()
        .then(
      (querySnapshot) {
        debugPrint("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          debugPrint('${docSnapshot.id} => ${docSnapshot.data()}');
        }
        debugPrint(querySnapshot.size.toString());
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
  }

  //// 카테고리가 커피인 문서 업데이트
  // 전체 문서를 덮어쓰지 않고 문서의 일부 필드를 업데이트 하려면 update() 메서드 사용
  static Future<void> updateMenuCategoryLanguage(String? storeId) async {
    // 카테고리가 커피인 문서
    db
        .collection("store")
        .doc(storeId)
        .collection('menu')
        .where("menu_category", isEqualTo: 'signature')
        .get()
        .then(
      (querySnapshot) {
        // debugPrint("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          // debugPrint('${docSnapshot.id} => ${docSnapshot.data()}');
          // 카테고리가 커피인 문서 업데이트
          final washingtonRef = db
              .collection('store')
              .doc(storeId)
              .collection("menu")
              .doc(docSnapshot.id);
          washingtonRef.update({"menu_category": "시그니처"}).then(
              (value) => debugPrint("DocumentSnapshot successfully updated!"),
              onError: (e) => debugPrint("Error updating document $e"));
        }
        // debugPrint(querySnapshot.size);
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
  }

  // 카테고리 Set 만들기
  static Future<Set<String>> getMenuCategories(String? storeId) async {
    Set<String> categories = {};

    await db.collection("store").doc(storeId).collection("menu").get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          var category = docSnapshot.data()['menu_category'];
          if (category != null) {
            categories.add(category);
          }
        }
      },
      onError: (e) => debugPrint("Error fetching categories: $e"),
    );

    return categories;
  }

  static Future<Map<String, dynamic>> getMenu(String storeId) async {
    final ref = db.collection('menu');
    final query = ref.where('store_id', isEqualTo: storeId);

    final Map<String, dynamic> menu = {};

    try {
      final querySnapshot = await query.get();
      debugPrint("Successfully completed");

      for (var docSnapshot in querySnapshot.docs) {
        final data = docSnapshot.data();
        data.forEach((key, value) {
          // 'menu' Map에 각 데이터를 추가합니다.
          menu[key] = value;
        });
      }
    } catch (e) {
      debugPrint("Error completing: $e");
      // 에러 처리
    }

    return menu;
  }

  /// Cart
  static Future<String> addCart(BuildContext context, Cart cart) async {
    // current의 store_id와 같지 않은 cart 문서들 모두 삭제한 뒤 추가
    var u = UserProvider.of(context);
    String currentStoreId = u.currentStore.storeId ?? "";
    final ref = db.collection('user').doc(u.uid).collection("cart");
    final query = ref.where('store_id', isNotEqualTo: currentStoreId);
    QuerySnapshot querySnapshot = await query.get();
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.delete();
    }

    DocumentReference<Cart> docRef = await db
        .collection("user")
        .doc(u.uid)
        .collection("cart")
        .withConverter(
            fromFirestore: Cart.fromFirestore,
            toFirestore: (Cart docs, options) => cart.toFirestore())
        .add(cart);
    debugPrint("장바구니 저장됨");
    u.setCart();
    u.setIsCartAdded(true);
    // if(!(isThenOrder ?? false)) {
    //   snackBar(context, '장바구니에 상품을 담았습니다.',
    //       label: '보러가기',
    //       onClick: () => Navigator.pushNamed(context, RouteName.cart));
    // }

    return docRef.id;
  }

  static void deleteCartDoc(BuildContext context, String orderId, String uid) {
    var u = UserProvider.of(context);
    db
        .collection('user')
        .doc(uid)
        .collection("cart")
        .doc(orderId)
        .delete()
        .then(
          (doc) => debugPrint("Document deleted"),
          onError: (e) => debugPrint("Error updating document $e"),
        );
    u.setCart();
  }

  // 수량 업데이트
  static void updateOrderQuantity(String orderId, String uid, {bool isPlus = true}) {
    var orderDataRef =
        db.collection('user').doc(uid).collection('cart').doc(orderId);

    if (isPlus) {
      orderDataRef.update(
        {"quantity": FieldValue.increment(1)},
      );
      debugPrint('수량 추가됨');
    } else {
      orderDataRef.update(
        {"quantity": FieldValue.increment(-1)},
      );
      debugPrint('수량 감소됨');
    }
  }

  static Future<List<Cart>> getCart(String uid) async {
    final ref = db.collection('user').doc(uid).collection('cart');

    try {
      var querySnapshot = await ref.get();
      debugPrint("getCart: Successfully completed");
      List<Cart> cartList = [];
      for (var docSnapshot in querySnapshot.docs) {
        Cart cart = Cart.fromFirestore(docSnapshot, null);
        cartList.add(cart);
      }
      return cartList;
    } catch (e) {
      debugPrint("getCart: Error completing: $e");
      return []; // 에러 발생 시 빈 리스트 반환하거나 예외처리에 맞게 반환
    }
  }

  /// 결제
  static void addPaymentsBasicInfo(
      String userEmailId, Payments payments) async {
    await db
        .collection("user")
        .doc(userEmailId)
        .collection('payments')
        .withConverter(
            fromFirestore: Payments.fromFirestore,
            toFirestore: (Payments payments, options) => payments.toFirestore())
        .doc(userEmailId)
        .set(payments);
    debugPrint("basicInfo 저장됨");
  }

  /// 주문
  static void addOrder(OrderData od) async {
    await db
        .collection('order')
        .withConverter(
            fromFirestore: OrderData.fromFirestore,
            toFirestore: (OrderData od, option) => od.toFirestore())
        .add(od)
        .then((value) => debugPrint('파이어베이스에 주문 저장됨 $value'));
  }

  /// 쿠폰
  // 쿠폰 생성
  static void addCoupon(Coupon coupon) async {
    await FirebaseFirestore.instance
        .collection("coupon")
        .withConverter(
            fromFirestore: Coupon.fromFirestore,
            toFirestore: (Coupon coupon, options) => coupon.toFirestore())
        .add(coupon);
    debugPrint("쿠폰 저장됨");
  }

  // 전체 쿠폰
  static Future<List<Coupon>> getCoupons() async {
    List<Coupon> coupons = [];
    db.collection("coupon").get().then(
      (querySnapshot) {
        debugPrint("get coupons");
        for (var docSnapshot in querySnapshot.docs) {
          Coupon coupon = Coupon.fromFirestore(docSnapshot, null);
          coupons.add(coupon);
        }
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
    return coupons;
  }

  // static Future<List<Coupon>> getCoupons(String userEmailId) async {
  //   List<Coupon> userCoupons = await getUserCoupons(userEmailId);
  //
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //       await db.collection("coupon").get();
  //
  //   List<Coupon> coupons = querySnapshot.docs
  //       .map((docSnapshot) => Coupon.fromFirestore(docSnapshot, null))
  //       .where((coupon) => !userCoupons
  //           .any((userCoupon) => userCoupon.couponId == coupon.couponId))
  //       .toList();
  //
  //   return coupons;
  // }

  // 유저 쿠폰
  static Future<List<Coupon>> getUserCoupons(String userEmail) async {
    final userDoc = await getUserDoc(userEmail);
    List<Coupon> userCoupons = [];
    userDoc.reference.collection("coupon").get().then(
      (querySnapshot) {
        debugPrint("get user coupons");
        for (var docSnapshot in querySnapshot.docs) {
          // debugPrint('${docSnapshot.id} => ${docSnapshot.data()}');
          Coupon userCoupon = Coupon.fromFirestore(docSnapshot, null);
          userCoupons.add(userCoupon);
          // debugPrint(userCoupon);
        }
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
    return userCoupons;
  }

// static void updateStoreData(
//     String storeId, double latitude, double longitude) {
//   FirebaseFirestore db = FirebaseFirestore.instance;
//   final storeRef = db.collection("store").doc(storeId);
//
//   Store store = Store();
//   Map<String, dynamic> updatedData = store.toFirestore();
//   // updatedData["latitude"] = latitude;
//   // updatedData["longitude"] = longitude;
//
//   storeRef.update(updatedData).then((value) {
//     debugPrint("Document successfully updated!");
//   }, onError: (e) {
//     debugPrint("Error updating document: $e");
//   });
// }

// 유저 등록
// static void addUser(User user) async {
//   await FirebaseFirestore.instance
//       .collection("user")
//       .withConverter(
//           fromFirestore: User.fromFirestore,
//           toFirestore: (User user, options) => user.toFirestore())
//       .doc(user.userEmailId)
//       .set(user);
//   debugPrint("addUser: 유저 저장됨");
// }

// static Future<User> getUserDoc(String userEmailId) async {
//   final ref = db.collection("user").doc(userEmailId).withConverter(
//         fromFirestore: User.fromFirestore,
//         toFirestore: (User user, _) => user.toFirestore(),
//       );
//   try {
//     final docSnap = await ref.get();
//     final user = docSnap.data(); // Convert to User object
//     if (user != null) {
//       return user;
//     } else {
//       debugPrint("No such document.");
//       return User();
//     }
//   } catch (e) {
//     debugPrint("Error getting user document: $e");
//     return User(); // or throw an exception based on your error handling strategy
//   }
// }

// static Future<User?> getUser(String? userEmail) async {
//   // if (userEmail != null) {
//     QuerySnapshot<User> users = await db
//         .collection("user")
//         .where("user_email", isEqualTo: userEmail)
//         .withConverter(
//         fromFirestore: User.fromFirestore,
//         toFirestore: (User user, _) => user.toFirestore())
//         .get();
//     if (users.size == 1) {
//       print("${users.docs.first.data()}");
//       return users.docs.first.data();
//     } else {
//       for (var docSnapshot in users.docs) {
//         print('${docSnapshot.id} => ${docSnapshot.data()}');
//       }
//     }
// }
// if (userEmailId != null) {
//     final ref = db.collection("user").doc(userEmailId).withConverter(
//           fromFirestore: User.fromFirestore,
//           toFirestore: (User user, _) => user.toFirestore(),
//         );
//     try {
//       final docSnap = await ref.get();
//       final user = docSnap.data(); // Convert to User object
//       if (user != null) {
//         return user;
//       } else {
//         debugPrint("No such document.");
//         return null;
//       }
//     } catch (e) {
//       debugPrint("Error getting user document: $e");
//       return null; // or throw an exception based on your error handling strategy
//     }
// }
//   return null;
// }

// // 컬렉션 삭제
//   static Future<void> deleteAllDocumentsInCartCollection(BuildContext context) async {
//     var u = UserProvider.of(context);
//     String uid = u.uid;
//
//     // 컬렉션 참조 얻기
//     CollectionReference cartCollection = FirebaseFirestore.instance
//         .collection("user")
//         .doc(uid)
//         .collection("cart");
//
//     // 컬렉션의 모든 문서 가져오기
//     QuerySnapshot querySnapshot = await cartCollection.get();
//
//     // 각 문서를 삭제
//     for (QueryDocumentSnapshot doc in querySnapshot.docs) {
//       await doc.reference.delete();
//     }
//
//     print("컬렉션의 모든 문서 삭제 완료");
//   }
//
// // 호출 예시
// //   await deleteAllDocumentsInCartCollection(context);

}