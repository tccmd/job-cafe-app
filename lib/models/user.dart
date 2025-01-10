import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  Timestamp? timestamp;
  final String? uid;
  final String? userPhoneNumber;
  final String? userPhoneId;
  final String? userEmail;
  final String? userEmailId;
  final String? userPassword;
  final String? userBirth;
  final String? userGender;
  final String? userNickname;
  final Map<String, dynamic>? favoriteStoreMap;
  final String? userImgUrl;
  final bool? pushNotificationConsent;
  final bool? promotionEventNotificationsConsent;
  final bool? locationServiceConsent;
  final bool? cupayNotificationsConsent;
  // final int? accumulatedPoints; // 적립금
  // final String? cashReceiptNumber; // 현금영수증번호
  // final List<String>? couponList; // 쿠폰 리스트
  final List<String>? recentStore;

  User({
    this.uid,
    this.userPhoneNumber,
    this.userPhoneId,
    this.userEmail,
    this.userEmailId,
    this.userPassword,
    this.userBirth,
    this.userGender,
    this.userNickname,
    this.favoriteStoreMap,
    this.userImgUrl,
    this.pushNotificationConsent,
    this.promotionEventNotificationsConsent,
    this.locationServiceConsent,
    this.cupayNotificationsConsent,
    // this.accumulatedPoints, this.cashReceiptNumber, this.couponList,
    this.recentStore,
  });

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return User(
      uid: snapshot.id,
      userPhoneNumber: data?['user_phone_number'],
      userPhoneId: data?['user_phone_id'],
      userEmail: data?['user_email'],
      userEmailId: data?['user_email_id'],
      userPassword: data?['user_password'],
      userBirth: data?['user_birth'],
      userGender: data?['user_gender'],
      userNickname: data?['user_nickname'],
      favoriteStoreMap: (data?['favorite_store_map'] as Map<String, dynamic>?)?.cast<String, dynamic>() ?? {},
      userImgUrl: data?['user_img_url'],
      pushNotificationConsent: data?['push_notification_consent'],
      promotionEventNotificationsConsent: data?['promotion_event_notifications_consent'],
      locationServiceConsent: data?['location_service_consent'],
      cupayNotificationsConsent: data?['cupay_notifications_consent'],
      // accumulatedPoints: data?['accumulated_points'],
      // cashReceiptNumber: data?['cash_receipt_number'],
      // couponList: data?['coupon_list'] is Iterable ? List.from(data?['coupon_list']) : null,
      recentStore: data?['recent_store'] is Iterable ? List.from(data?['recent_store']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "timestamp": Timestamp.now(),
      if (uid != null) "uid": uid,
      if (userPhoneNumber != null) "user_phone_number": userPhoneNumber,
      if (userPhoneId != null) "user_phone_id": userPhoneId,
      if (userEmail != null) "user_email": userEmail,
      if (userEmailId != null) "user_email_id": userEmailId,
      if (userPassword != null) "user_password": userPassword,
      if (userBirth != null) "user_birth": userBirth,
      if (userGender != null) "user_gender": userGender,
      if (userNickname != null) "user_nickname": userNickname,
      if (favoriteStoreMap != null) "favorite_store_map": favoriteStoreMap,
      if (userImgUrl != null) "user_img_url": userImgUrl,
      if (pushNotificationConsent != null) "push_notification_consent": pushNotificationConsent,
      if (promotionEventNotificationsConsent != null) "promotion_event_notifications_consent": promotionEventNotificationsConsent,
      if (locationServiceConsent != null) "location_service_consent": locationServiceConsent,
      if (cupayNotificationsConsent != null) "cupay_notifications_consent": cupayNotificationsConsent,
      if (recentStore != null) "recent_store": recentStore,
    };
  }
}
