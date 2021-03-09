import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';
import 'package:http/http.dart' as http;

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedStates> {
  final http.Client httpClient;
  FeedBloc({this.httpClient}) : super(FeedInitials());
  ApiReturnValue<List<Feed>> result;
  @override
  Stream<FeedStates> mapEventToState(FeedEvent event) async* {
    if (event is FeedFetched && !_hasReachedMax(state)) {
      try {
        if (state is FeedInitials) {
          result = await FeedServices.showAllFeedFollowed(start: 0, end: 3);
          yield FeedSuccess(feed: result.value, hasReachedMax: false);
          return;
        }
        if (state is FeedSuccess) {
          FeedSuccess feedSuccess = state as FeedSuccess;
          result = await FeedServices.showAllFeedFollowed(start: feedSuccess.feed.length, end: 3);
          yield (result.value.isEmpty)
              ? feedSuccess.copyWith(hasReachedMax: true)
              : FeedSuccess(
                  feed: feedSuccess.feed + result.value,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield FeedFailure();
      }
    }
    if (event is FeedRefresh) {
      result = await FeedServices.showAllFeedFollowed(start: 0, end: 3);
      yield FeedSuccess(feed: result.value, hasReachedMax: false);
      return;
    }
  }
}

bool _hasReachedMax(FeedStates state) => state is FeedSuccess && state.hasReachedMax;
