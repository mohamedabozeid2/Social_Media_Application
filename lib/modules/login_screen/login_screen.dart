import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application4/modules/Register_Screen/Register_Screen.dart';
import 'package:social_application4/modules/Social_Layout/Social_Layout.dart';
import 'package:social_application4/modules/login_screen/cubit/cubit.dart';
import 'package:social_application4/modules/login_screen/cubit/states.dart';
import 'package:social_application4/shared/components/components.dart';
import 'package:social_application4/shared/constants/constants.dart';
import 'package:social_application4/shared/network/local/cache_helper.dart';

class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(msg: state.error);
          }else if(state is SocialLoginSuccessState){
            showToast(msg: "Login Done Successfully");
            CacheHelper.saveData(key: 'uId', value: state.uid).then((value){
              uId = CacheHelper.getData(key: 'uId');
              navigateAndFinish(context: context, widget: Home());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 40),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Login now to communicate with friends",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30,
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
                            type: TextInputType.visiblePassword,
                            controller: passwordController,
                            validation: "Please Enter Your Password",
                            label: "Password",
                            prefixIcon: Icons.lock,
                            fun: () {
                              SocialLoginCubit.get(context).changeVisibility();
                            },
                            isPassword:
                                SocialLoginCubit.get(context).isPassword,
                            suffixIcon: SocialLoginCubit.get(context).icon,
                            context: context
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (BuildContext context) => buttonBuilder(
                            fun: () {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context
                                );
                              }
                            },
                            text: "Login",
                            color: Colors.blue,
                            height: 50,
                            isUpper: true,
                            textColor: Colors.white,
                            width: double.infinity,
                          ),
                          fallback: (BuildContext context)=> Center(child: const CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, SocialRegisterScreen());
                                },
                                child: Text(
                                  "Register".toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ))
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
