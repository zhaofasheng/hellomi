import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/localization/localizations_delegate.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';

class LanguageController extends GetxController {
  LanguageModel? languageModel;
  String? languageCode;
  String? countryCode;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  final List countryFlags = [
    AppAssets.icArabia,
    AppAssets.icBangladesh,
    AppAssets.icChinese,
    AppAssets.icUnitedStates,
    AppAssets.icFrance,
    AppAssets.icGermany,
    AppAssets.icIndia,
    AppAssets.icItalian,
    AppAssets.icIndonesia,
    AppAssets.icJapan,
    AppAssets.icKorean,
    AppAssets.icLaowo,
    AppAssets.icIndia,
    AppAssets.icBrazil,
    AppAssets.icRussian,
    AppAssets.icSpain,
    AppAssets.icSwahili,
    AppAssets.icTurkey,
    AppAssets.icIndia,
    AppAssets.icIndia,
    AppAssets.icPakistan,
  ];

  void init() {
    languageCode = Database.selectedLanguage;
    countryCode = Database.selectedCountryCode;
    languageModel = languages.where((element) => (element.languageCode == languageCode && element.countryCode == countryCode)).toList()[0];
    update([AppConstant.onChangeLanguage]);
  }

  void onChangeLanguage(LanguageModel value) {
    languageModel = value;
    Database.onSetSelectedLanguage(languageModel!.languageCode);
    Database.onSetSelectedCountryCode(languageModel!.countryCode);

    Get.updateLocale(Locale(languageModel!.languageCode, languageModel!.countryCode));
    update([AppConstant.onChangeLanguage]);
  }
}
