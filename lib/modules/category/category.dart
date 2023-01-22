import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/models/category_model.dart';
import 'package:shop_app/layout/shop_app/cubit/app-cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/app-state.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopAppCubit.get(context)
            .categoryModel!
            .categoryDataMode!
            .dataModel;
        return Container(
          child: ListView.separated(
            itemBuilder: (context, index) =>
                buildCategoryListItem(model[index]),
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemCount: ShopAppCubit.get(context)
                .categoryModel!
                .categoryDataMode!
                .dataModel
                .length,
          ),
        );
      },
    );
  }
}

Widget buildCategoryListItem(DataModel? categoryModel) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage('${categoryModel!.image}'),
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: 10.0,
        ),
        Text(
          '${categoryModel.name}',
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        const Icon(
          Icons.arrow_forward_ios,
        ),
      ],
    ),
  );
}
