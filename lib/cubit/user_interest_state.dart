part of 'user_interest_cubit.dart';

abstract class UserInterestState extends Equatable {
  const UserInterestState();

  @override
  List<Object> get props => [];
}

class UserInterestInitial extends UserInterestState {}


class UserInterestLoaded extends UserInterestState {
  final List<UserInterest> userInterest;
  UserInterestLoaded(this.userInterest);
  @override
  List<Object> get props => [userInterest];
}

class UserInterestLoadingFailed extends UserInterestState {
  final String message;

  UserInterestLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}