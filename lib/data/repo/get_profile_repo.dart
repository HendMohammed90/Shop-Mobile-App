import 'package:shop_app/constats.dart';
import 'package:shop_app/data/web_services/dio_helper.dart';

class ProfileRepo {
  static Future getProfileData(tokenData) async {
    try {
      final result = await DioHelper.getData(
          url: Constants.profileEndPoint, token: tokenData);
      return result;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
