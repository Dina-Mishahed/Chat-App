import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/widgets/custon_button.dart';
import 'package:chat_app/widgets/custon_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  static String id = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email, pass, phone, confPassword;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimaryColor,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Spacer(flex: 3,),
                    Image.asset(
                      "assets/images/scholar.png",
                    ),
                    Text(
                      "Scholar Chat",
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontFamily: 'pacifico',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 80.0,
                    ),
                    Container(
                      padding: EdgeInsetsDirectional.only(bottom: 10.0),
                      width: double.infinity,
                      child: Text(
                        "REGISTER",
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
                      height: 10.0,
                    ),
                    CustomTextField(
                        hintText: 'Phone Number',
                        fun: (data) {
                          phone = data;
                        }),
                    SizedBox(
                      height: 10.0,
                    ),
                    CustomTextField(
                        hintText: 'Password',
                        fun: (data) {
                          pass = data;
                        },
                        isSecure: true),
                    SizedBox(
                      height: 10.0,
                    ),
                    CustomTextField(
                        hintText: 'Confirm Password',
                        fun: (data) {
                          confPassword = data;
                        },
                        isSecure: true),
                    SizedBox(
                      height: 10.0,
                    ),

                    CustomButton(
                        text: "Sign Up",
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            if(confPassword != pass){
                              ShowSnackBar(context, "the confirm password not the same of password");
                            }
                            else{
                              isLoading = true;
                              setState(() {});
                              try {
                                await AuthWithEmailPassword(
                                    email!, pass!, context);
                              } on FirebaseAuthException catch (exception) {
                                switch (exception.code) {
                                  case "invalid-email":
                                    ShowSnackBar(
                                        context, "Not a valid email address.");
                                    break;
                                  case "email-already-in-use":
                                    ShowSnackBar(context, "email already exit");
                                    break;
                                  case "weak-password":
                                    ShowSnackBar(context, "weak password");
                                    break;
                                  default:
                                    ShowSnackBar(context, exception.toString());
                                }
                              }
                              isLoading = false;
                              setState(() {});
                            }

                          } else {}
                        }),
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
                              Navigator.pop(context);
                            },
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.green.shade200,
                                  fontSize: 15.0,
                                ),
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
    );
  }

  Future<void> AuthWithEmailPassword(
      String email, String password, context) async {
    final signInMethods = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
    Navigator.pushNamed(context, ChatScreen.id);
  }
}
