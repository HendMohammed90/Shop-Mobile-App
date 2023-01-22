import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constats.dart';
import 'package:shop_app/layout/shop_app/cubit/app-cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/app-state.dart';
import 'package:shop_app/shared/components/components.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var profileModel = ShopAppCubit.get(context).profileModel;
        nameController.text = profileModel!.data!.name!;
        emailController.text = profileModel.data!.email!;
        phoneController.text = profileModel.data!.phone!;
        return ConditionalBuilder(
          condition: ShopAppCubit.get(context).profileModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  // if(state is ShopLoadingUpdateUserState)
                  //   LinearProgressIndicator(),
                  // if(state is ShopLoadingUpdateUserState)
                  //   const SizedBox(
                  //     height: 20.0,
                  //   ),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: Icons.person,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'email must not be empty';
                      }
                      return null;
                    },
                    label: 'Email Address',
                    prefix: Icons.email,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    label: 'Phone',
                    prefix: Icons.phone,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    // function: () {
                    //   if (formKey.currentState!.validate()) {
                    //     ShopCubit.get(context).updateUserData(
                    //       name: nameController.text,
                    //       email: emailController.text,
                    //       phone: phoneController.text,
                    //     );
                    //   }
                    // },
                    text: 'Update', onTap: () {},
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    text: 'Logout',
                    onTap: () {
                      Constants.signOut(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
