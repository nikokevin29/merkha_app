import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  Future<void> showAddress() async {
    ApiReturnValue<List<Address>> result = await AddressService.showAddress();
    if (result.value != null) {
      emit(AddressListLoaded(result.value));
    } else {
      emit(AddressLoadingFailed(result.message));
    }
  }

  Future<void> addAddress(Address address) async {
    ApiReturnValue<Address> result = await AddressService.addAddress(address);

    if (result.value != null) {
      emit(AddressLoaded(result.value));
    } else {
      emit(AddressLoadingFailed(result.message));
    }
  }

  Future<void> editAddress(String idaddress, Address address) async {
    ApiReturnValue<Address> result =
        await AddressService.editAddress(address: address, idaddress: idaddress);

    if (result.value != null) {
      emit(AddressLoaded(result.value));
    } else {
      emit(AddressLoadingFailed(result.message));
    }
  }

  Future<void> deleteAddress(String id) async {
    ApiReturnValue<Address> result = await AddressService.deleteAddress(id);

    if (result.value != null) {
      emit(AddressLoaded(result.value));
    } else {
      emit(AddressLoadingFailed(result.message));
    }
  }
}
