// ignore_for_file: unused_local_variable, must_be_immutable

import 'package:amazon/controller/cubit/shop_cubit/cubit/shop_cubit.dart';
import 'package:amazon/screens/home_layout.dart';
import 'package:amazon/screens/login_screen.dart';
import 'package:amazon/screens/on_boarding_screen.dart';
import 'package:amazon/widgets/constants.dart';
import 'package:amazon/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller/bloc_observer.dart';
import 'controller/cache_helper/shared_prefernces.dart';
import 'controller/dio_helper/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
   token = CacheHelper.getData(key: 'token');
  if (onBoarding != null) {
    if (token != null) {
      widget = HomeLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  BlocOverrides.runZoned(
    () {
      runApp(
        MyApp(
          // isDark: isDark,
          onBoarding: onBoarding,
          startWidget: widget,
        ),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  dynamic startWidget;
  dynamic onBoarding;
  MyApp({this.onBoarding, this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()..getHomeData()..getUsrData()..getCategoriesData()..getFavoritesData(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ShopApp',
        theme: lightTheme,
        darkTheme: darktTheme,
        themeMode: ThemeMode.light,
        // home: onBoarding ? LoginScreen() : OnBoardingScreen(),
        home: startWidget,
      ),
    );
  }
}
