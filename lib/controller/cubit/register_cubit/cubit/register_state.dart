part of 'register_cubit.dart';

@immutable
abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

// ignore: must_be_immutable
class RegisterSuccessState extends RegisterStates {
   LoginModel registerModel;

  RegisterSuccessState(
    this.registerModel,
  );
}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}

class RegisterChangePasswordIconVisisbilityState extends RegisterStates {}
