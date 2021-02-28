import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'operational_hours_state.dart';

class OperationalHoursCubit extends Cubit<OperationalHoursState> {
  OperationalHoursCubit() : super(OperationalHoursInitial());

  Future<void> showOperational(String idMerchant) async {
    ApiReturnValue<List<OperationalHours>> result =
        await MerchantService.showAllOperational(idMerchant: idMerchant);
    if (result.value != null) {
      emit(OperationalHoursListLoaded(result.value));
    } else {
      emit(OperationalHoursLoadFailed(result.message));
    }
  }
}
