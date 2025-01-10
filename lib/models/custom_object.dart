import 'package:cloud_firestore/cloud_firestore.dart';

class City {
  final String? name;
  final String? state;
  final String? country;
  final bool? capital;
  final int? population;
  final List<String>? regions;

  City({
    this.name,
    this.state,
    this.country,
    this.capital,
    this.population,
    this.regions,
  });

  factory City.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return City(
      name: data?['name'],
      state: data?['state'],
      country: data?['country'],
      capital: data?['capital'],
      population: data?['population'],
      regions:
      data?['regions'] is Iterable ? List.from(data?['regions']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (state != null) "state": state,
      if (country != null) "country": country,
      if (capital != null) "capital": capital,
      if (population != null) "population": population,
      if (regions != null) "regions": regions,
    };
  }

  // 데이터 변환 함수를 사용하여 문서 참조를 만든다. 이 참조를 사용하여 수행하는 읽기 작업은 커스텀 클래스의 인스턴스를 반환한다.
  // Future<void> readDocforModel() async {
  //   final ref = FirebaseFirestore.instance.collection("cities").doc("LA").withConverter(
  //     fromFirestore: City.fromFirestore,
  //     toFirestore: (City city, _) => city.toFirestore(),
  //   );
  //   final docSnap = await ref.get();
  //   final city = docSnap.data(); // Convert to City object
  //   if (city != null) {
  //     print(city);
  //   } else {
  //     print("No such document.");
  //   }
  // }
}