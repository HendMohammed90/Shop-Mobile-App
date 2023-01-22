import 'package:shop_app/data/models/login_model.dart';
import 'package:shop_app/data/models/regester_model.dart';

abstract class ShopAppLoginStates {}

class ShopAppInitialState extends ShopAppLoginStates {}

class ShopAppLoadingState extends ShopAppLoginStates {}

class ShopAppSuccessState extends ShopAppLoginStates {
  final LoginModel loginModel;
  ShopAppSuccessState(this.loginModel);
}

class ShopAppErrorState extends ShopAppLoginStates {
  final String error;
  ShopAppErrorState(this.error);
}

class ShopAppRegisterLoadingState extends ShopAppLoginStates {}

class ShopAppRegisterSuccessState extends ShopAppLoginStates {
  final RegisterModel registerModel;
  ShopAppRegisterSuccessState(this.registerModel);
}

class ShopAppRegisterErrorState extends ShopAppLoginStates {
  final String error;
  ShopAppRegisterErrorState(this.error);
}
