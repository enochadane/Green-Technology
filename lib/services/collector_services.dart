import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firestore_example/model/company.dart';

class CompanyServices {
  static final CollectionReference collectorService =
      FirebaseFirestore.instance.collection('companies').withConverter<Company>(
            fromFirestore: (snapshot, _) =>
                Company.fromJson(snapshot.data()!, snapshot.reference.id),
            toFirestore: (product, _) => product.toJson(),
          );
  Future<dynamic> getComments(String userId) async {
    var data = await collectorService.get().then((value) => value.docs);
    return data;
  }

  Future<void> deleteCompany(String collectorId) async {
    await collectorService.doc(collectorId).delete();
  }

  Future<void> addCompany(Company collector) async {
    await collectorService.add(Company);
  }

  Future<void> updateCompany(Company collector) async {
    await collectorService.doc(collector.uid).update(collector.toJson());
  }
}
