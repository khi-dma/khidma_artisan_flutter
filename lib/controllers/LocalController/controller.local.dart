import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/models/model.user.dart';
import 'package:get_storage/get_storage.dart';

class LocalController extends GetxController {
  static final box = GetStorage();

  static setToken(String token) {
    box.write("token", token);
  }

  static getToken() {
    return box.read("token");
  }

  static setState(int state) {
    box.write("state", state);
  }

  static getState() {
    return box.read("state");
  }

  static getUid() {
    return box.read("uidFirebase");
  }

  static void setUid(String uid) {
    box.write("uidFirebase", uid);
  }

  static void setProfile(String data) {
    setAvailability(true);
    box.write("profile", data);
  }

  static void setLang(String lang) {
    box.write("lang", lang);
  }

  static getLang() {
    return box.read("lang");
  }

  static currentLang() {
    String lang = box.read("lang") ?? "";
    if (lang == "ar") {
      return const Locale('ar');
    } else if (lang == "en") {
      return const Locale('en', 'US');
    } else {
      return const Locale('fr', 'FR');
    }
  }

  static UserModel getProfile() {
    return UserModel.fromJson(jsonDecode(box.read("profile"))["data"]["User"]);
  }

  static bool getAvailability() {
    return box.read("availability") ?? false;
  }

  static void setAvailability(bool availability) {
    box.write("availability",availability);
  }

  static void clear() {
    setLang('');
    setProfile('');
    setUid('');
    setState(-1);
    setToken('');
  }
}
