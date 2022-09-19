import 'package:chat_app/constants.dart';
import 'package:chat_app/cubit/login_cubit/login_cubit.dart';
import 'package:chat_app/cubit/login_cubit/login_states.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/widgets/custon_button.dart';
import 'package:chat_app/widgets/custon_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatelessWidget {
  String? email, passwoed;
  bool isLoading = false;
  static String id = 'LoginScreen';
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimaryColor,
      body: Form(
        key: formKey,
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoadingState) {
              isLoading = true;
            } else if (state is SucessState) {
              isLoading = false;
              Navigator.pushNamed(context, ChatScreen.id);
            } else if (state is FailierState) {
              isLoading = false;
              print(state.messageError);
              //ShowSnackBar(context, state.messageError);
            }
          },
          builder: (context, state) => ModalProgressHUD(
            inAsyncCall: isLoading,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 130.0, horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/scholar.png",
                      ),
                      const Text(
                        "Scholar Chat",
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                            fontFamily: 'Pacifico',
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 80.0,
                      ),
                      Container(
                        padding: EdgeInsetsDirectional.only(bottom: 10.0),
                        width: double.infinity,
                        child: Text(
                          "LOGIN",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                      CustomTextField(
                          hintText: 'Email',
                          fun: (data) {
                            email = data;
                          }),
                      SizedBox(
                        height: 15.0,
                      ),
                      CustomTextField(
                        hintText: 'Password',
                        fun: (data) {
                          passwoed = data;
                        },
                        isSecure: true,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      CustomButton(
                        text: "Sign In",
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<LoginCubit>(context)
                                .userLogin( email!, passwoed!);
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "don't have an Account?",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, RegisterScreen.id);
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.green.shade200,
                                  fontSize: 15.0,
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
