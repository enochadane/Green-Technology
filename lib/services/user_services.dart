import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firestore_example/model/Profile.dart';
import 'package:flutter_firestore_example/model/user.dart';

class UserServices {
  static final CollectionReference userservice =
      FirebaseFirestore.instance.collection('users');

  Future<User?> signIn(String phone, String password) async {
    var data = await userservice
        .where("phone", isEqualTo: phone)
        .get()
        .then((value) => value.docs.first);
    final user_data = data.data() as Map<String, Object>;
    if (user_data['password'].toString() == password) {
      return new User(
          uid: data.reference.id.toString(),
          name: user_data['name'].toString(),
          phone: phone,
          password: password,
          comments: [],
          role: user_data['role'].toString(),
          profile: {});
    }
    return null;
  }

  Future<void> deleteUser(String userId) async {
    await userservice.doc(userId).delete();
  }

  Future<dynamic> getUser(String userId) async {
    final data = await userservice.doc(userId).get().then((value) => value);

    final userData = data.data() as Map<String, Object>;

    User user = new User(
        uid: data.reference.id.toString(),
        name: userData['name'].toString(),
        phone: userData['phone'].toString(),
        password: userData['password'].toString(),
        comments: userData['comments'] as List<Map<String, dynamic>>,
        role: userData['role'].toString(),
        profile: userData['profile'] as Map<String, dynamic>);

    return user;
  }

  Future<List<dynamic>> getUsers() async {
    final data = await userservice.doc().get().then((value) => value) as List;
    return data;
  }

  Future<dynamic> getProfile(String userId) async {
    User user = await getUser(userId);
    Profile profile = Profile.fromJson(user.profile);
    return profile;
  }

  Future<bool> updateProfile(User user) async {
    try {
      await userservice.doc(user.uid).update({
        "name": user.name,
        "phone": user.phone,
        "password": user.password,
        "role": user.role,
        "comments": user.comments,
        "profile": user.profile
      });
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<void> addUser(Map<String, dynamic> user) async {
    await userservice.add(user);
  }

  Future<dynamic> updateUser(User user) async {
    await userservice.doc(user.uid).update(user.toJson());
  }

  Future<List<Map<String, Object?>>> getNormalUsers() async {
    final data = await userservice
        .where("role", isEqualTo: "NORMAL_USER")
        .get()
        .then((value) => value.docs);
    final result =
        data.map((value) => value.data() as Map<String, dynamic>).toList();
    
    print("As of Minasie's result $result");
    return result;
  }

  Future<void> getCompanies() async {
    await userservice.where("role", isEqualTo: "COMPANY_USER").get();
  }

  Future<void> getCollectors() async {
    await userservice.where("role", isEqualTo: "COLLECTOR_USER").get();
  }
}
