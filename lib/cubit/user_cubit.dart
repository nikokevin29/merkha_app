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

  Future<void> uploadProfilePicture(File pictureFile) async {
    ApiReturnValue<String> result = await UserServices.uploadProfilePicture(pictureFile);

    if (result.value != null) {
      emit(UserLoaded((state as UserLoaded).user.copyWith(urlphoto: baseURLphoto + result.value)));
    }
  }

  Future<void> signOut() async {
    ApiReturnValue<User> result = await UserServices.signOut();
    print(result.value);
    if (result.value == null) {
      emit(UserLoadingFailed(result.message));
    }
  }
}
