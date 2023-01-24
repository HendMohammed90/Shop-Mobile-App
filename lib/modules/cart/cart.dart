import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constats.dart';
import 'package:shop_app/data/models/cart_model.dart';
import 'package:shop_app/layout/shop_app/cubit/app-cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/app-state.dart';
import 'package:shop_app/shared/components/components.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // var model = ShopAppCubit.get(context).favouriteModel!.data!.data;
        return Column(
          children: [
            Expanded(
              child: ConditionalBuilder(
                  condition: state is! ShopAppGetCartLoadingState,
                  builder: (context) => ListView.separated(
                      itemBuilder: (context, index) => buildCartListItem(
                          ShopAppCubit.get(context)
                              .cartModel!
                              .data!
                              .cartItems![index],
                          context),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                      itemCount: ShopAppCubit.get(context)
                          .cartModel!
                          .data!
                          .cartItems!
                          .length),
                  fallback: (context) => Center(
                        child: CircularProgressIndicator(),
                      )),
            ),
            const SizedBox(
              height: 20.0,
            ),
            defaultButton(
              text: 'Check Out',
              onTap: () {},
            ),
          ],
        );
      },
    );
  }
}

Widget buildCartListItem(CartItems? model, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(
                      '${model!.product!.image}',
                    ),
                    width: 100,
                    height: 100.0,
                  ),
                  if (model.product!.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.all(5.0),
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(fontSize: 10.0, color: Colors.white),
                      ),
                    ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${model.product!.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${model.product!.price!.round()}',
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Constants.mainColor,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            print(model.id);
                            // print(ShopAppCubit.get(context).cart[model.id]);
                            ShopAppCubit.get(context)
                                .changecartData(model.product!.id!);
                          },
                          icon: CircleAvatar(
                            radius: 15.0,
                            // backgroundColor: Colors.grey,
                            backgroundColor: ShopAppCubit.get(context)
                                    .cart[model.product!.id]!
                                ? Constants.mainColor
                                : Colors.grey,
                            child: Icon(
                              Icons.add_shopping_cart_sharp,
                              size: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // print(ShopAppCubit.get(context).favorites[model.id]);
                            ShopAppCubit.get(context)
                                .changeFavoriteData(model.product!.id!);
                          },
                          icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor: ShopAppCubit.get(context)
                                    .favorites[model.product!.id]!
                                ? Constants.mainColor
                                : Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              size: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        if (model.product!.discount != 0)
                          Text(
                            '${model.product!.oldPrice!.round()}',
                            style: const TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
