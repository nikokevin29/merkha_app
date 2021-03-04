
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  UpdateUserCubit() : super(UpdateUserInitial());

  Future<void> updateUsername(String username) async {
    ApiReturnValue<User> result = await UserServices.updateUsername(username: username);
    if (result.value != null) {
      emit(UpdateUserLoaded(result.value));
    } else {
      emit(UserUpdateLoadingFailed(result.message));
    }
  }
}
