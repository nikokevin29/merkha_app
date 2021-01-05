part of 'address_cubit.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

class AddressInitial extends AddressState {}

class AddressLoaded extends AddressState {
  final Address address;

  AddressLoaded(this.address);

  @override
  List<Object> get props => [address];
}
class AddressListLoaded extends AddressState {
  final List<Address> address;

  AddressListLoaded(this.address);

  @override
  List<Object> get props => [address];
}
class AddressLoadingFailed extends AddressState {
  final String message;

  AddressLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}