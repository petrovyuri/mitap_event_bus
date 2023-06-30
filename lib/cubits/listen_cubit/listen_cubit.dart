import 'package:mitap_event_bus/event_bus/event.dart';
import 'package:mitap_event_bus/event_bus/observer_cubit.dart';
import 'package:mitap_event_bus/events.dart';

class ListenCubit extends ObserverCubit<String> {
  ListenCubit() : super('Start');

  @override
  List<Type> get observableEventTypes => [CounterIsEven];

  @override
  void onEventEmitted(Event event) {
    emit(event.data);
  }
}
