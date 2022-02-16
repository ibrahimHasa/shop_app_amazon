import 'package:amazon/controller/dio_helper/dio_helper.dart';
import 'package:amazon/controller/end_points.dart';
import 'package:amazon/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

//** Register */
  late LoginModel registerModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      registerModel = LoginModel.fromJson(value.data);
      print(registerModel.status);
      print(registerModel.message);
      print(registerModel.data!.name);
      emit(RegisterSuccessState(registerModel));
    }).catchError((error) {
      print('Register error ${error.toString()}');
      emit(
        RegisterErrorState(error.toString()),
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
    emit(RegisterChangePasswordIconVisisbilityState());
  }
}
