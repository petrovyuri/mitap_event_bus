import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitap_event_bus/event_bus/event.dart';

abstract class ObserverCubit<T> extends Cubit<T> {
  ObserverCubit(super.state);

  void onEventEmitted(Event event);

  List<Type> get observableEventTypes;
}
