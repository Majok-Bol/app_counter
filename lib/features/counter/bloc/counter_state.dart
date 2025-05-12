part of 'counter_bloc.dart';

@immutable
//blueprint for creating states
sealed class CounterState {}

final class CounterInitial extends CounterState {}

class CounterInitialState {}

//handle increment counter state
//rebuilds the text counter value
class CounterIncrementState extends CounterState {}

class CounterDecrementState extends CounterState {}

//check if maximum value is reached
class CounterMaximumValueState extends CounterState {
  final int count;

  CounterMaximumValueState({required this.count});
}

//check if minimum value is reached
class CounterMinimumValueState extends CounterState {
  final int count;

  CounterMinimumValueState({required this.count});
}

//check if loading state
class CounterLoadingState extends CounterState {}

//check if loading successful
class CounterLoadingStateSuccessful extends CounterState {
  final int val;

  CounterLoadingStateSuccessful({required this.val});
}

//reset state
class CounterResetState extends CounterState {
  final int value;

  CounterResetState({required this.value});
}
