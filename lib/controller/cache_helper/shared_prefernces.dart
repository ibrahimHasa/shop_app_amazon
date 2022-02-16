import 'package:amazon/controller/cubit/shop_cubit/cubit/shop_cubit.dart';
import 'package:amazon/screens/login_screen.dart';
import 'package:amazon/widgets/components.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences!.setBool(key, value);
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences!.get(key);
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is bool) return await sharedPreferences!.setBool(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);
    return await sharedPreferences!.setDouble(key, value);
  }

  static Future<bool> removeSomeData({
    required String key,
  }) async {
    return await sharedPreferences!.clear();
    // ignore: dead_code
    // key = '';
  }
  //    Future<bool>? removeSomeData(context) {
  //   sharedPreferences!.remove('token').then((value) {
  //     navigateAndFinish(context, LoginScreen());
  //     ShopCubit.get(context).currentIndex = 0;
  //   });
  // }
}
