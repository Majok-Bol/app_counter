part of 'counter_bloc.dart';

@immutable
sealed class CounterEvent {}

//initial event
//start counter at 0
class CounterInitialEvent extends CounterEvent {
  final int val;

  CounterInitialEvent({required this.val});
}

//first event
//increment a counter button
class CounterIncrementEvent extends CounterEvent {}

//handle decrement counter button
class CounterDecrementEvent extends CounterEvent {}

//reset button
class CounterResetEvent extends CounterEvent {}
