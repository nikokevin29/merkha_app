part of 'comment_cubit.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {}

class CommentListLoaded extends CommentState {
  final List<Comment> comment;

  CommentListLoaded(this.comment);

  @override
  List<Object> get props => [comment];
}
class CommentLoaded extends CommentState {
  final Comment comment;

  CommentLoaded(this.comment);

  @override
  List<Object> get props => [comment];
}

class CommentFailed extends CommentState {
  final String message;

  CommentFailed(this.message);

  @override
  List<Object> get props => [message];
}