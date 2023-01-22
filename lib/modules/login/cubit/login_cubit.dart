import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constats.dart';
import 'package:shop_app/data/models/login_model.dart';
import 'package:shop_app/data/models/regester_model.dart';
import 'package:shop_app/data/repo/login_repo.dart';
import 'package:shop_app/data/repo/register_repo.dart';
import 'package:shop_app/modules/login/cubit/login_states.dart';

class LoginCubit extends Cubit<ShopAppLoginStates> {
  LoginCubit() : super(ShopAppInitialState());
  late LoginModel loginModel;
  late RegisterModel registerModel;

  static LoginCubit get(context) => BlocProvider.of(context);
  bool obscurePassword = true;
  IconData suffex = Icons.visibility_off_outlined;

  void login({required String email, required String password}) {
    emit(ShopAppLoadingState());
    LoginRepo.login(email, password).then((value) {
      // print(value);
      loginModel = LoginModel.fromJson(value.data);
      emit(ShopAppSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppErrorState(error));
    });
  }

  void register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String image,
  }) {
    emit(ShopAppRegisterLoadingState());
    RegisterRepo.register(name, phone, email, password, image).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      print(registerModel);
      emit(ShopAppRegisterSuccessState(registerModel));
    }).catchError((error) {
      print(error);
      emit(ShopAppRegisterErrorState(error));
    });
  }
}
