import 'package:shop_app/constats.dart';
import 'package:shop_app/data/models/home_model.dart';
import 'package:shop_app/data/web_services/dio_helper.dart';

class FavoritesRepo {
  //Change Favourite data
  static Future changeFavoriteData(int productId, tokenData) async {
    try {
      final result = await DioHelper.postData(
          url: Constants.favoriteEndPoint,
          data: {'product_id': productId},
          token: tokenData);
      return result;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  //Get Favourite data
  static Future getFavoriteData(tokenData) async {
    try {
      final result = await DioHelper.getData(
          url: Constants.favoriteEndPoint, token: tokenData);
      return result;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
