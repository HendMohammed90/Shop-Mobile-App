import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/constats.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/login_cubit.dart';
import 'package:shop_app/modules/login/cubit/login_states.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/cache_wrapper.dart';
import 'package:shop_app/shared/components/components.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController imageController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, ShopAppLoginStates>(
        listener: (context, state) {
          if (state is ShopAppRegisterSuccessState) {
            if (state.registerModel.status != true) {
              /////TODO Show Error Message
              Fluttertoast.showToast(
                  msg: state.registerModel.message!,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              // print(state.loginModel.data!.token);
              Fluttertoast.showToast(
                  msg: state.registerModel.message!,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
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
                          'Register',
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
                          'pleas Register to see our products',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          cursorColor: Constants.mainColor,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Pleas enter your name';
                            }
                            return null;
                          },
                          onFieldSubmitted: (val) => {},
                          onSaved: (val) => {},
                          onChanged: (val) => {},
                          onTap: () => {},
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Your name',
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
                          controller: phoneController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          cursorColor: Constants.mainColor,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Pleas enter your phone';
                            }
                            return null;
                          },
                          onFieldSubmitted: (val) => {},
                          onSaved: (val) => {},
                          onChanged: (val) => {},
                          onTap: () => {},
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Your phone',
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Constants.mainColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
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
                              Icons.email,
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
                            // if (formKey.currentState!.validate())
                            //   {
                            //     LoginCubit.get(context).login(
                            //         email: emailController.text,
                            //         password: passwordController.text)
                            //   }
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
                            suffixIconColor: Colors.green,
                            suffix: Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.green,
                            ),
                          ),

                          /////////
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          controller: imageController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Pleas enter your image';
                            }
                            return null;
                          },
                          onFieldSubmitted: (val) => {
                            // if (formKey.currentState!.validate())
                            //   {
                            //     LoginCubit.get(context).login(
                            //         email: emailController.text,
                            //         password: passwordController.text)
                            //   }
                          },
                          onSaved: (val) => {},
                          onChanged: (val) => {},
                          textInputAction: TextInputAction.done,
                          // obscureText: true,
                          cursorColor: Constants.mainColor,
                          decoration: const InputDecoration(
                            labelText: 'Your image',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.image,
                              color: Constants.mainColor,
                            ),
                          ),

                          /////////
                        ),
                        const SizedBox(height: 20.0),
                        Visibility(
                          visible: state is! ShopAppRegisterLoadingState,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: defaultButton(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).register(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    image: imageController.text);
                              }
                            },
                            text: "register".toUpperCase(),
                            backGroundColor: Constants.mainColor,
                            isUpperCase: true,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Have account ? Just Login '),
                            TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                    (route) => false);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Constants.mainColor,
                              ),
                              child: Text(
                                "Login".toUpperCase(),
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
