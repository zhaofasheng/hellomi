import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';

// class ForgotOtpVarificationScreen extends StatelessWidget {
//   const ForgotOtpVarificationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.white,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: AppColor.white,
//           shadowColor: AppColor.black.withOpacity(0.4),
//           surfaceTintColor: AppColor.white,
//           // flexibleSpace: const SimpleAppBarUi(title: ""),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         child: GestureDetector(
//           onTap: () => FocusScope.of(context).unfocus(),
//           child: Container(
//             color: Colors.transparent,
//             height: MediaQuery.of(context).size.height,
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Enter verification code",
//                     style: AppFontStyle.styleW900(AppColor.black, 36),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     "Enter the code we just sent to your phone number.",
//                     style: AppFontStyle.styleW400(AppColor.grayText, 16),
//                   ),
//                   const SizedBox(height: 15),
//                   Text(
//                     "+91-XXXXXXXXXX will receive the code",
//                     style: AppFontStyle.styleW500(AppColor.black, 15),
//                   ),
//                   const SizedBox(height: 35),
//                   OtpTextField(
//                     numberOfFields: 6,
//                     fillColor: AppColor.transparent,
//                     borderRadius: BorderRadius.circular(8),
//                     fieldWidth: 45,
//                     cursorColor: AppColor.primary,
//                     focusedBorderColor: AppColor.primary,
//                     showFieldAsBox: true,
//                     onCodeChanged: (String code) {},
//                     onSubmit: (String otpCode) {
//                       print("OTP submitted: $otpCode");
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   GestureDetector(
//                     onTap: () {
//                       print("Resend tapped");
//                     },
//                     child: Text(
//                       "Resend code",
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                         color: AppColor.red,
//                         decoration: TextDecoration.underline,
//                         fontFamily: AppConstant.appFontMedium,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: SizedBox(
//         height: 86,
//         child: Align(
//           alignment: Alignment.bottomCenter,
//           child: GestureDetector(
//             onTap: () {
//               print("Submit tapped");
//             },
//             child: Container(
//               height: 56,
//               width: MediaQuery.of(context).size.width / 1.5,
//               margin: const EdgeInsets.symmetric(vertical: 15),
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: AppColor.primary,
//                 // gradient: AppColor.primaryLinearGradient,
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: Text(
//                 EnumLocal.txtSubmit.name.tr,
//                 style: AppFontStyle.styleW600(AppColor.white, 19),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
