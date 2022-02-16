import 'package:amazon/controller/cubit/search_cubit/cubit/search_cubit.dart';
import 'package:amazon/widgets/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {
          // ignore: todo
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (String? text) {
                        if (formKey.currentState!.validate()) {
                          SearchCubit.get(context).search(text!);
                        }
                      },
                      // onChanged: (value) {
                      //   print(value);
                      // },
                      validator: (text) {
                        if (text!.isEmpty) {
                          return 'Enter Text To Search';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Search',
                        focusColor: Colors.black,
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildListProduct(
                            SearchCubit.get(context).model!.data!.data![index],
                            context,
                            isOldPrice: false,
                          ),
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: SearchCubit.get(context)
                              .model!
                              .data!
                              .data!
                              .length,
                        ),
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
