import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/constats.dart';
import 'package:shop_app/data/models/category_model.dart';
import 'package:shop_app/data/models/home_model.dart';
import 'package:shop_app/layout/shop_app/cubit/app-cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/app-state.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if (state is ShopAppChangeFavoriteSuccessState) {
          Fluttertoast.showToast(
              msg: state.changeFavoritesModel!.message!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Constants.mainColor,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        if (state is ShopAppChangeCartSuccessState) {
          Fluttertoast.showToast(
              msg: state.changeCartModel!.message!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Constants.mainColor,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopAppCubit.get(context).homeModel != null &&
              ShopAppCubit.get(context).categoryModel != null,
          builder: (context) => homeBuilderWidget(
              ShopAppCubit.get(context).homeModel!,
              ShopAppCubit.get(context).categoryModel!,
              context),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

Widget homeBuilderWidget(
    HomeModel homemodel, CategoryModel categoryModel, BuildContext context) {
  return Column(children: [
    CarouselSlider(
        items: homemodel.data.banners
            .map((banner) => Image(
                  image: NetworkImage('${banner.image}'),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ))
            .toList(),
        options: CarouselOptions(
          height: 200,
          // aspectRatio: 16 / 9,
          viewportFraction: 1.0,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: false,
          enlargeFactor: 0.3,
          scrollDirection: Axis.horizontal,
        )),
    const SizedBox(
      height: 10,
    ),
    Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 100.0,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategoryItem(
                          categoryModel.categoryDataMode!.dataModel[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10.0,
                      ),
                      itemCount:
                          categoryModel.categoryDataMode!.dataModel.length,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            GridView.count(
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              childAspectRatio: 1 / 1.8,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.all(10),
              crossAxisCount: 2,
              children: List.generate(
                homemodel.data.products.length,
                (index) =>
                    buildGridProduct(homemodel.data.products[index], context),
              ),
            ),
          ],
        ),
      ),
    ),
  ]);
}

Widget buildGridProduct(ProductModel model, BuildContext context) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(7),
    decoration: BoxDecoration(
      border: Border.all(
        color: Constants.mainColor,
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(
                '${model.image}',
              ),
              width: double.infinity,
              height: 200.0,
            ),
            if (model.discount != 0)
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
        Column(
          children: [
            Text(
              '${model.name}',
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
                  '${model.price.round()}',
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
                    ShopAppCubit.get(context).changecartData(model.id);
                  },
                  icon: CircleAvatar(
                    radius: 15.0,
                    // backgroundColor: Colors.grey,
                    backgroundColor: ShopAppCubit.get(context).cart[model.id]!
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
                    ShopAppCubit.get(context).changeFavoriteData(model.id);
                  },
                  icon: CircleAvatar(
                    radius: 15.0,
                    backgroundColor:
                        ShopAppCubit.get(context).favorites[model.id]!
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
            Row(
              children: [
                if (model.discount != 0)
                  Text(
                    '${model.oldPrice.round()}',
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
      ],
    ),
  );
}

Widget buildCategoryItem(DataModel? model) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage('${model!.image}'),
          width: 100.0,
          height: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(.8),
          width: 100.0,
          child: Text(
            '${model.name}',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
