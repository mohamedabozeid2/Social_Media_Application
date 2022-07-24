import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application4/modules/Social_Layout/Social_Layout.dart';
import 'package:social_application4/shared/constants/constants.dart';
import 'package:social_application4/shared/network/local/cache_helper.dart';
import '../../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialRegisterScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            showToast(msg: "Created Successfully");
            CacheHelper.saveData(key: 'uId', value: state.uId);
            uId = CacheHelper.getData(key: 'uId');
            navigateAndFinish(context: context, widget: SocialLayout());
          } else if (state is SocialRegisterErrorState) {
            showToast(msg: state.error.toString());
          }
          // if (state is SocialCreateUserSuccessState) {
          //   showToast(msg: "Success!");
          //   navigateAndFinish(context: context, widget: SocialLayout());
          //   CacheHelper.saveData(key: 'uId', value: state.uId);
          // } else if (state is SocialRegisterErrorState) {
          //   showToast(msg: state.error.toString());
          // }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "REGISTER",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Register now to communicate with friends",
                          style:
                          Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        textFormField(
                          context: context,
                          controller: nameController,
                          label: "User Name",
                          type: TextInputType.name,
                          prefixIcon: Icons.person,
                          validation: "Name Must Not Be Empty",
                          isPassword: false,
                          borderRadius: 5.0,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        textFormField(
                            type: TextInputType.emailAddress,
                            controller: emailController,
                            label: "Email Address",
                            validation: "Please Enter Your Email Address",
                            prefixIcon: Icons.email_outlined,
                            context: context
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        textFormField(
                          context: context,
                          controller: passwordController,
                          label: "Password",
                          type: TextInputType.visiblePassword,
                          prefixIcon: Icons.lock,
                          isPassword: SocialRegisterCubit
                              .get(context)
                              .isPassword,
                          suffixIcon: SocialRegisterCubit
                              .get(context)
                              .icon,
                          fun: () {
                            SocialRegisterCubit.get(context).changeVisibility();
                          },
                          validation: "Password Must Not Be Empty",
                          borderRadius: 5.0,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        textFormField(
                          context: context,
                          controller: phoneController,
                          label: "Phone Number",
                          type: TextInputType.phone,
                          prefixIcon: Icons.phone,
                          validation: "Phone Must Not Be Empty",
                          isPassword: false,
                          borderRadius: 5.0,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ConditionalBuilder(
                            condition: state is! SocialRegisterLoadingState,
                            builder: (context) =>
                                buttonBuilder(
                                    fun: () {
                                      if (formKey.currentState!.validate()) {
                                        SocialRegisterCubit.get(context)
                                            .userRegister(
                                            name: nameController.text,
                                            email: emailController.text,
                                            phone: phoneController.text,
                                            password: passwordController.text,
                                            context: context
                                        );
                                      }
                                    },
                                    text: "Register".toUpperCase(),
                                    width: double.infinity,
                                    textColor: Colors.white,
                                    color: Colors.blue,
                                    isUpper: true,
                                    height: 50),
                            fallback: (context) =>
                            const Center(
                                child: CircularProgressIndicator())),
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
