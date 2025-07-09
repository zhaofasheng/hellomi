import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/nohunt_agree_controller.dart';

class NoHuntAgreeView extends StatelessWidget {
  const NoHuntAgreeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NoHuntAgree')),
      body: Center(child: Text('This is NoHuntAgree page')),
    );
  }
}
