import 'package:shop_app/constats.dart';
import 'package:shop_app/data/web_services/dio_helper.dart';

import '../models/login_model.dart';

class LoginRepo {
  static Future login(email, password) async {
    try {
      final result = await DioHelper.postData(
        url: Constants.loginEndPoint,
        data: {
          'email': email,
          'password': password,
        },
      );
      return result;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
