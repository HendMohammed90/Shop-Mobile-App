import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/app-cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/app-state.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    ShopAppCubit cubit = ShopAppCubit.get(context);
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return 'search must be write word';
                      } else {
                        return null;
                      }
                    },
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    onChanged: (searchVal) {
                      print(searchVal);
                      cubit.search(searchVal);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Type Your Search Word',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                if (state is ShopAppSearchLoadingState)
                  LinearProgressIndicator(),
                if (state is ShopAppSearchSuccessState)
                  Expanded(
                    child: ConditionalBuilder(
                      condition: ShopAppCubit.get(context).searchModel != null,
                      builder: (context) => ListView.separated(
                        itemCount: ShopAppCubit.get(context)
                            .searchModel!
                            .data!
                            .data
                            .length,
                        itemBuilder: (context, index) => buildListProduct(
                            ShopAppCubit.get(context)
                                .searchModel!
                                .data!
                                .data[index],
                            context),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 4,
                        ),
                      ),
                      fallback: (context) => Center(
                        child: Text('Type for Show some result'),
                      ),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
