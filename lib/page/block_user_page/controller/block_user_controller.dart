import 'package:get/get.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/block_user_page/api/fetch_block_user_api.dart';
import 'package:tingle/page/block_user_page/model/fetch_block_user_model.dart';
import 'package:tingle/utils/constant.dart';

class BlockUserController extends GetxController {
  bool isLoading = false;

  List<BlockedUsers> blockUsers = [];

  FetchBlockUserModel? fetchBlockUserModel;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    onGetBlockUsers();
  }

  Future<void> onGetBlockUsers() async {
    isLoading = true;
    update([AppConstant.onGetBlockUsers]);

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchBlockUserModel = await FetchBlockUserApi.callApi(token: token, uid: uid);

    blockUsers = fetchBlockUserModel?.blockedUsers ?? [];

    isLoading = false;
    update([AppConstant.onGetBlockUsers]);
  }
}
