import 'package:shop_app/constats.dart';
import 'package:shop_app/data/web_services/dio_helper.dart';

class CategoryRepo {
  static Future getCategoryData() async {
    try {
      final result = await DioHelper.getData(url: Constants.categoriesEndPoint);
      return result;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
