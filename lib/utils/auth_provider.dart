import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_firestore_example/model/user.dart';
import 'package:flutter_firestore_example/services/user_services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum Status { Authenticated, Authenticating, Unauthenticated }

class UserRepository with ChangeNotifier {
  User? _authenticatedUser;
  Status _status = Status.Unauthenticated;

  Status get status => _status;
  User? get authenticatedUser => _authenticatedUser;

  Future<bool> signIn(String phone, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      UserServices _userService = new UserServices();
      // _userService.
      final user = await _userService.signIn(phone, password);
      if (user != null) {
        _status = Status.Authenticated;
        _authenticatedUser = user;
        storeUserToStorage(user);
        notifyListeners();
      } else {
        _status = Status.Unauthenticated;
        notifyListeners();
      }

      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    clearStorage();
    _status = Status.Unauthenticated;
    _authenticatedUser = null;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future updateProfile(User user) async {
    try {
      UserServices _userService = new UserServices();
      await _userService.updateProfile(user);
    } catch (e) {}
  }

  Future getUserFromStorage() async {
    final user = await getUserDataFromStorage();
    if (user != null) {
      this._authenticatedUser = user;
      this._status = Status.Authenticated;
      notifyListeners();
    }
  }

  Future<User?> getUserDataFromStorage() async {
    final storage = new FlutterSecureStorage();
    var userData = await storage.read(key: "logged_in_user");
    if (userData != null) {
      var data = jsonDecode(userData);
      try {
        final result = new User(
            uid: data["uid"],
            name: data["name"],
            password: data["password"],
            phone: data["phone"],
            role: data["role"],
            comments: [],
            profile: {});

        return result;
      } catch (error) {
        print("the error is $error");
      }
    } else {
      return null;
    }
  }

  Future<void> clearStorage() async {
    final storage = new FlutterSecureStorage();
    await storage.delete(
      key: 'logged_in_user',
    );
  }

  void storeUserToStorage(User user) async {
    final storage = new FlutterSecureStorage();
    var resBody = {};
    resBody["uid"] = user.uid;
    resBody["name"] = user.name;
    resBody["role"] = user.role;
    resBody["phone"] = user.phone;
    resBody["password"] = user.password;
    resBody["profile"] = user.profile;
    resBody["comments"] = user.comments;
    String str = json.encode(resBody);
    await storage.write(key: 'logged_in_user', value: str);
  }
}
