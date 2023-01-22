import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constats.dart';
import 'package:shop_app/data/web_services/dio_helper.dart';
import 'package:shop_app/layout/shop_app/cubit/app-cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/app-state.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/modules/on_boarding/on_boarding.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/cache_wrapper.dart';
import 'package:shop_app/shared/components/components.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheWrapper.init();
  Widget? widget;
  bool? onBoarding = await CacheWrapper.getData(key: 'onBoarding');
  token = CacheWrapper.getData(key: 'token');
  print('onBoarding value is $onBoarding and token is $token');
  if (token != null) {
    print(token);
    widget = ShopLayout();
  } else {
    widget = OnBoarding();
  }
  runApp(MyApp(startWidgit: widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidgit;
  MyApp({required this.startWidgit});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopAppCubit()
        ..getData()
        ..getCategoryData()
        ..getFavouriteData()
        ..getCartData()
        ..getProfileData(),
      child: MaterialApp(
        theme: lightThem,
        darkTheme: darkThem,
        themeMode: ThemeMode.light,
        // ShopAppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
        // home: onBoardingData ? OnBoarding() : const LoginPage(),
        home: startWidgit,
      ),
    );
  }
}

//
//       BlocConsumer<ShopAppCubit, AppStates>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           return MaterialApp(
//             theme: lightThem,
//             darkTheme: darkThem,
//             themeMode: ThemeMode.light,
//             // ShopAppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
//             // home: onBoardingData ? OnBoarding() : const LoginPage(),
//             home: startWidgit,
//           );
//         },
//       ),
//     );
//   }
// }
