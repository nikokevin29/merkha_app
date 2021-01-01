import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  Future<void> signIn(String email, String password) async {
    ApiReturnValue<User> result = await UserServices.signIn(email, password);

    if (result.value != null) {
      emit(UserLoaded(result.value));
    } else {
      emit(UserLoadingFailed(result.message));
    }
  }

  Future<void> signUp(User user, String password, {File pictureFile}) async {
    ApiReturnValue<User> result = await UserServices.signUp(user, password, urlphoto: pictureFile);
    if (result.value != null) {
      emit(UserLoaded(result.value));
    } else {
      emit(UserLoadingFailed(result.message));
    }
  }

  Future<void> uploadProfileFirebase(File pictureFile) async {
    String result = await UserServices.uploadProfileFirebase(pictureFile);

    if (result != null) {
      print('Print Upload Photo result : ' + result);
      emit(
        UserLoaded(
          (state as UserLoaded).user.copyWith(urlphoto: result),
        ),
      );
    }
  }

  Future<void> signOut() async {
    ApiReturnValue<User> result = await UserServices.signOut();
    print(result.value);
    if (result.value == null) {
      print('Sign Out Message : ' + result.message);
    }
  }

  Future<void> sendVerificationEmail() async {
    ApiReturnValue<String> result = await UserServices.sendVerification();

    if (result.value != null) {
      print(result.value);
    }
  }

  Future<void> uploadUserInterest(String value) async {
    ApiReturnValue<String> result = await UserServices.uploadUserInterest(value: value);

    if (result.value != null) {
      print(result.value);
      emit(UserLoadingFailed(result.message));
    }
  }

  Future<void> resetPassword(String email) async {
    ApiReturnValue<String> result = await UserServices.resetPassword(email: email);
    if (result.value != null) {
      print(result.value);
      print(result.message);
    }
  }
}
