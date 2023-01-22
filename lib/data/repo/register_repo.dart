import 'package:shop_app/constats.dart';
import 'package:shop_app/data/web_services/dio_helper.dart';

class RegisterRepo {
  static Future register(name, phone, email, password, image) async {
    try {
      final result = await DioHelper.postData(
        url: Constants.registerEndPoint,
        data: {
          'name': name,
          'phone': phone,
          'email': email,
          'password': password,
          'image': image,
        },
      );
      return result;
    } catch (e) {
      print(
        e.toString(),
      );
      return [];
    }
  }
}
