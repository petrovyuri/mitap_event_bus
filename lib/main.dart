import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitap_event_bus/cubits/counter_cubit/counter_cubit.dart';
import 'package:mitap_event_bus/cubits/listen_cubit/listen_cubit.dart';
import 'package:mitap_event_bus/event_bus/event_bus.dart';

import 'event_bus/event.dart';

/// Создание экземпляра шины событий
EventBus eventBus = EventBus();

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const App()));
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CounterCubit>().increment();

          /// После каждой смены состояния счетчика, отправляем событие в шину
          /// если счетчик четный
          final counter = context.read<CounterCubit>().state;
          if (counter.isEven) {
            eventBus.addEvent(CounterIsEven(counter));
          }
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
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
          ],
        ),
      ),
    );
  }
}
