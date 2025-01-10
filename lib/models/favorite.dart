import 'package:cloud_firestore/cloud_firestore.dart';

class Favorite {
  Timestamp? timestamp;
  final String? favoriteId;
  late final String uid;
  late final String storeId;
  late final String? favoriteDesc;

  Favorite({
    this.timestamp,
    this.favoriteId,
    required this.uid,
    required this.storeId,
    this.favoriteDesc,
  });

  factory Favorite.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Favorite(
      favoriteId: snapshot.id,
      uid: data?['uid'],
      storeId: data?['store_id'],
      favoriteDesc: data?['favorite_desc'],
      timestamp: data?['timestamp'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "timestamp": Timestamp.now(),
      if (uid != null) "uid": uid,
      if (storeId != null) "store_id": storeId,
      if (favoriteDesc != null) "favorite_desc": favoriteDesc,
    };
  }
}