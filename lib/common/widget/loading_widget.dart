import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tingle/utils/color.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitCircle(
        color: color ?? AppColor.primary,
        size: size ?? 60,
      ),
    );
  }
}
