import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

// class UserRoleWidget extends StatelessWidget {
//   const UserRoleWidget({super.key, this.margin, required this.role});
//
//   final EdgeInsetsGeometry? margin;
//   final int role;
//
//   @override
//   Widget build(BuildContext context) {
//     Utils.showLog("User Role => $role");
//
//     return role > 1
//         ? Container(
//             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
//             margin: margin,
//             decoration: BoxDecoration(
//               color: AppColor.primary.withValues(alpha: 0.1),
//               borderRadius: BorderRadius.circular(100),
//             ),
//             child: Text(
//               onGetRoleType(role),
//               style: AppFontStyle.styleW600(AppColor.primary, 10),
//             ),
//           )
//         : Offstage();
//   }
// }

class UserRoleWidget extends StatelessWidget {
  const UserRoleWidget({
    super.key,
    this.margin,
    required this.roles,
  });

  final EdgeInsetsGeometry? margin;
  final List<dynamic> roles;

  @override
  Widget build(BuildContext context) {
    Utils.showLog("User Roles => $roles");

    // Filter valid roles > 1
    final filteredRoles = roles.where((r) => r > 1).toList();
    if (filteredRoles.isEmpty) return const Offstage();

    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: filteredRoles.map((role) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            color: AppColor.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            onGetRoleType(role),
            style: AppFontStyle.styleW600(AppColor.primary, 10),
          ),
        );
      }).toList(),
    ).marginOnly(
      left: margin?.horizontal ?? 0,
      top: margin?.vertical ?? 0,
    );
  }
}

String onGetRoleType(int value) {
  switch (value) {
    case 1:
      return EnumLocal.txtUser.name.tr;
    case 2:
      return EnumLocal.txtHost.name.tr;
    case 3:
      return EnumLocal.txtAgency.name.tr;
    case 4:
      return EnumLocal.txtCoinTrader.name.tr;
    default:
      return "";
  }
}
