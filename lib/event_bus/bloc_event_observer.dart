import 'package:mitap_event_bus/event_bus/event.dart';

abstract mixin class BlocEventObserver {
  List<Type> get observableEventTypes;

  void onEventEmitted(Event event);

  bool isSubscribed(Type eventType) {
    return observableEventTypes.contains(eventType);
  }
}
