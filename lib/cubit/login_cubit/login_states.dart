abstract class LoginStates {}

class IntialState extends LoginStates {}

class LoadingState extends LoginStates {}

class SucessState extends LoginStates {}

class FailierState extends LoginStates {
  String? messageError;
  FailierState({required messageError});
}
