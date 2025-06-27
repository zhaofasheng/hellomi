import 'package:flutter/material.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/utils.dart';

Future<Locale> getLocale() async {
  String languageCode = Database.selectedLanguage;
  String countryCode = Database.selectedCountryCode;

  Utils.showLog("Selected Language => $languageCode >>> $countryCode");
  return _locale(languageCode, countryCode);
}

Locale _locale(String languageCode, String countryCode) {
  return languageCode.isNotEmpty ? Locale(languageCode, countryCode) : const Locale(AppConstant.languageEn, AppConstant.countryCodeEn);
}
