import 'package:flutter/material.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/on_boarding/on_boarding.dart';
import 'package:shop_app/shared/cache_wrapper.dart';

class Constants {
  static const kApi = 'https://student.valuxapps.com/api/';
  static const loginEndPoint = 'login';
  static const homeEndPoint = 'home';
  static const categoriesEndPoint = 'categories';
  static const favoriteEndPoint = 'favorites';
  static const profileEndPoint = 'profile';
  static const registerEndPoint = 'register';
  static const cartEndPoint = 'carts';
  static const searchEndPoint = 'products/search';

  // static const token = '';

  static const mainColor = Colors.green;
  static const whiteColor = Colors.white;
  static const blackColor = Colors.black;

  static void signOut(context) {
    CacheWrapper.clearData().then((value) {
      if (value) {
        print('GOOD BUY');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OnBoarding(),
            ));
      }
    });
  }
}

String? token = '';

// https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=cadf9f9b30754500adea102e2eb31c8b

// https://newsapi.org/v2/everything?q=tesla&apiKey=cadf9f9b30754500adea102e2eb31c8b
