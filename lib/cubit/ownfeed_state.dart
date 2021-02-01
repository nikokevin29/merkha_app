part of 'ownfeed_cubit.dart';

abstract class OwnfeedState extends Equatable {
  const OwnfeedState();

  @override
  List<Object> get props => [];
}

class OwnfeedInitial extends OwnfeedState {}

class OwnFeedListLoaded extends OwnfeedState {
  final List<Feed> feed;

  OwnFeedListLoaded(this.feed);

  @override
  List<Object> get props => [feed];
}
class OwnFeedFailed extends OwnfeedState {
  final String message;

  OwnFeedFailed(this.message);

  @override
  List<Object> get props => [message];
}