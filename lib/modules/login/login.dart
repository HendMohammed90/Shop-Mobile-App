import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constats.dart';
import 'package:shop_app/modules/login/cubit/login_cubit.dart';
import 'package:shop_app/modules/login/cubit/login_states.dart';
import 'package:shop_app/modules/register/register.dart';
import 'package:shop_app/shared/cache_wrapper.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../layout/shop_app/shop_layout.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, ShopAppLoginStates>(
        listener: (context, state) {
          if (state is ShopAppSuccessState) {
            if (state.loginModel.status != true) {
              /////TODO Show Error Message
              Fluttertoast.showToast(
                  msg: state.loginModel.message!,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              // print(state.loginModel.data!.token);
              Fluttertoast.showToast(
                  msg: state.loginModel.message!,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.deepPurple,
                  textColor: Colors.white,
                  fontSize: 16.0);
              CacheWrapper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
                print('token is $token');
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ShopLayout(),
                  ),
                );
              });
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Login',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 40,
                                    color: Constants.mainColor,
                                  ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'pleas login to see our products',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          cursorColor: Constants.mainColor,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Pleas enter your email';
                            }
                            return null;
                          },
                          onFieldSubmitted: (val) => {},
                          onSaved: (val) => {},
                          onChanged: (val) => {},
                          onTap: () => {},
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Your email',
                            prefixIcon: Icon(
                              Icons.person,
                              color: Constants.mainColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: LoginCubit.get(context).obscurePassword,
                          controller: passwordController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Pleas enter your password';
                            }
                            return null;
                          },
                          onFieldSubmitted: (val) => {
                            if (formKey.currentState!.validate())
                              {
                                LoginCubit.get(context).login(
                                    email: emailController.text,
                                    password: passwordController.text)
                              }
                          },
                          onSaved: (val) => {},
                          onChanged: (val) => {},
                          textInputAction: TextInputAction.done,
                          // obscureText: true,
                          cursorColor: Constants.mainColor,
                          decoration: const InputDecoration(
                            labelText: 'Your password',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Constants.mainColor,
                            ),
                            suffixIconColor: Colors.deepPurple,
                            /////TODO Here we have to make function in cubit to change the suffix icon
                            suffix: Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.deepPurple,
                            ),
                          ),

                          /////////
                        ),
                        const SizedBox(height: 20.0),
                        Visibility(
                          visible: state is! ShopAppLoadingState,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: defaultButton(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).login(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            text: "Login".toUpperCase(),
                            backGroundColor: Constants.mainColor,
                            isUpperCase: true,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Don\'t have account ? '),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const Signup(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Constants.mainColor,
                              ),
                              child: Text(
                                "Sign Up".toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
