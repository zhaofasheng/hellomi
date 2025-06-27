import 'dart:math';

import 'package:intl/intl.dart';
import 'package:tingle/common/api/fetch_category_wise_gift_api.dart';
import 'package:tingle/common/model/fake_gift_gallary_model.dart';
import 'package:tingle/common/model/fetch_category_wise_gift_model.dart';
import 'package:tingle/common/model/fetch_gift_gallery_model.dart';
import 'package:tingle/common/model/fetch_other_user_profile_model.dart';

import 'package:tingle/page/audio_room_page/model/live_viewer_user_model.dart';
import 'package:tingle/page/stream_page/model/fetch_live_user_model.dart';
import 'package:tingle/utils/assets.dart';

import '../../page/live_page/model/pk_gift_top_user_model.dart';

class FakeProfilesSet {
  static final List<String> _randomNames = [
    "James Walker",
    "Olivia Green",
    "Liam Carter",
    "Emma Bennett",
    "Noah Morgan",
    "Ava Thompson",
    "Ethan Reed",
    "Sophia Miller",
    "Lucas Taylor",
    "Isabella Moore",
  ];

  static String getName(String inputName) {
    if (inputName.trim().isEmpty) {
      final random = Random();
      return _randomNames[random.nextInt(_randomNames.length)];
    }
    return inputName;
  }

  List<Viewer> viewers = [
    Viewer(
      image: "https://randomuser.me/api/portraits/men/1.jpg",
      isProfilePicBanned: false,
    ),
    Viewer(
      image: "https://randomuser.me/api/portraits/women/2.jpg",
      isProfilePicBanned: false,
    ),
    Viewer(
      image: "https://randomuser.me/api/portraits/men/3.jpg",
      isProfilePicBanned: false,
    ),
    Viewer(
      image: "https://randomuser.me/api/portraits/men/5.jpg",
      isProfilePicBanned: false,
    ),
    Viewer(
      image: "https://randomuser.me/api/portraits/women/8.jpg",
      isProfilePicBanned: false,
    ),
    Viewer(
      image: "https://randomuser.me/api/portraits/women/1.jpg",
      isProfilePicBanned: false,
    ),
    Viewer(
      image: "https://randomuser.me/api/portraits/women/5.jpg",
      isProfilePicBanned: false,
    ),
  ];

  FakeFrameModel rendomFrame() {
    List<FakeFrameModel> frame = [
      FakeFrameModel(
        name: "twin_sepnts",
        image: AppAssets.icFrameTwin,
      ),
      FakeFrameModel(
        name: "",
        image: "",
      ),
      FakeFrameModel(
        name: "mermaid",
        image: AppAssets.icFrameMermaid,
      ),
      FakeFrameModel(
        name: "",
        image: "",
      ),
      FakeFrameModel(
        name: "magic book",
        image: AppAssets.icFrameMegicBook,
      )
    ];
    return frame[Random().nextInt(frame.length)];
  }

  List<LiveViewerUserModel> sampleLiveViewers = [
    LiveViewerUserModel(
      id: "user_01",
      name: "James Walker",
      userName: "james_walker",
      image: "https://randomuser.me/api/portraits/men/1.jpg",
      isProfilePicBanned: false,
      avatarFrame: "frame_gold",
      userId: "001",
    ),
    LiveViewerUserModel(
      id: "user_02",
      name: "Olivia Green",
      userName: "olivia_green",
      image: "https://randomuser.me/api/portraits/women/2.jpg",
      isProfilePicBanned: false,
      avatarFrame: "frame_silver",
      userId: "002",
    ),
    LiveViewerUserModel(
      id: "user_03",
      name: "Liam Carter",
      userName: "liam_carter",
      image: "https://randomuser.me/api/portraits/men/3.jpg",
      isProfilePicBanned: false,
      avatarFrame: "frame_gold",
      userId: "003",
    ),
    LiveViewerUserModel(
      id: "user_04",
      name: "Emma Bennett",
      userName: "emma_bennett",
      image: "https://randomuser.me/api/portraits/women/4.jpg",
      isProfilePicBanned: false,
      avatarFrame: "frame_diamond",
      userId: "004",
    ),
    LiveViewerUserModel(
      id: "user_05",
      name: "Noah Morgan",
      userName: "noah_morgan",
      image: "https://randomuser.me/api/portraits/men/5.jpg",
      isProfilePicBanned: false,
      avatarFrame: "frame_bronze",
      userId: "005",
    ),
    LiveViewerUserModel(
      id: "user_06",
      name: "Ava Thompson",
      userName: "ava_thompson",
      image: "https://randomuser.me/api/portraits/women/6.jpg",
      isProfilePicBanned: false,
      avatarFrame: "frame_none",
      userId: "006",
    ),
    LiveViewerUserModel(
      id: "user_07",
      name: "Ethan Reed",
      userName: "ethan_reed",
      image: "https://randomuser.me/api/portraits/men/7.jpg",
      isProfilePicBanned: true,
      avatarFrame: "frame_silver",
      userId: "007",
    ),
    LiveViewerUserModel(
      id: "user_08",
      name: "Sophia Miller",
      userName: "sophia_miller",
      image: "https://randomuser.me/api/portraits/women/8.jpg",
      isProfilePicBanned: false,
      avatarFrame: "frame_gold",
      userId: "008",
    ),
    LiveViewerUserModel(
      id: "user_09",
      name: "Lucas Taylor",
      userName: "lucas_taylor",
      image: "https://randomuser.me/api/portraits/men/9.jpg",
      isProfilePicBanned: false,
      avatarFrame: "frame_diamond",
      userId: "009",
    ),
    LiveViewerUserModel(
      id: "user_10",
      name: "Isabella Moore",
      userName: "isabella_moore",
      image: "https://randomuser.me/api/portraits/women/10.jpg",
      isProfilePicBanned: true,
      avatarFrame: "frame_bronze",
      userId: "010",
    ),
  ];
  List<PkGiftTopUserModel> topGiftUsers = [
    PkGiftTopUserModel(
      userId: UserId(
        id: "user_001",
        name: "Alice Green",
        image: "https://randomuser.me/api/portraits/women/1.jpg",
        isProfilePicBanned: false,
      ),
      totalCoins: 1200,
      id: "gift_001",
    ),
    PkGiftTopUserModel(
      userId: UserId(
        id: "user_002",
        name: "Brian Clark",
        image: "https://randomuser.me/api/portraits/men/2.jpg",
        isProfilePicBanned: false,
      ),
      totalCoins: 980,
      id: "gift_002",
    ),
    PkGiftTopUserModel(
      userId: UserId(
        id: "user_003",
        name: "Catherine Smith",
        image: "https://randomuser.me/api/portraits/women/3.jpg",
        isProfilePicBanned: true,
      ),
      totalCoins: 870,
      id: "gift_003",
    ),
    PkGiftTopUserModel(
      userId: UserId(
        id: "user_004",
        name: "David Johnson",
        image: "https://randomuser.me/api/portraits/men/4.jpg",
        isProfilePicBanned: false,
      ),
      totalCoins: 750,
      id: "gift_004",
    ),
    PkGiftTopUserModel(
      userId: UserId(
        id: "user_005",
        name: "Ella Brown",
        image: "https://randomuser.me/api/portraits/women/5.jpg",
        isProfilePicBanned: false,
      ),
      totalCoins: 680,
      id: "gift_005",
    ),
  ];

  List<String> sampleNames = ["Olivia Martin", "Liam Smith", "Emma Johnson", "Noah Brown", "Ava Davis", "William Miller", "Sophia Wilson", "James Moore", "Isabella Taylor", "Lucas Anderson"];

  List<String> sampleImages = [
    "https://randomuser.me/api/portraits/women/10.jpg",
    "https://randomuser.me/api/portraits/men/11.jpg",
    "https://randomuser.me/api/portraits/women/12.jpg",
    "https://randomuser.me/api/portraits/men/13.jpg",
    "https://randomuser.me/api/portraits/women/14.jpg",
    "https://randomuser.me/api/portraits/men/15.jpg",
    "https://randomuser.me/api/portraits/women/16.jpg",
    "https://randomuser.me/api/portraits/men/17.jpg",
    "https://randomuser.me/api/portraits/women/18.jpg",
    "https://randomuser.me/api/portraits/men/19.jpg",
  ];

  List<PkGiftTopUserModel> generateRandomTopGiftUsers({int count = 5}) {
    sampleImages.shuffle();
    sampleNames.shuffle();
    final random = Random();
    return List.generate(count, (index) {
      return PkGiftTopUserModel(
        userId: UserId(
          id: "user_${100 + index}",
          name: sampleNames[index % sampleNames.length],
          image: sampleImages[index % sampleImages.length],
          isProfilePicBanned: false,
        ),
        totalCoins: 500 + random.nextInt(1000), // between 500 and 1499
        id: "gift_${100 + index}",
      );
    });
  }

  List<Seat> generateRandomSeats({int count = 40}) {
    final random = Random();
    final sampleNames = [
      'John Smith',
      'Emily Davis',
      'Michael Johnson',
      'Sarah Brown',
      'David Wilson',
      'Olivia Moore',
      'Daniel Taylor',
      'Emma Clark',
      'James Miller',
      'Sophia Lee',
      'Liam Harris',
      'Isabella Young',
      'Noah Hall',
      'Mia Allen',
      'Lucas Wright',
      'Ava Scott',
      'Logan Adams',
      'Charlotte Baker',
      'Ethan Campbell',
      'Amelia Mitchell',
      'Jacob Roberts',
      'Harper Turner',
      'Alexander Phillips',
      'Evelyn Parker',
      'William Evans',
      'Ella Edwards',
      'Benjamin Collins',
      'Lily Stewart',
      'Matthew Sanchez',
      'Aria Morris',
      'Joseph Rogers',
      'Grace Cook',
      'Samuel Rivera',
      'Chloe Morgan',
      'Owen Reed',
      'Sofia Bell',
      'Henry Murphy',
      'Scarlett Bailey',
      'Jayden Rivera',
      'Victoria Cooper'
    ];

    final sampleImages = List.generate(
      count,
      (index) => 'https://randomuser.me/api/portraits/${index % 2 == 0 ? 'men' : 'women'}/${index % 100}.jpg',
    );

    return List.generate(count, (index) {
      return Seat(
        id: "seat_${index + 1}",
        position: index + 1,
        mute: random.nextBool() ? 1 : 0,
        lock: random.nextBool(),
        reserved: random.nextBool(),
        speaking: random.nextBool(),
        invite: random.nextBool(),
        userId: random.nextBool() ? "user_${index + 100}" : null,
        name: sampleNames[index % sampleNames.length],
        image: sampleImages[index],
        agoraUid: 10000 + index,
        coin: random.nextInt(1000), // coin between 0 to 999
      );
    });
  }

