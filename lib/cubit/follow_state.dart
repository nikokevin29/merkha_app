part of 'follow_cubit.dart';

abstract class FollowState extends Equatable {
  const FollowState();

  @override
  List<Object> get props => [];
}

class FollowInitial extends FollowState {}

class FollowLoaded extends FollowState {
  final Following follow;

  FollowLoaded(this.follow);

  @override
  List<Object> get props => [follow];
}

class FollowCheck extends FollowState {
  final String idCheck;

  FollowCheck(this.idCheck);

  @override
  List<Object> get props => [idCheck];
}

class FollowListLoaded extends FollowState {
  final List<Following> follow;

  FollowListLoaded(this.follow);

  @override
  List<Object> get props => [follow];
}

class FollowFailed extends FollowState {
  final String message;

  FollowFailed(this.message);

  @override
  List<Object> get props => [message];
}
