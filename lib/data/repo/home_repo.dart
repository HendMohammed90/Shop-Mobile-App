import 'package:shop_app/constats.dart';
import 'package:shop_app/data/web_services/dio_helper.dart';

class HomeRepo {
  static Future getHomeData(tokenData) async {
    try {
      final result = await DioHelper.getData(
          url: Constants.homeEndPoint, token: tokenData);
      return result;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
