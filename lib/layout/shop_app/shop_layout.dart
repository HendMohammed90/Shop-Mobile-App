import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constats.dart';
import 'package:shop_app/layout/shop_app/cubit/app-cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/app-state.dart';
import 'package:shop_app/shared/cache_wrapper.dart';
import '../../modules/search/search.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // token = CacheWrapper.getData(key: 'token');
    // print('Token is $token');
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.home),
            title: const Text('Dokkan Online'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                    // (route) => false,
                  );
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          body: cubit.ourWidgets[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Constants.mainColor,
            currentIndex: cubit.currentIndex,
            onTap: (ind) {
              print(ind);
              cubit.changeIndex(ind);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}

// "username": "johnd", ///1
// "password": "m38rmF$",

// "username": "mor_2314", ////2
// "password": "83r5^_",
