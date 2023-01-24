import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/models/cart_model.dart';
import 'package:shop_app/data/models/category_model.dart';
import 'package:shop_app/data/models/change_cart_model.dart';
import 'package:shop_app/data/models/change_favorites_model.dart';
import 'package:shop_app/data/models/favorite_data_model.dart';
import 'package:shop_app/data/models/home_model.dart';
import 'package:shop_app/data/models/login_model.dart';
import 'package:shop_app/data/models/search_model_data.dart';
import 'package:shop_app/data/repo/cart_repo.dart';
import 'package:shop_app/data/repo/category_repo.dart';
import 'package:shop_app/data/repo/favorit_repo.dart';
import 'package:shop_app/data/repo/get_profile_repo.dart';
import 'package:shop_app/data/repo/home_repo.dart';
import 'package:shop_app/data/repo/search_repo.dart';
import 'package:shop_app/layout/shop_app/cubit/app-state.dart';
import 'package:shop_app/modules/cart/cart.dart';
import 'package:shop_app/modules/category/category.dart';
import 'package:shop_app/modules/favourite/favourite.dart';
import 'package:shop_app/modules/products/products.dart';
import 'package:shop_app/modules/settings/settings.dart';
import 'package:shop_app/shared/cache_wrapper.dart';

class ShopAppCubit extends Cubit<ShopAppStates> {
  ShopAppCubit() : super(ShopAppInitialState());

  static ShopAppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> ourWidgets = [
    const Products(),
    const Categories(),
    const Favourite(),
    const CartPage(),
    const Settings(),
  ];

  Map<int, bool> favorites = {};
  Map<int, bool> cart = {};
  List<dynamic> searchList = [];

  //Function to change screens
  void changeIndex(index) {
    currentIndex = index;
    emit(ShopChangeBottomNavBarState());
  }

  HomeModel? homeModel;

  //function to get homePage Data
  void getData() {
    emit(ShopAppHomeLoadingState());
    var tokenn = CacheWrapper.getData(key: 'token');
    HomeRepo.getHomeData(tokenn).then((value) {
      // print(value);
      homeModel = HomeModel.fromJson(value.data);
      // print(homeModel!.data);
      homeModel!.data.products.forEach((element) {
        favorites.addAll({element.id: element.favorites});
        // print('favorites is $favorites');
        cart.addAll({element.id: element.inCart});
        // print('cart Data is $cart');
      });

      emit(ShopAppHomeSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopAppHomeErrorState());
    });
  }

  CategoryModel? categoryModel;

  //function to get Categories Data
  void getCategoryData() {
    emit(ShopAppHomeLoadingState());
    CategoryRepo.getCategoryData().then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      // print(categoryModel);
      emit(ShopAppCategorySuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppCategoryErrorState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

//Function to change Favorite Items
  void changeFavoriteData(int productID) {
    favorites[productID] = !favorites[productID]!;

    emit(ShopAppChangeFavoriteState());
    var tokenn = CacheWrapper.getData(key: 'token');
    FavoritesRepo.changeFavoriteData(productID, tokenn).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel!.status!) {
        favorites[productID] = !favorites[productID]!;
      } else {
        getFavouriteData();
      }
      emit(ShopAppChangeFavoriteSuccessState(
          changeFavoritesModel: changeFavoritesModel));
    }).catchError((e) {
      print(e.toString());
      favorites[productID] = !favorites[productID]!;
      emit(ShopAppChangeFavoriteErrorState());
    });
  }

  FavoriteModel? favouriteModel;
//Function to get Favorite Items
  void getFavouriteData() {
    emit(ShopAppGetFavoriteLoadingState());
    var tokenn = CacheWrapper.getData(key: 'token');
    FavoritesRepo.getFavoriteData(tokenn).then((value) {
      favouriteModel = FavoriteModel.fromJson(value.data);
      // print(favouriteModel!.data!.data);
      emit(ShopAppGetFavoriteSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(ShopAppChangeFavoriteErrorState());
    });
  }

  LoginModel? profileModel;

  //function to get homePage Data
  void getProfileData() {
    emit(ShopAppGetUserDataLoadingState());
    var token = CacheWrapper.getData(key: 'token');
    ProfileRepo.getProfileData(token).then((value) {
      profileModel = LoginModel.fromJson(value.data);
      print(profileModel!.data!.name);
      emit(ShopAppGetUserDataSuccessState(loginModel: profileModel));
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopAppGetUserDataErrorState(error: onError));
    });
  }

  ChangeCartModel? changeCartModel;

//Function to change Cart Items
  void changecartData(int productID) {
    cart[productID] = !cart[productID]!;

    emit(ShopAppChangeCartState());
    var token = CacheWrapper.getData(key: 'token');
    CartRepo.changeCartData(productID, token).then(
      (value) {
        changeCartModel = ChangeCartModel.fromJson(value.data);
        print(changeCartModel!.message);
        if (!changeCartModel!.status!) {
          cart[productID] = !cart[productID]!;
        } else {
          getCartData();
        }
        emit(
          ShopAppChangeCartSuccessState(changeCartModel: changeCartModel),
        );
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(ShopAppChangeCartErrorState());
      },
    );
  }

  CartModel? cartModel;
//Function to get cart Items
  void getCartData() {
    emit(ShopAppGetCartLoadingState());
    var token = CacheWrapper.getData(key: 'token');
    CartRepo.getCartData(token).then((value) {
      cartModel = CartModel.fromJson(value.data);
      // print('CART ITEMS IS ${cartModel!.data!.cartItems}');
      emit(ShopAppGetCartSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(ShopAppGetCartErrorState());
    });
  }

  SearchModel? searchModel;

  void search(String searchItem) {
    emit(ShopAppSearchLoadingState());
    var token = CacheWrapper.getData(key: 'token');
    searchList = [];
    SearchRepo.search(searchItem, token).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      // print(searchModel!.data!.data);
      emit(ShopAppSearchSuccessState());
    }).catchError((error) {
      print(error);
      emit(ShopAppSearchFailedState(error));
    });
  }

//   bool isDark = false;
//
//   void changeMode() {
//     isDark = !isDark;
//     CacheWrapper.putUserMoode(key: 'isDark', value: isDark).then(
//       (value) {
//         emit(AppChangeThemMode());
//         print(value);
//       },
//     );
//   }
}
