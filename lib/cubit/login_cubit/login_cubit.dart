import 'package:chat_app/cubit/login_cubit/login_states.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(IntialState());

  Future<void> userLogin(String email, String password) async {
    emit(IntialState());
    try {
      emit(LoadingState());
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      emit(SucessState());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          print("Not a valid email address.");
          emit(FailierState(messageError: "Not a valid email address."));
          break;
        case "wrong-password":
          print("wrong password");
          emit(FailierState(messageError: "wrong password"));
          break;
        case "user-not-found":
          print("email not found");
          emit(FailierState(messageError: "email not found"));
          break;
        default:
          print("succes state");
          emit(FailierState(messageError: e.toString()));
      }
      //print(" ${e.toString()}");
    }
  }
}
