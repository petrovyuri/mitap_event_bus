import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitap_event_bus/cubits/counter_cubit/counter_cubit.dart';
import 'package:mitap_event_bus/event_bus/observer_cubit.dart';
import 'package:mitap_event_bus/events.dart';

class AppBlocObserver extends BlocObserver {
  final _observers = <ObserverCubit>[];

  @override
  void onChange(BlocBase bloc, Change change) {
    if (bloc is CounterCubit) {
      _isCounterEvent(change);
    }

    super.onChange(bloc, change);
  }

  void _isCounterEvent(Change<dynamic> change) {
    final counter = change.nextState as int;
    if (counter.isEven) {
      for (final observer in _observers) {
        if (observer.observableEventTypes.contains(CounterIsEven)) {
          observer.onEventEmitted(CounterIsEven(counter));
        }
      }
    }
  }

  @override
  void onCreate(BlocBase bloc) {
    if (bloc is ObserverCubit) {
      _observers.add(bloc);
    }
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    if (bloc is ObserverCubit) {
      _observers.remove(bloc);
    }
    super.onClose(bloc);
  }
}