  static FakeFetchGiftCategoryModel? fetchGiftCategoryModel;

  static List<Datas>? categorygift = [];
  static List<CategoryWiseGift>? Giftdata = [];
  FetchCategoryWiseGiftModel? local;

  dataGift(token, uid) async {
    categorygift!.forEach(
      (element) async {
        local = await FetchCategoryWiseGiftApi.callApi(token: token, uid: uid, giftCategoryId: element.id ?? "");
        Giftdata!.addAll(local!.data!);

        local = null;
      },
    );
  }

  static FetchGiftGalleryModel generateSampleGiftGalleryModel({int count = 3}) {
    List<Data> giftList = List.generate(Giftdata!.length, (index) {
      final id = Giftdata![index].id ?? "";
      final date = DateTime.now().subtract(Duration(days: index));
      final formattedDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(date);

      return Data(
        id: id,
        totalGiftCount: Random().nextInt(10) + 1,
        latestDate: formattedDate,
        giftId: id,
        giftTitle: Giftdata![index].title ?? "",
        giftImage: Giftdata![index].image ?? "",
        giftCoin: Giftdata![index].coin,
        giftType: Giftdata![index].type, // types from 1 to 4
      );
    });

    return FetchGiftGalleryModel(
      status: true,
      message: "",
      data: giftList,
    );
  }

  final random = Random();

  List<FetchOtherUserProfileModel> generateUserProfiles(int count) {
    List<String> sampleNames = [
      'Michael Johnson',
      'Daniel Taylor',
      'Isabella Young',
      'Charlotte Baker',
      'Amelia Mitchell',
      'Alexander Phillips',
      'Benjamin Collins',
      'Matthew Sanchez',
      'Joseph Rogers',
      'Samuel Rivera',
      'Victoria Cooper',
      'William Evans',
      'Chloe Morgan',
      'Evelyn Parker',
      'Scarlett Bailey',
      'Lily Stewart',
      'John Smith',
      'Emily Davis',
      'Sarah Brown',
      'David Wilson',
      'Olivia Moore',
      'Emma Clark',
      'James Miller',
      'Sophia Lee',
      'Liam Harris',
      'Noah Hall',
      'Mia Allen',
      'Lucas Wright',
      'Ava Scott',
      'Logan Adams',
      'Ethan Campbell',
      'Harper Turner',
      'Ella Edwards',
      'Aria Morris',
      'Grace Cook',
      'Owen Reed',
      'Sofia Bell',
      'Henry Murphy',
      'Jayden Rivera',
      'Grace Cook',
    ];

    final sampleImages = List.generate(
      count,
      (index) => 'https://randomuser.me/api/portraits/${index % 2 == 0 ? 'men' : 'women'}/${index % 100}.jpg',
    );

    return List.generate(count, (index) {
      final name = sampleNames[index % sampleNames.length];
      final image = sampleImages[index % sampleImages.length];
      final isMale = image.contains("men");

      return FetchOtherUserProfileModel(
        status: true,
        message: "Profile loaded",
        user: User(
          id: "user_id_$index",
          name: name,
          userName: "user_${name.toLowerCase().replaceAll(' ', '_')}_$index",
          gender: isMale ? "Male" : "Female",
          age: 18 + random.nextInt(30),
          image: image,
          isProfilePicBanned: false,
          countryFlagImage: "https://flagcdn.com/w320/${["us", "ca", "gb", "au", "in"][index % 5]}.png",
          country: ["USA", "Canada", "UK", "Australia", "India"][index % 5],
          uniqueId: random.nextInt(100000000).toString(),
          coin: 500 + random.nextInt(9500),
          wealthLevel: WealthLevel(
            id: "wealth_${index + 1}",
            levelImage: "https://example.com/wealth/level_${(index % 5) + 1}.png",
          ),
          isVerified: false,
          totalFollowers: random.nextInt(1000),
          totalFollowing: random.nextInt(5000),
          totalFriends: random.nextInt(2000),
          totalVisitors: random.nextInt(1500),
          isFollowed: index % 3 == 0,
        ),
      );
    });
  }
}

class FakeFrameModel {
  final String? name;
  final String? image;

  FakeFrameModel({
    this.name,
    this.image,
  });

  factory FakeFrameModel.fromJson(Map<String, dynamic> json) {
    return FakeFrameModel(
      name: json['name']?.toString(),
      image: json['image']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
    };
  }
}
