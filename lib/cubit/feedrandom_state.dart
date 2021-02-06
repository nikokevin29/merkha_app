part of 'feedrandom_cubit.dart';

abstract class FeedrandomState extends Equatable {
  const FeedrandomState();

  @override
  List<Object> get props => [];
}

class FeedrandomInitial extends FeedrandomState {}

class FeedRandomListLoaded extends FeedrandomState {
  final List<Feed> feed;

  FeedRandomListLoaded(this.feed);

  @override
  List<Object> get props => [feed];
}

class FeedRandomFailed extends FeedrandomState {
  final String message;

  FeedRandomFailed(this.message);

  @override
  List<Object> get props => [message];
}