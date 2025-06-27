import 'package:get/get.dart';
import 'package:tingle/page/coin_seller_page/controller/coin_seller_controller.dart';

class CoinSellerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoinSellerController>(() => CoinSellerController());
  }
}
