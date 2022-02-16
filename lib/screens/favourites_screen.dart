import 'package:amazon/controller/cubit/shop_cubit/cubit/shop_cubit.dart';
import 'package:amazon/models/favorites_model.dart';
import 'package:amazon/widgets/components.dart';
import 'package:amazon/widgets/constants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopGetFavoritesLoadingState,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildListProduct(
                ShopCubit.get(context)
                    .favoritesModel!
                    .data!
                    .data![index]
                    .product!,
                context),
            separatorBuilder: (context, index) => Divider(),
            itemCount:
                ShopCubit.get(context).favoritesModel!.data!.data!.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
