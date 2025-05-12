import 'package:app_counter/features/counter/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  //load initial event
  @override
  void initState() {
    counterBloc.add(CounterInitialEvent(val: 0));
    // TODO: implement initState
    super.initState();
  }

  //create instance of counter bloc
  final CounterBloc counterBloc = CounterBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CounterBloc, CounterState>(
      bloc: counterBloc,
      listener: (context, state) {
        //listens for these states
        //only notify the states
        //not rebuilding the UI

        //check if maximum is reached
        if (state is CounterMaximumValueState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Reached Maximum value')));
        }
        if (state is CounterMinimumValueState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Reached Minimum Value')));
        }
      },
      builder: (context, state) {
        if (state is CounterLoadingState) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (state is CounterLoadingStateSuccessful ||
            state is CounterMaximumValueState ||
            state is CounterMinimumValueState) {
          int count = 0;
          if (state is CounterLoadingStateSuccessful) {
            count = state.val;
          }
          if (state is CounterMaximumValueState) {
            count = 10;
          }
          if (state is CounterMinimumValueState) {
            count = 0;
          }

          return Scaffold(
            backgroundColor: Colors.grey.shade300,
            appBar: AppBar(
              title: Text('Counter App', style: TextStyle(fontSize: 22)),
              centerTitle: true,
              backgroundColor: Colors.grey.shade400,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Counter:   $count',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        counterBloc.add(CounterIncrementEvent());
                      },
                      child: Icon(Icons.add),
                    ),
                    MaterialButton(
                      onPressed: () {
                        counterBloc.add(CounterDecrementEvent());
                      },
                      child: Icon(Icons.remove),
                    ),
                    MaterialButton(
                      onPressed: () {
                        counterBloc.add(CounterResetEvent());
                      },
                      child: Icon(Icons.refresh),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
