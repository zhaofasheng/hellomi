
import '../../common/api_service.dart';
import '../../firebase/authentication/firebase_uid.dart';
import '../../utils/api.dart';
import '../../utils/utils.dart';

class NewPayService {
  /// ✅ 单例模式实现
  static final NewPayService _instance = NewPayService._internal();
  factory NewPayService() => _instance;
  NewPayService._internal();


  Future<void> init() async {
  }

  Future<dynamic> newPay({
    required String coinPlanId,
  }) async {

    final url = Api.newPayUri;
    Utils.showLog("Fetch Coin Plan Api Url => $url");
    try {
      // 注意：headers 会自动由 ApiService 拦截器添加
      final response = await ApiService().post(
        url,
        queryParameters:{
          'coinPlanId':coinPlanId,
        },
      );

      if (response?.statusCode == 200) {
        final jsonResponse = response?.data;

        Utils.showLog("Fetch Coin Plan Api Response => ${response?.data}");


      }else {
        Utils.showLog("Fetch Coin Plan Api StatusCode Error => ${response?.statusCode}");
        return response;
      }
    } catch (error) {
      Utils.showLog("Fetch Coin Plan Api Error => $error");
      return null;
    }
  }
}