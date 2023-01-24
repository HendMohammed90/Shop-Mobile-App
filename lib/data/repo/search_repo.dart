import 'package:shop_app/constats.dart';
import 'package:shop_app/data/web_services/dio_helper.dart';

class SearchRepo {
  static Future search(searchItem, tokenData) async {
    try {
      final result = await DioHelper.postData(
          url: Constants.searchEndPoint,
          data: {'text': searchItem},
          token: tokenData);
      return result;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
