import 'package:shop_app/data/models/change_cart_model.dart';
import 'package:shop_app/data/models/change_favorites_model.dart';
import 'package:shop_app/data/models/login_model.dart';
import 'package:shop_app/layout/shop_app/cubit/app-cubit.dart';

abstract class ShopAppStates {}

//Initial states
class ShopAppInitialState extends ShopAppStates {}

//this is not used
// class BottomNavBarState extends AppStates {}

//For NavBar
class ShopChangeBottomNavBarState extends ShopAppStates {}

class ShopAppHomeLoadingState extends ShopAppStates {}

class ShopAppHomeSuccessState extends ShopAppStates {}

class ShopAppHomeErrorState extends ShopAppStates {}

class ShopAppCategorySuccessState extends ShopAppStates {}

class ShopAppCategoryErrorState extends ShopAppStates {}

class ShopAppChangeFavoriteState extends ShopAppStates {}

class ShopAppChangeFavoriteSuccessState extends ShopAppStates {
  ChangeFavoritesModel? changeFavoritesModel;
  ShopAppChangeFavoriteSuccessState({required this.changeFavoritesModel});
}

class ShopAppChangeFavoriteErrorState extends ShopAppStates {}

class ShopAppGetFavoriteLoadingState extends ShopAppStates {}

class ShopAppGetFavoriteSuccessState extends ShopAppStates {}

class ShopAppGetFavoriteErrorState extends ShopAppStates {}

class ShopAppGetUserDataLoadingState extends ShopAppStates {}

class ShopAppGetUserDataSuccessState extends ShopAppStates {
  LoginModel? loginModel;
  ShopAppGetUserDataSuccessState({required this.loginModel});
}

class ShopAppGetUserDataErrorState extends ShopAppStates {
  String? error;
  ShopAppGetUserDataErrorState({required this.error});
}

//Change Mode Light or Dark
class AppChangeThemMode extends ShopAppStates {}

//For Searching
class NewsSearchLoadingState extends ShopAppStates {}

class NewsSearchSuccessState extends ShopAppStates {}

class NewsSearchFailedState extends ShopAppStates {
  final String error;
  NewsSearchFailedState(this.error);
}

class ShopAppChangeCartState extends ShopAppStates {}

class ShopAppChangeCartSuccessState extends ShopAppStates {
  ChangeCartModel? changeCartModel;
  ShopAppChangeCartSuccessState({required this.changeCartModel});
}

class ShopAppChangeCartErrorState extends ShopAppStates {}

class ShopAppGetCartLoadingState extends ShopAppStates {}

class ShopAppGetCartSuccessState extends ShopAppStates {}

class ShopAppGetCartErrorState extends ShopAppStates {}

// class AppUpdateDatabaseState extends AppStates {}
