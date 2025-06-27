import 'package:tingle/utils/utils.dart';

class FollowUnfollowToast {
  static void onShow({
    required String name,
    required bool isFollow,
  }) {
    if (isFollow) {
      Utils.showToast(text: "You are now following $name");
    } else {
      Utils.showToast(text: "You have unfollowed following $name");
    }
  }
}
