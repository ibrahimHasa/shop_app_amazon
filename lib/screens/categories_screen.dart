import 'package:amazon/controller/cubit/shop_cubit/cubit/shop_cubit.dart';
import 'package:amazon/models/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategiriesScreen extends StatelessWidget {
  const CategiriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // ignore: todo
        // TODO: implement listener
      },
      builder: (context, state) {
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildCategoryItem(
              ShopCubit.get(context).categoriesModel!.data!.data[index]),
          separatorBuilder: (context, index) => Divider(),
          itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
        );
      },
    );
  }

  Widget buildCategoryItem(DataModel model) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (model.image == '')
              Container(
                width: 100,
                height: 100,
              )
            else
              Image(
                image: NetworkImage("${model.image}"),
                width: 100,
                height: 100,
              ),
            Text(
              '${model.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
              ),
            ),
          ],
        ),
      );
}
