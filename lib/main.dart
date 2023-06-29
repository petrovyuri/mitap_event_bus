import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitap_event_bus/app_bloc_observer.dart';
import 'package:mitap_event_bus/cubits/counter_cubit/counter_cubit.dart';
import 'package:mitap_event_bus/cubits/listen_cubit/listen_cubit.dart';
import 'package:mitap_event_bus/event_bus/event_bus.dart';

EventBus eventBus = EventBus();

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const MaterialApp(home: Scaffold(body: App())));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CounterCubit(),
        ),
        BlocProvider(
          create: (context) => ListenCubit(eventBus),
        ),
      ],
      child: _CounterScreenView(),
    );
  }
}

class _CounterScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          const SizedBox(height: 30),
          BlocBuilder<ListenCubit, String>(
            builder: (context, state) {
              return Text(
                state.toString(),
                style: Theme.of(context).textTheme.headlineMedium,
              );
            },
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 30),
                BlocBuilder<CounterCubit, int>(
                  builder: (context, state) {
                    return Text(
                      state.toString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    );
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                context.read<CounterCubit>().increment();
              },
              child: const Icon(Icons.add),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: ElevatedButton(
              onPressed: () {
                context.read<CounterCubit>().decrement();
              },
              child: const Icon(Icons.remove),
            ),
          ),
        ],
      ),
    );
  }
}
