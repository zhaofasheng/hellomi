import 'package:tingle/common/model/fetch_other_user_profile_model.dart';
import 'package:tingle/database/fake_data/user_fake_data.dart';

class HostComment {
  String message;
  String user;
  String image;
  int type;
  String userId;
  String emoji;

  HostComment({
    required this.message,
    required this.user,
    required this.userId,
    required this.image,
    this.type = 1,
    this.emoji = "",
  });
}

// Generate fake users
List<FetchOtherUserProfileModel> fakeuser = FakeProfilesSet().generateUserProfiles(100).take(50).toList();

// Extract user names and images
List<String> messages = ["How are You?", "Hello Dear", "9876543210 it is my mobile number", "Your Hotness is beating me everytime?", "i drop my cap for you?", "classy shot and awesome background too", "give me your mobile number", "can we talk?", "looking very very hot", "let's hangout", "Joined"];

List<HostComment> fakeHostCommentList = List.generate(50, (index) {
  final user = fakeuser[index % fakeuser.length];
  final message = messages[index % messages.length];
  return HostComment(
    message: message,
    userId: user.user?.id ?? "",
    user: user.user?.name ?? "Anonymous",
    image: user.user?.image ?? "", // Make sure `image` is a string URL
  );
});
