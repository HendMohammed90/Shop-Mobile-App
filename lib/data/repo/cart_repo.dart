import 'package:shop_app/constats.dart';
import 'package:shop_app/data/web_services/dio_helper.dart';

class CartRepo {
  //Change Favourite data
  static Future changeCartData(int productId, tokenData) async {
    try {
      final result = await DioHelper.postData(
          url: Constants.cartEndPoint,
          data: {'product_id': productId},
          token: tokenData);
      return result;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  //Get Cart data
  static Future getCartData(tokenData) async {
    try {
      final result = await DioHelper.getData(
          url: Constants.cartEndPoint, token: tokenData);
      return result;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
