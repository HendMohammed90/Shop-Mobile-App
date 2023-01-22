import 'package:dio/dio.dart';
import 'package:shop_app/constats.dart';
import 'package:http/http.dart' as http;

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: Constants.kApi,
        receiveDataWhenStatusError: true,
        connectTimeout: 20 * 1000,
        receiveTimeout: 20 * 1000,
      ),
    );
  }

  //Get All Data
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = "en",
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? ''
    };
    Response response = await dio.get(url);
    return response;
  }

  //Login Process
  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String lang = "en",
      String? token}) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? ''
    };
    Response response = await dio.post(url, data: data);
    return response;
  }

  Future<String?> get(String url, {Map<String, String>? headers}) async {
    var uri = Uri.parse(url);
    http.Response response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
      // throw HttpError(
      //     status_code: response.statusCode, response: response.body);
    }
  }
}
