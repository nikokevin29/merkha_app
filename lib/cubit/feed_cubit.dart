import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'feed_state.dart';

class FeedCubit extends Cubit<FeedState> {
  FeedCubit() : super(FeedInitial());
  ApiReturnValue<List<Feed>> result;
  Future<void> showAllFeed() async {
    if (state is FeedInitial) {
      result = await FeedServices.showAllFeedFollowed(start: 0, end: 3);
      emit(FeedListLoaded(feed: result.value, hasReachedMax: false));
    } else {
      FeedListLoaded feedListLoaded = state as FeedListLoaded;
      print(result.value.length);
      result = await FeedServices.showAllFeedFollowed(start: result.value.length, end: 3); //

      (result.value.isEmpty)
          ? emit(feedListLoaded.copyWith(hasReachedMax: true))
          : emit(FeedListLoaded(feed: feedListLoaded.feed + result.value, hasReachedMax: false));
    }
    //  else {
    //   emit(FeedFailed(result.message));
    // }
    //ApiReturnValue<List<Feed>> result = await FeedServices.showAllFeedFollowed();
    // if (result.value != null) {
    //   emit(FeedListLoaded(feed: result.value));
    // } else {
    //   emit(FeedFailed(result.message));
    // }
  }

  void callFeedLoaded() => emit(FeedListLoaded());

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
