import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constats.dart';
import 'package:shop_app/data/models/favorite_data_model.dart';
import 'package:shop_app/layout/shop_app/cubit/app-cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/app-state.dart';

class Favourite extends StatelessWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // var model = ShopAppCubit.get(context).favouriteModel!.data!.data;
        return Container(
          child: ConditionalBuilder(
            condition: state is! ShopAppGetFavoriteLoadingState,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => buildFavouritListItem(
                    ShopAppCubit.get(context).favouriteModel!.data!.data[index],
                    context),
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: ShopAppCubit.get(context)
                    .favouriteModel!
                    .data!
                    .data
                    .length),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}

Widget buildFavouritListItem(FavoritesData? model, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      child: Row(
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
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Text(
                      '${model.product!.price}',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Constants.mainColor,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    // if (model.discount != 0)
                    Text(
                      '${model.product!.oldPrice}',
                      style: const TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        // print(ShopAppCubit.get(context)
                        //     .favorites[model.product!.id]);
                        ShopAppCubit.get(context)
                            .changeFavoriteData(model.product!.id!);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor: ShopAppCubit.get(context)
                                .favorites[model.product!.id]!
                            ? Constants.mainColor
                            : Colors.grey,
                        // backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          size: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
