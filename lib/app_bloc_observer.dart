import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitap_event_bus/cubits/counter_cubit/counter_cubit.dart';
import 'package:mitap_event_bus/events.dart';
import 'package:mitap_event_bus/main.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    if (bloc is CounterCubit) {
      final counter = change.nextState as int;
      if (counter.isEven) {
        eventBus.addEvent(CounterIsEven(counter));
      }
    }
    super.onChange(bloc, change);
  }
}
