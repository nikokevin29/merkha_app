import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'user_interest_state.dart';

class UserInterestCubit extends Cubit<UserInterestState> {
  UserInterestCubit() : super(UserInterestInitial());

  Future<void> loadInterest() async {
    ApiReturnValue<List<UserInterest>> result = await UserInterestService.showUserInterest();
    if (result.value != null) {
      emit(UserInterestLoaded(result.value));
    } else {
      emit(UserInterestLoadingFailed(result.message));
    }
  }
}
