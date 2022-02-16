import 'package:amazon/controller/cubit/shop_cubit/cubit/shop_cubit.dart';
import 'package:amazon/models/categories_model.dart';
import 'package:amazon/models/home_model.dart';
import 'package:amazon/widgets/components.dart';
import 'package:amazon/widgets/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopChangeFavoritesSuccessState) {
          if (!state.model.status!) {
            showToast(
              text: state.model.message!,
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          builder: (context) => productsBuilder(
            ShopCubit.get(context).homeModel!,
            ShopCubit.get(context).categoriesModel!,
            context,
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(
              color: Colors.deepPurple,
            ),
          ),
        );
      },
    );
  }
}

Widget productsBuilder(
        HomeModel model, CategoriesModel categoriesModel, context) =>
    SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data!.banners
                .map(
                  (e) => Image.network(
                    '${e.image}',
                    fit: BoxFit.fitHeight,
                    width: double.infinity,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 190,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
          // SizedBox(
          //   height: 5,
          // ),
          Padding(
            padding: const EdgeInsets.only(
              top: 6,
              bottom: 6,
              left: 10,
            ),
            child: Text(
              'Categories'.toUpperCase(),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black45,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // SizedBox(
          //   height: 5,
          // ),
          Container(
            color: Colors.grey[200],
            height: 100,
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 3),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) => buildCategoryItem(
                categoriesModel.data!.data[index],
              ),
              separatorBuilder: (context, index) => SizedBox(
                width: 10,
              ),
              itemCount: categoriesModel.data!.data.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 12,
              bottom: 6,
              left: 10,
            ),
            child: Text(
              'NEW PRODUCTS',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black45,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            color: Colors.grey[200],
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(10.0),
              mainAxisSpacing: 6.0,
              crossAxisSpacing: 6.0,
              childAspectRatio: 0.63,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                  model.data!.products.length,
                  (index) =>
                      buildGridProduct(model.data!.products[index], context)),
            ),
          ),
        ],
      ),
    );

Widget buildCategoryItem(DataModel model) => Container(
      // color: Colors.red,
      // padding: EdgeInsets.all(5),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.all(2),
            width: 100,
            color: Colors.black54,
            child: Text(
              model.name!.toUpperCase(),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

Widget buildGridProduct(ProductsModel model, context) => Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image!),
                width: double.infinity,
                height: 170,
                // fit: BoxFit.cover,
              ),
              if (model.discount != 0)
                Container(
                  padding: EdgeInsets.all(4),
                  color: Colors.red,
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            model.name!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          Spacer(),
          Row(
            children: [
              Text(
                ' ${model.price.round()}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 17,
                  color: defaultColor,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              if (model.discount != 0)
                Text(
                  ' ${model.old_price.round()}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              Spacer(),
              IconButton(
                onPressed: () {
                  ShopCubit.get(context).changeFavorites(model.id);
                  print(model.id);
                },
                icon: CircleAvatar(
                  radius: 15,
                  backgroundColor:
                      ShopCubit.get(context).favorites![model.id] == true
                          ? defaultColor
                          : Colors.grey,
                  child: Icon(
                    ShopCubit.get(context).favorites![model.id] == true
                        ? Icons.favorite_outlined
                        : Icons.favorite_border,
                    size: 17,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4,
          ),
        ],
      ),
    );
