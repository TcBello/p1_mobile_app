import 'package:flutter/foundation.dart';
import 'package:p1_mobile_app/model/entities/hive_user_entity.dart';
import 'package:p1_mobile_app/model/repositories/base_auth.dart';
import 'package:p1_mobile_app/utils/is_logged_in_util.dart';
import 'package:p1_mobile_app/utils/toast_util.dart';

class AuthRepository implements BaseAuth {
  @override
  bool isLoggedIn() {
    return IsLoggedInUtil.isLoggedIn();
  }

  @override
  Future<bool> login(String email, String password) async {
    try {
      var currentUsers = HiveUserEntity.get() ?? [];
      HiveUserEntity? user;

      for (var currentUser in currentUsers) {
        if (currentUser.email == email && currentUser.password == password) {
          user = currentUser;
          break;
        }
      }

      if (user != null) {
        await IsLoggedInUtil.setIsLogin(true);
        return true;
      } else {
        ToastUtil.showLong("Wrong credentials");
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      ToastUtil.showLong(e.toString());
    }

    return false;
  }

  @override
  Future<bool> register(String email, String password) async {
    try {
      var currentUsers = HiveUserEntity.get() ?? [];
      HiveUserEntity? user;

      for (var currentUser in currentUsers) {
        if (currentUser.email == email) {
          user = currentUser;
          break;
        }
      }

      if (user == null) {
        var hiveUser = HiveUserEntity(email: email, password: password);
        await HiveUserEntity.put(hiveUser);
        await IsLoggedInUtil.setIsLogin(true);
        return true;
      } else {
        ToastUtil.showLong("Existing email is found");
      }
    } catch (e) {
      debugPrint(e.toString());
      ToastUtil.showLong(e.toString());
    }

    return false;
  }

  @override
  Future<bool> logout() async {
    try {
      await IsLoggedInUtil.setIsLogin(false);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      ToastUtil.showLong(e.toString());
    }

    return false;
  }
}
