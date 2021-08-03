import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firestore_example/model/company.dart';

class CompanyServices {
  static final CollectionReference companyService =
      FirebaseFirestore.instance.collection('companies').withConverter<Company>(
            fromFirestore: (snapshot, _) =>
                Company.fromJson(snapshot.data()!, snapshot.reference.id),
            toFirestore: (company, _) => company.toJson(),
          );
  Future<dynamic> getComments(String userId) async {
    var data = await companyService.get().then((value) => value.docs);
    return data;
  }

  Future<void> deleteCompany(String collectorId) async {
    await companyService.doc(collectorId).delete();
  }

  Future<void> addCompany(Company company) async {
    await companyService.add(company);
  }

  Future<void> updateCompany(Company collector) async {
    await companyService.doc(collector.uid).update(collector.toJson());
  }
}
