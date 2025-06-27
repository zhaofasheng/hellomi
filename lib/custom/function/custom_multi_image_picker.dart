import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/utils/utils.dart';

class CustomMultiImagePicker {
  static Future<List<String>> pickImage() async {
    List<String> selectedImages = [];
    try {
      Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

      final images = await ImagePicker().pickMultiImage(limit: 5);

      Get.back(); // Stop Loading...

      if (images.isNotEmpty) {
        Utils.showLog("Pick Multi Image Length => ${images.length}");

        for (int index = 0; index < (images.length < 5 ? images.length : 5); index++) {
          selectedImages.add(images[index].path);
        }
        Utils.showLog("Pick Multi Image Path => $selectedImages");
        return selectedImages;
      } else {
        Utils.showLog("Image Not Selected !!");
        return [];
      }
    } catch (e) {
      Utils.showLog("Multi Image Picker Error => $e");
      return [];
    }
  }
}
