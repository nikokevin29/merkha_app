part of 'update_user_cubit.dart';

abstract class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object> get props => [];
}

class UpdateUserInitial extends UpdateUserState {}


class UpdateUserLoaded extends UpdateUserState {
  final User user;

  UpdateUserLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class UserUpdateLoadingFailed extends UpdateUserState {
  final String message;

  UserUpdateLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}