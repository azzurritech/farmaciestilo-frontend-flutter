import 'dart:convert';

import 'dart:ui';

import 'package:farmacie_stilo/controller/location_controller.dart';
import 'package:farmacie_stilo/controller/splash_controller.dart';
import 'package:farmacie_stilo/data/api/api_client.dart';
import 'package:farmacie_stilo/data/model/response/address_model.dart';
import 'package:farmacie_stilo/data/model/response/language_model.dart';
import 'package:farmacie_stilo/util/app_constants.dart';
import 'package:farmacie_stilo/view/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;

  LocalizationController(
      {required this.sharedPreferences, required this.apiClient}) {
    loadCurrentLanguage();
  }

  Locale? _locale  ;
  bool _isLtr = true;
  List<LanguageModel> _languages = [];

  Locale? get locale => _locale;
  bool get isLtr => _isLtr;
  List<LanguageModel> get languages => _languages;

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    if (_locale?.languageCode == 'ar') {
      _isLtr = false;
    } else {
      _isLtr = true;
    }
    AddressModel? addressModel;
    try {
      addressModel = AddressModel.fromJson(
          jsonDecode(sharedPreferences.getString(AppConstants.userAddress)!));
    } catch (_) {}
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstants.token),
      addressModel?.zoneIds,
      addressModel?.areaIds,
      locale.languageCode,
      Get.find<SplashController>().module != null
          ? Get.find<SplashController>().module!.id
          : null,
      addressModel?.latitude,
      addressModel?.longitude,
    );
    saveLanguage(_locale);
    if (Get.find<LocationController>().getUserAddress() != null) {
      HomeScreen.loadData(true);
    }

    update();
  }
 void clearLocale() async {
  
   await sharedPreferences.remove(AppConstants.languageCode);
   await sharedPreferences.remove(AppConstants.countryCode);
    _locale = window.locale;
update();
  }
  void loadCurrentLanguage() async {
   
          _locale = Locale(
        sharedPreferences.getString(AppConstants.languageCode) ??
           window.locale.languageCode,
        sharedPreferences.getString(AppConstants.countryCode) ??
            window.locale.countryCode);
    
  

    _isLtr = _locale?.languageCode != 'ar';
    for (int index = 0; index < AppConstants.languages.length; index++) {
      if (AppConstants.languages[index].languageCode == _locale?.languageCode) {
        _selectedIndex = index;
        break;
      }
    }
    _languages = [];
    _languages.addAll(AppConstants.languages);
    update();
  }

  void saveLanguage(Locale? locale) async {
   sharedPreferences.setString(AppConstants.languageCode, locale!.languageCode);
    sharedPreferences.setString(AppConstants.countryCode, locale.countryCode!); 
  }

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void searchLanguage(String query) {
    if (query.isEmpty) {
      _languages = [];
      _languages = AppConstants.languages;
    } else {
      _selectedIndex = -1;
      _languages = [];
      for (var language in AppConstants.languages) {
        if (language.languageName!
            .toLowerCase()
            .contains(query.toLowerCase())) {
          _languages.add(language);
        }
      }
    }
    update();
  }
}



// class Datas{
//   String? name;
//   Datas({
//    this.name,
//   });
//  Datas.fromMap(Map<String, dynamic> dataMap) {
//     name = dataMap['name'];
//   }
// void data(){
//   print("Testing");
// }
// }
// class Ad extends Datas{

// @override
// data(){
//   print("zxc");
// }
// }