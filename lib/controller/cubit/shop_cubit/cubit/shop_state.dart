part of 'shop_cubit.dart';

@immutable
abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangBottomNavState extends ShopStates {}

///** HomeData */

class ShopHomeDataLoadingState extends ShopStates {}

class ShopHomeDataSuccessState extends ShopStates {}

class ShopHomeDataErrorState extends ShopStates {}

///** CategoreisData */
class ShopCategoreisDataLoadingState extends ShopStates {}

class ShopCategoreisDataSuccessState extends ShopStates {}

class ShopCategoreisDataErrorState extends ShopStates {}

//** Get userData */
class ShopHomeGetUserDataLoadingState extends ShopStates {}

class ShopHomeGetUserDataSuccessState extends ShopStates {
  final LoginModel? loginModel;

  ShopHomeGetUserDataSuccessState(this.loginModel);
}

class ShopHomeGetUserDataErrorState extends ShopStates {}

//** Update userData */
class ShopHomeUpdateUserDataLoadingState extends ShopStates {}

class ShopHomeUpdateUserDataSuccessState extends ShopStates {
  final LoginModel? loginModel;

  ShopHomeUpdateUserDataSuccessState(this.loginModel);
}

class ShopHomeUpdateUserDataErrorState extends ShopStates {}
//** change favorites */

class ShopChangeFavoritesState extends ShopStates {}

class ShopChangeFavoritesSuccessState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopChangeFavoritesSuccessState(this.model);
}

class ShopChangeFavoritesErrorState extends ShopStates {}
//** Get Favorites */

class ShopGetFavoritesLoadingState extends ShopStates {}
class ShopGetFavoritesSuccessState extends ShopStates {}

class ShopGetFavoritesErrorState extends ShopStates {}

