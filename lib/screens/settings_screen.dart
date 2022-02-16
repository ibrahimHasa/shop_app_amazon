// ignore_for_file: must_be_immutable
import 'package:amazon/controller/cache_helper/shared_prefernces.dart';
import 'package:amazon/controller/cubit/shop_cubit/cubit/shop_cubit.dart';
import 'package:amazon/widgets/components.dart';
import 'package:amazon/widgets/constants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_screen.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = ShopCubit.get(context).userModel!;
          nameController.text = model.data!.name!;
          emailController.text = model.data!.email!;
          phoneController.text = model.data!.phone!;
          return SingleChildScrollView(
            child: ConditionalBuilder(
              condition: ShopCubit.get(context).userModel != null,
              builder: (context) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
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
                            'Profile',
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      color: Colors.deepPurple,
                                    ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Text(
                          //   'Login Now to browse our hot offers',
                          //   style:
                          //       Theme.of(context).textTheme.bodyText1!.copyWith(
                          //             color: Colors.grey,
                          //           ),
                          // ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Name is required';
                              }
                            },
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
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
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'Phone',
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          if (state is ShopHomeUpdateUserDataLoadingState)
                            Center(
                              child: Container(
                                width: 200,
                                child: LinearProgressIndicator(),
                              ),
                            ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: MaterialButton(
                                  onPressed: () {
                                    CacheHelper.removeSomeData(key: token!)
                                        .then(
                                      (value) {
                                        token = '';
                                        navigateAndFinish(
                                          context,
                                          LoginScreen(),
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    "LOGOUT",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: defaultColor,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: MaterialButton(
                                  onPressed: () {
                                    CacheHelper.removeSomeData(key: 'token')
                                        .then(
                                      (value) {
                                        if (formKey.currentState!.validate()) {
                                          ShopCubit.get(context).UpdateUsrData(
                                            name: nameController.text,
                                            email: emailController.text,
                                            phone: phoneController.text,
                                          );
                                        }
                                      },
                                    );
                                  },
                                  child: Text(
                                    "UPDATE",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: defaultColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        });
  }
}
