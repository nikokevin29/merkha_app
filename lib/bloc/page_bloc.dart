import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(OnLoginSignupPage());

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is GoToMainPage) {
      yield OnMainPage();
    } else if (event is GoToLoginPage) {
      yield OnLoginPage();
    } else if (event is GoToLoginSignupPage) {
      yield OnLoginSignupPage();
    }
  }
}
