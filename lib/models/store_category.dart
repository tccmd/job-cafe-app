import 'package:cloud_firestore/cloud_firestore.dart';

class StoreCategory {
  final String? storeId;
  final List<Map>? coffee;
  final List<Map>? dessert;
  final List<Map>? etc;
  final List<Map>? goods;
  final List<Map>? nonCoffee;
  final List<Map>? seasonMenu;
  final List<Map>? signature;

  StoreCategory(
      {this.storeId,
      this.coffee,
      this.dessert,
      this.etc,
      this.goods,
      this.nonCoffee,
      this.seasonMenu,
      this.signature});

  factory StoreCategory.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return StoreCategory(
      storeId: data?['store_id'] ?? '',
      coffee: data?['coffee'] is Iterable ? List.from(data?['coffee']) : null,
      dessert:
          data?['dessert'] is Iterable ? List.from(data?['dessert']) : null,
      etc: data?['etc'] is Iterable ? List.from(data?['etc']) : null,
      goods: data?['goods'] is Iterable ? List.from(data?['goods']) : null,
      nonCoffee: data?['non_coffee'] is Iterable
          ? List.from(data?['non_coffee'])
          : null,
      seasonMenu: data?['season_menu'] is Iterable
          ? List.from(data?['season_menu'])
          : null,
      signature:
          data?['signature'] is Iterable ? List.from(data?['signature']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (storeId != null) "store_id": storeId,
      if (coffee != null) "coffee": coffee,
      if (dessert != null) "dessert": dessert,
      if (etc != null) "etc": etc,
      if (goods != null) "goods": goods,
      if (nonCoffee != null) "non_coffee": nonCoffee,
      if (seasonMenu != null) "season_menu": seasonMenu,
      if (signature != null) "signature": signature,
    };
  }
}
