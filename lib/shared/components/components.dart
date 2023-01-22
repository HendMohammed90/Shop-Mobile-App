import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/constats.dart';

// Widget buildArticaleItem(list, context) => InkWell(
//       onTap: () {
//         // Navigator.pushNamed(context, );
//         print('${list['url']}');
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => WebView(
//               url: list['url'],
//               initialUrl: list['url'],
//               URL: list['url'],
//             ),
//           ),
//         );
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(
//           children: [
//             Container(
//               height: 120,
//               width: 120,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 image: DecorationImage(
//                   image: NetworkImage("${list['urlToImage']}"),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 10.0,
//             ),
//             Expanded(
//               child: Container(
//                 height: 120.0,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Text("${list['title']}",
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: Theme.of(context).textTheme.bodyText1),
//                     ),
//                     Text(
//                       "${list['publishedAt']}",
//                       style: TextStyle(
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );

ThemeData lightThem = ThemeData(
  primarySwatch: Colors.green,
  primaryColor: Colors.green,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 25,
    ),
    elevation: 0.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.green,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Colors.green,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.cyan,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.cyan,
  ),
);
ThemeData darkThem = ThemeData(
  primarySwatch: Colors.cyan,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 25,
    ),
    elevation: 0.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.cyan,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Colors.black12,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 20.0,
    selectedItemColor: Colors.cyan,
    unselectedItemColor: Colors.white,
    backgroundColor: Colors.black45,
  ),
);

Widget defaultButton({
  double width = double.infinity,
  Color backGroundColor = Constants.mainColor,
  bool isUpperCase = true,
  double radius = 0.0,
  required void Function() onTap,
  required String text,
}) =>
    Container(
        width: width,
        decoration: BoxDecoration(
            color: backGroundColor,
            borderRadius: BorderRadius.circular(radius)),
        child: MaterialButton(
          onPressed: onTap,
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  GestureTapCallback? onTap,
  bool isPassword = false,
  required FormFieldValidator<String> validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );
