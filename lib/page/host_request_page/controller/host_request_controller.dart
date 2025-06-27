import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/host_request_page/api/apply_host_request_api.dart';
import 'package:tingle/page/host_request_page/api/validate_agency_api.dart';
import 'package:tingle/page/host_request_page/model/apply_host_request_model.dart';
import 'package:tingle/page/host_request_page/model/validate_agency_model.dart';
import 'package:tingle/page/profile_page/controller/profile_controller.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class HostRequestController extends GetxController {
  TextEditingController agencyCodeController = TextEditingController();
  TextEditingController uniqueIdController = TextEditingController();

  bool? isValidAgency;
  RxBool isCheckingAgency = false.obs;

  ValidateAgencyModel? validateAgencyModel;

  ApplyHostRequestModel? applyHostRequestModel;

  final controller = Get.find<ProfileController>();

  @override
  void onInit() {
    uniqueIdController = TextEditingController(text: controller.fetchUserProfileModel?.user?.uniqueId ?? "");
    super.onInit();
  }

  Future<void> onChangeAgencyId() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (agencyCodeController.text.trim().isNotEmpty) {
      await 500.milliseconds.delay();

      isCheckingAgency.value = true;

      final uid = FirebaseUid.onGet() ?? "";
      final token = await FirebaseAccessToken.onGet() ?? "";

      validateAgencyModel = await ValidateAgencyApi.callApi(
        token: token,
        uid: uid,
        uniqueId: uniqueIdController.text.trim(),
        agencyCode: agencyCodeController.text.trim(),
      );

      isValidAgency = validateAgencyModel?.status ?? false;

      isCheckingAgency.value = false;
    } else {
      isValidAgency = false;
      isCheckingAgency.value = false;
    }
  }

  void onClickSendRequest() async {
    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    if (uniqueIdController.text.trim().isEmpty) {
      Utils.showToast(text: EnumLocal.txtPleaseEnterUniqueId.name.tr);
    } else if (agencyCodeController.text.trim().isEmpty) {
      Utils.showToast(text: EnumLocal.txtPleaseEnterAgencyCode.name.tr);
    } else {
      Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

      applyHostRequestModel = await ApplyHostRequestApi.callApi(
        token: token,
        uid: uid,
        uniqueId: uniqueIdController.text.trim(),
        agencyCode: agencyCodeController.text.trim(),
      );

      Get.back(); // Stop Loading...

      Utils.showToast(text: applyHostRequestModel?.message ?? "");

      if (applyHostRequestModel?.status == true) Get.back();
    }
  }
}
