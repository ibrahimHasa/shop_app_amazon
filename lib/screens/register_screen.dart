// ignore_for_file: must_be_immutable

import 'package:amazon/controller/cache_helper/shared_prefernces.dart';
import 'package:amazon/controller/cubit/register_cubit/cubit/register_cubit.dart';
import 'package:amazon/controller/cubit/shop_cubit/cubit/shop_cubit.dart';
import 'package:amazon/screens/home_layout.dart';
import 'package:amazon/widgets/components.dart';
import 'package:amazon/widgets/constants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          // ignore: todo
          // TODO: implement listener
          if (state is RegisterSuccessState) {
            if (state.registerModel.status == true) {
              print(state.registerModel.status);
              print(state.registerModel.data!.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.registerModel.data!.token,
              ).then((value) {
                token = state.registerModel.data!.token;
                navigateAndFinish(
                  context,
                  HomeLayout(),
                );
                nameController.clear();
                    emailController.clear();
                    passwordController.clear();
                    phoneController.clear();
                    ShopCubit.get(context).currentIndex = 0;
              });
              showToast(
                text: state.registerModel.message!,
                state: ToastStates.SUCCESS,
              );
            }
            else{
              showToast(
                text: state.registerModel.message!,
                state: ToastStates.WARNING,
              );
              print(state.registerModel.status);
              print(state.registerModel.message);
            }
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
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
                      Text(
                        'Register',
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Colors.deepPurple,
                            ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Register Now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
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
                            return ' Please Enter Your Name';
                          }
                          // return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Name',
                          focusColor: Colors.black,
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        onFieldSubmitted: (String? value) {
                          if (formKey.currentState!.validate()) {
                            RegisterCubit.get(context).userRegister(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
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
                            cubit.userRegister(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                            );
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
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'PLease Enter Your Phone Number';
                          }
                        },
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          // suffixIcon: IconButton(
                          //   onPressed: () {
                          //     // cubit.changePasswordVisivility();
                          //   },
                          //   icon: Icon(cubit.suffix),
                          // ),
                          labelText: 'Phone Number',
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            cubit.userRegister(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        builder: (context) => Container(
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            child: Text(
                              'Register'.toUpperCase(),
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
                          Text('I already have an account '),
                          SizedBox(
                            width: 3,
                          ),
                          defaultTextButton(
                            function: () {
                              // navigateTo(context, RegisterScreen());
                            },
                            text: 'Login Now',
                            size: 18,
                          ),
                        ],
                      )
                    ],
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
