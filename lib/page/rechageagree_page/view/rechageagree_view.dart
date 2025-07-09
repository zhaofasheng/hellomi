import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/rechageagree_controller.dart';

class RechageAgreeView extends StatelessWidget {
  const RechageAgreeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RechageAgree')),
      body: Center(child: Text('This is RechageAgree page')),
    );
  }
}
