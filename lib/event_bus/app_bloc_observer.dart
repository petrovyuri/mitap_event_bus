import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitap_event_bus/event_bus/bloc_event_observer.dart';
import 'package:mitap_event_bus/events.dart';

class AppBlocObserver extends BlocObserver {
  final _observers = <BlocEventObserver>[];

  AppBlocObserver._();

  static final instance = AppBlocObserver._();

  @override
  void onChange(BlocBase bloc, Change change) {
    for (final observer in _observers) {
      if (observer.isSubscribed(CounterIsEven)) {
        observer.onEventEmitted(CounterIsEven(change.nextState as int));
      }
    }
    super.onChange(bloc, change);
  }

  void addObserver(BlocEventObserver observer) {
    _observers.add(observer);
  }

  void deleteObserver(BlocEventObserver observer) {
    _observers.remove(observer);
  }
}
