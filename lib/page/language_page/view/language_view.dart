import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/localization/localizations_delegate.dart';
import 'package:tingle/page/language_page/controller/language_controller.dart';
import 'package:tingle/common/widget/simple_app_bar_widget.dart';
import 'package:tingle/page/language_page/widget/language_widget.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBarWidget.onShow(context: context, title: EnumLocal.txtLanguages.name.tr),
      body: SingleChildScrollView(
        child: GetBuilder<LanguageController>(
          id: AppConstant.onChangeLanguage,
          builder: (controller) => Column(
            children: [
              for (int i = 0; i < languages.length; i++)
                ItemsView(
                  icon: controller.countryFlags[i],
                  title: languages[i].language,
                  isSelected: languages[i] == controller.languageModel,
                  callback: () => controller.onChangeLanguage(languages[i]),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
