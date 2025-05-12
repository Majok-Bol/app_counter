import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial()) {
    //first event
    on<CounterInitialEvent>(counterInitialEvent);
    //handle increment counter event
    on<CounterIncrementEvent>(counterIncrementEvent);
    //handle decrement counter event
    on<CounterDecrementEvent>(counterDecrementEvent);
    on<CounterResetEvent>(counterResetEvent);
  }
  int count = 0;
  //initial event
  //start counter at 0
  FutureOr<void> counterInitialEvent(
    CounterInitialEvent event,
    Emitter<CounterState> emit,
  ) async {
    //go into loading state
    emit(CounterLoadingState());
    //wait for 3 seconds
    //show whole page
    await Future.delayed(Duration(seconds: 3));
    emit(CounterLoadingStateSuccessful(val: count));
  }

  //handle increasing the counter
  FutureOr<void> counterIncrementEvent(
    CounterIncrementEvent event,
    Emitter<CounterState> emit,
  ) {
    count++;
    //rebuild the UI
    emit(CounterLoadingStateSuccessful(val: count));
    //check if value exceeds maximum value
    if (count >= 10) {
      count = 10;
      emit(CounterMaximumValueState(count: count));
    }
  }

  //handle decreasing the counter
  FutureOr<void> counterDecrementEvent(
    CounterDecrementEvent event,
    Emitter<CounterState> emit,
  ) {
    count--;
    //rebuild the UI
    emit(CounterLoadingStateSuccessful(val: count));
    //check if minimum value is reached
    if (count <= 0) {
      count = 0;
      emit(CounterMinimumValueState(count: count));
    }
  }

  //handle reset button
  FutureOr<void> counterResetEvent(
    CounterResetEvent event,
    Emitter<CounterState> emit,
  ) {
    count = 0;
    emit(CounterLoadingStateSuccessful(val: count));
  }
}
