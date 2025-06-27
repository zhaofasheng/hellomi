import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print('请传入页面名称，例如： dart tool/page_generator.dart MyProfile');
    return;
  }

  final rawName = args[0];
  final snake = _toSnakeCase(rawName);
  final pascal = _toPascalCase(rawName);
  final folder = 'lib/page/${snake}_page';

  final controllerPath = '$folder/controller/${snake}_controller.dart';
  final bindingPath = '$folder/binding/${snake}_binding.dart';
  final viewPath = '$folder/view/${snake}_view.dart';

  // 创建目录
  Directory('$folder/controller').createSync(recursive: true);
  Directory('$folder/binding').createSync(recursive: true);
  Directory('$folder/view').createSync(recursive: true);

  // 写入 Controller
  File(controllerPath).writeAsStringSync('''
import 'package:get/get.dart';

class ${pascal}Controller extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }
}
''');

  // 写入 Binding
  File(bindingPath).writeAsStringSync('''
import 'package:get/get.dart';
import '../controller/${snake}_controller.dart';

class ${pascal}Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<${pascal}Controller>(() => ${pascal}Controller());
  }
}
''');

  // 写入 View
  File(viewPath).writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/${snake}_controller.dart';

class ${pascal}View extends StatelessWidget {
  const ${pascal}View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('$pascal')),
      body: Center(child: Text('This is $pascal page')),
    );
  }
}
''');

  // 自动更新路由定义和页面注册
  _updateAppRoutes(snake);
  _updateAppPages(snake, pascal);

  print('✅ 页面 "$pascal" 生成完成');
}

String _toSnakeCase(String input) =>
    input.replaceAllMapped(RegExp(r'[A-Z]'), (m) => '_${m.group(0)!.toLowerCase()}').replaceFirst('_', '');

String _toPascalCase(String input) =>
    input.split(RegExp(r'[_\s]')).map((w) => w[0].toUpperCase() + w.substring(1)).join();

void _updateAppRoutes(String snake) {
  final routesFile = File('lib/routes/app_routes.dart');
  final content = routesFile.readAsStringSync();

  final constName = '${snake}Page';
  final routeValue = "'/${snake}_page';";
  final defineLine = "  static const String $constName = $routeValue";

  if (content.contains(defineLine)) {
    print('⚠️ AppRoutes 已包含 $constName，跳过添加');
    return;
  }

  final updated = content.replaceFirstMapped(
    RegExp(r'class AppRoutes\s*\{'),
        (match) => '${match.group(0)}\n$defineLine',
  );

  routesFile.writeAsStringSync(updated);
  print('✅ 已更新 app_routes.dart');
}

void _updateAppPages(String snake, String pascal) {
  final file = File('lib/routes/app_pages.dart');
  var content = file.readAsStringSync();

  final importView = "import 'package:tingle/page/${snake}_page/view/${snake}_view.dart';";
  final importBinding = "import 'package:tingle/page/${snake}_page/binding/${snake}_binding.dart';";

  if (!content.contains(importView)) {
    content = '$importView\n$importBinding\n' + content;
  }

  final getPageCode = '''
    GetPage(
      name: AppRoutes.${snake}Page,
      page: () => const ${pascal}View(),
      binding: ${pascal}Binding(),
    ),''';

  final match = RegExp(r'static var list\s*=\s*\[\n').firstMatch(content);
  if (match != null) {
    final index = match.end;
    content = content.substring(0, index) + getPageCode + '\n' + content.substring(index);
  } else {
    print('❌ 未能定位 AppPages.list，请手动添加页面注册');
  }

  file.writeAsStringSync(content);
  print('✅ 已更新 app_pages.dart');
}