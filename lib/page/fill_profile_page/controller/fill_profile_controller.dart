import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tingle/branch_io/branch_io_services.dart';
import 'package:tingle/common/api/apply_referral_code_api.dart';
import 'package:tingle/common/model/apply_referral_code_model.dart';
import 'package:tingle/custom/function/custom_image_picker.dart';
import 'package:tingle/custom/widget/custom_image_picker_bottom_sheet_widget.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/fill_profile_page/api/edit_profile_api.dart';
import 'package:tingle/page/fill_profile_page/model/edit_profile_model.dart';
import 'package:tingle/page/login_page/api/check_user_name_api.dart';
import 'package:tingle/page/login_page/api/fetch_login_user_profile_api.dart';
import 'package:tingle/page/login_page/model/check_user_name_model.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FillProfileController extends GetxController {
  String token = "";
  String uid = "";

  // Get Argument Values....

  String defaultProfileImage = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController countryNameController = TextEditingController();
  TextEditingController countryFlagController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isMale = true;

  EditProfileModel? editProfileModel;
  String? pickImage;

  bool? isValidUserName;
  RxBool isCheckingUserName = false.obs;
  CheckUserNameModel? checkUserNameModel;

  bool isAppliedReferralCode = false;
  ApplyReferralCodeModel? applyReferralCodeModel;

  @override
  void onInit() {
    defaultProfileImage = FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.image ?? "";
    nameController = TextEditingController(text: FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.name ?? "");
    userNameController = TextEditingController(text: FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.userName ?? "");
    emailController = TextEditingController(text: FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.email ?? "");
    phoneController = TextEditingController(text: FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.mobileNumber ?? "");
    ageController = TextEditingController(text: (FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.age ?? 0).toString());
    isMale = FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.gender?.trim().toLowerCase() != ApiParams.female;

    final String countryName = FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.country?.trim() ?? "";
    final String countryFlag = FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.countryFlagImage?.trim() ?? "";

    countryNameController = TextEditingController(text: countryName.isNotEmpty ? countryName : Utils.defaultCountryName);
    countryFlagController = TextEditingController(text: countryFlag.isNotEmpty ? countryFlag : Utils.defaultCountryFlag);

    bioController = TextEditingController(text: FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.bio ?? "");

    referralCodeController = TextEditingController(text: BranchIoServices.referralCode);

    init();
    super.onInit();
  }

  Future<void> init() async {
    uid = FirebaseUid.onGet() ?? "";
    token = await FirebaseAccessToken.onGet() ?? "";
  }

  void onChangeGender(bool isMale) {
    this.isMale = isMale;
    update([AppConstant.onChangeGender]);
  }

  void onPickImage({required BuildContext context}) async {
    await CustomImagePickerBottomSheetWidget.show(
      context: context,
      onClickCamera: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.camera);
        if (imagePath != null) {
          pickImage = imagePath;
          update([AppConstant.onPickImage]);
        }
      },
      onClickGallery: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.gallery);
        if (imagePath != null) {
          pickImage = imagePath;
          update([AppConstant.onPickImage]);
        }
      },
    );
  }

  Future<void> onChangeUserName() async {
    if (userNameController.text.trim().isNotEmpty) {
      await 500.milliseconds.delay();

      isCheckingUserName.value = true;
      checkUserNameModel = await CheckUserNameApi.callApi(userName: userNameController.text.trim(), uid: uid, token: token);
      isValidUserName = checkUserNameModel?.status ?? false;

      isCheckingUserName.value = false;
    } else {
      isValidUserName = false;
      isCheckingUserName.value = false;
    }
  }

  void onSaveProfile() async {
    await onChangeUserName();

    if (nameController.text.trim().isEmpty) {
      Utils.showToast(text: EnumLocal.txtPleaseEnterYourName.name.tr);
    } else if (userNameController.text.trim().isEmpty) {
      Utils.showToast(text: EnumLocal.txtPleaseEnterUserName.name.tr);
    } else if (ageController.text.trim().isEmpty) {
      Utils.showToast(text: EnumLocal.txtPleaseEnterAge.name.tr);
    } else {
      Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

      editProfileModel = await EditProfileApi.callApi(
        name: nameController.text.trim(),
        userName: userNameController.text.trim(),
        uid: uid,
        token: token,
        gender: isMale ? "Male" : "Female",
        age: ageController.text.trim(),
        image: pickImage,
        country: countryNameController.text,
        countryFlagImage: countryFlagController.text,
        bio: bioController.text,
      );

      Get.back(); // Stop Loading...
    }

    if (editProfileModel?.status == true) {
      Get.offAllNamed(AppRoutes.bottomBarPage);
      FetchLoginUserProfileApi.callApi(token: token, uid: uid);
    } else {
      Utils.showToast(text: editProfileModel?.message ?? "");
    }
  }

  Future<void> onChangeCountry(BuildContext context) async {
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: AppColor.white,
        textStyle: AppFontStyle.styleW500(AppColor.black, 15),
        bottomSheetHeight: Get.height / 1.5,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        inputDecoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          labelText: EnumLocal.txtSearch.name.tr,
          hintText: EnumLocal.txtTypeSomething.name.tr,
          prefixIcon: const Icon(Icons.search),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: AppColor.secondary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: AppColor.secondary),
          ),
        ),
      ),
      onSelect: (Country country) {
        countryNameController = TextEditingController(text: country.name);
        countryFlagController = TextEditingController(text: country.flagEmoji);
        update([AppConstant.onChangeCountry]);
        Utils.showLog("Selected Country => ${countryNameController.text} : ${countryFlagController.text}");
      },
    );
  }

  Future<void> onApplyReferralCode() async {
    if (isAppliedReferralCode == false) {
      await init();
      applyReferralCodeModel = await ApplyReferralCodeApi.callApi(token: token, uid: uid, referralCode: referralCodeController.text.trim());
      if (applyReferralCodeModel?.status == true) isAppliedReferralCode = true;
      if (applyReferralCodeModel?.message != null) Utils.showToast(text: applyReferralCodeModel?.message ?? "");
      update([AppConstant.onApplyReferralCode]);
    }
  }
}
