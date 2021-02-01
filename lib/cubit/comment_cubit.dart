import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentInitial());

  Future<void> showCommentById(String idFeed) async {
    ApiReturnValue<List<Comment>> result = await CommentService.showCommentById(id: idFeed);
    if (result.value != null) {
      emit(CommentListLoaded(result.value));
    } else {
      emit(CommentFailed(result.message));
    }
  }

  Future<void> sendComment(Comment comment) async {
    ApiReturnValue<Comment> result = await CommentService.sendComment(comment: comment);
    if (result.value != null) {
      emit(CommentLoaded(result.value));
    } else {
      print('Failed Send Comment');
      emit(CommentFailed('Failed Send Comments'));
    }
  }
}
