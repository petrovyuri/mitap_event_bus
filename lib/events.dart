import 'event_bus/event.dart';

/// Событие - если счетчик изменился
class CounterIsEven<Object> extends Event {
  const CounterIsEven(data) : super('Число четное $data');
}
