import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class CustomCopyText {
  static void onCopy({required String text}) {
    Clipboard.setData(ClipboardData(text: text));
    Utils.showToast(text: EnumLocal.txtCopiedOnClipboard.name.tr);
  }
}
