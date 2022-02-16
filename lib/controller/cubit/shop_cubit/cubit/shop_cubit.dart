import 'package:amazon/controller/dio_helper/dio_helper.dart';
import 'package:amazon/controller/end_points.dart';
import 'package:amazon/models/categories_model.dart';
import 'package:amazon/models/change_favorites_model.dart';
import 'package:amazon/models/favorites_model.dart';
import 'package:amazon/models/home_model.dart';
import 'package:amazon/models/login_model.dart';
import 'package:amazon/screens/categories_screen.dart';
import 'package:amazon/screens/favourites_screen.dart';
import 'package:amazon/screens/products_screen.dart';
import 'package:amazon/screens/settings_screen.dart';
import 'package:amazon/widgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

//** change Bottom Nav */
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategiriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];
  void changeBottomNav(index) {
    currentIndex = index;

    emit(ShopChangBottomNavState());
  }

  //** Get HOme  Data */
  HomeModel? homeModel;
  Map<int, bool>? favorites = {};
  void getHomeData() {
    emit(ShopHomeDataLoadingState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites!.addAll({
          element.id!: element.in_favorites!,
        });
      });

      print(favorites.toString());
      // print(homeModel!.status);
      // print(homeModel!.data!.banners[0].image);
      emit(ShopHomeDataSuccessState());
    }).catchError((error) {
      emit(ShopHomeDataErrorState());
      print(error.toString());
    });
  }

  //** Get Categories  Data */
  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    emit(ShopCategoreisDataLoadingState());
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopCategoreisDataSuccessState());
    }).catchError((error) {
      emit(ShopCategoreisDataErrorState());
      print(error.toString());
    });
  }

  //** change favorites */
  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(productId) {
    favorites![productId] = !favorites![productId]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel!.status!) {
        favorites![productId] = !favorites![productId]!;
      } else {
        getFavoritesData();
      }
      print(value.data);
      emit(ShopChangeFavoritesSuccessState(changeFavoritesModel!));
    }).catchError((error) {
      favorites![productId] = !favorites![productId]!;

      emit(ShopChangeFavoritesErrorState());
    });
  }

  //** Get Favorites  Data */
  FavoritesModel? favoritesModel;
  void getFavoritesData() {
    emit(ShopGetFavoritesLoadingState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopGetFavoritesSuccessState());
    }).catchError((error) {
      emit(ShopGetFavoritesErrorState());
      print(error.toString());
    });
  }

  //** Log out */
  LoginModel? userModel;
  void getUsrData() {
    emit(ShopHomeGetUserDataLoadingState());
    DioHelper.getData(
      url: Profile,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      print(userModel!.data!.email);
      emit(ShopHomeGetUserDataSuccessState(userModel));
    }).catchError((error) {
      emit(ShopHomeGetUserDataErrorState());
      print(error.toString());
    });
  }

  //** UPDATE */
  void UpdateUsrData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopHomeUpdateUserDataLoadingState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      print(userModel!.data!.email);
      emit(ShopHomeUpdateUserDataSuccessState(userModel));
    }).catchError((error) {
      emit(ShopHomeUpdateUserDataErrorState());
      print(error.toString());
    });
  }
}
