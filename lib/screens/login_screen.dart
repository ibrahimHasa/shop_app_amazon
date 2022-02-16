// ignore_for_file: must_be_immutable

import 'package:amazon/controller/cache_helper/shared_prefernces.dart';
import 'package:amazon/controller/cubit/login_cubit/cubit/login_cubit.dart';
import 'package:amazon/controller/cubit/shop_cubit/cubit/shop_cubit.dart';
import 'package:amazon/screens/home_layout.dart';
import 'package:amazon/screens/register_screen.dart';
import 'package:amazon/widgets/components.dart';
import 'package:amazon/widgets/constants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          // ignore: todo
          // TODO: implement listener
          if (state is LoginSuccessState) {
            if (state.loginModel.status == true) {
              print(state.loginModel.status);
              print(state.loginModel.data!.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token;
                navigateAndFinish(
                  context,
                  HomeLayout(),
                );
                    emailController.clear();
                    passwordController.clear();
                    ShopCubit.get(context).currentIndex = 0;
              });
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.SUCCESS,
              );
            }
            if (state.loginModel.status == false) {
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.WARNING,
              );
              print(state.loginModel.status);
              print(state.loginModel.message);
            }
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 0,
                    right: 20.0,
                    left: 20.0,
                    bottom: 0,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image(
                        //   image: AssetImage('assets/images/login.png'),
                        //   height: 200,
                        //   width: double.infinity,
                        // ),
                        Text(
                          'Login',
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    color: Colors.deepPurple,
                                  ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Login Now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          //  onFieldSubmitted: (String? value) {
                          //      if (formKey.currentState!.validate()) {
                          //         ShoploginCubit.get(context).userLogin(
                          //                   email: emailController.text,
                          //                   password: passwordController.text);
                          //             }
                          //           },
                          // onChanged: (value) {
                          //   print(value);
                          // },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email is required';
                            }
                            // return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            focusColor: Colors.black,
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password is required';
                            }
                          },
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: cubit.isPassword,
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  cubit.changePasswordVisivility();
                                },
                                icon: Icon(cubit.suffix)),
                            labelText: 'PassWord',
                            prefixIcon: Icon(Icons.lock_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => Container(
                            width: double.infinity,
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              child: Text(
                                'Login'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.deepPurple,
                            ),
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text('Don\'t have an account? '),
                            SizedBox(
                              width: 3,
                            ),
                            defaultTextButton(
                              function: () {
                                navigateTo(context, RegisterScreen());
                              },
                              text: 'Register Now',
                              size: 18,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
