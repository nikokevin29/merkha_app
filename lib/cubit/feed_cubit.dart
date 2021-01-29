import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'feed_state.dart';

class FeedCubit extends Cubit<FeedState> {
  FeedCubit() : super(FeedInitial());

  Future<void> showAllFeed() async {
    ApiReturnValue<List<Feed>> result = await FeedServices.showAllFeedFollowed();
    if (result.value != null) {
      emit(FeedListLoaded(result.value));
    } else {
      emit(FeedFailed(result.message));
    }
  }

  Future<void> createFeed(
      {File urlPhoto, String location, String caption, String idProduct}) async {
    var result = await FeedServices.createFeed(
      location: location,
      caption: caption,
      idProduct: idProduct,
      urlPhoto: urlPhoto,
    );
    if (result != 0) {
      print('Create Success Feed');
      //emit(FeedLoaded(result));
    } else {
      print('Error API Create Feed');
      //emit(FeedFailed(result.message));
    }
  }
}
