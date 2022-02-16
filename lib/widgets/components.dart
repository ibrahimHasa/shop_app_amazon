import 'package:amazon/controller/cache_helper/shared_prefernces.dart';
import 'package:amazon/controller/cubit/shop_cubit/cubit/shop_cubit.dart';
import 'package:amazon/models/favorites_model.dart';
import 'package:amazon/screens/login_screen.dart';
import 'package:amazon/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );
Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.deepPurple,
  bool isUpperCase = true,
  double radius = 0.0,
  required VoidCallback? function,
  required String text,
  double? size,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: () {
          function;
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
            fontSize: size,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );

Widget defaultTextButton({
  required Function()? function,
  required String text,
  double? size,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text,
        style: TextStyle(fontSize: size),
      ),
    );

void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 18.0,
    );
//**enum */
enum ToastStates {
  SUCCESS,
  ERROR,
  WARNING,
}
Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

/** sign out */
void signOut(context) {
  CacheHelper.removeSomeData(key: 'token').then((value) {
    navigateAndFinish(
      context,
      LoginScreen(),
    );
  });
}

Widget buildListProduct(model, context, {bool isOldPrice = true}) => Container(
      padding: EdgeInsets.all(20),
      height: 120,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
         model.image == null  ? Container(color:Colors.red,width: 110,
                height: 110,) : Image(
                image: NetworkImage("${model.image}"),
                width: 110,
                height: 110,
                // fit: BoxFit.cover,
              ),
              if (model.discount != 0 && isOldPrice)
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
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
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
                    ' ${model.price}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if (model.discount != 0 && isOldPrice)
                    Text(
                      '${model.oldPrice}',
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
                      // print(model.id);
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
            ],
          )),
        ],
      ),
    );
