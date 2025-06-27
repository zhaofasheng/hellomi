import 'package:get/get.dart';
import 'package:tingle/page/audio_wise_videos_page/controller/audio_wise_videos_controller.dart';

class AudioWiseVideosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AudioWiseVideosController>(() => AudioWiseVideosController());
  }
}
