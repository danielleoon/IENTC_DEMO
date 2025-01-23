import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ientc_jdls/providers/events/IndexEvent.dart';
import 'package:ientc_jdls/providers/states/IndexState.dart';

class IndexBloc extends Bloc<IndexEvent, IndexState> {
  IndexBloc() : super(IndexInitialState()) {
    on<ChangeIndexEvent>((event, emit) {
      final currentState = state;
      if (event.newIndex != currentState.selectedIndex ||
          (currentState.selectedIndex == 0 &&
              currentState.selectedIndex2 == 0)) {
        emit(IndexUpdatedState(event.newIndex, currentState.selectedIndex2));
      }
    });

    on<ResetSubIndexEvent>((event, emit) {
      final currentState = state;
      if (currentState.selectedIndex == 0) {
        emit(IndexUpdatedState(currentState.selectedIndex, 0));
      }
    });
  }
}
