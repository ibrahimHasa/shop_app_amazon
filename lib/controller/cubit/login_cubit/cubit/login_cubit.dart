import 'package:amazon/controller/dio_helper/dio_helper.dart';
import 'package:amazon/controller/end_points.dart';
import 'package:amazon/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

//** LOgin */
  late LoginModel loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel.status);
      print(loginModel.message);
      print(loginModel.data!.name);
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      print('login error ${error.toString()}');
      emit(
        LoginErrorState(error.toString()),
      );
    });
  }

  //**visivilty Icon change  */
  bool isPassword = true;

  IconData suffix = Icons.visibility_outlined;
  void changePasswordVisivility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordIconVisisbilityState());
  }
}
