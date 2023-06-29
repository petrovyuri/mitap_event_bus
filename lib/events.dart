import 'event_bus/event.dart';

/// Событие - если счетчик изменился
class CounterIsEven<int> extends Event {
  const CounterIsEven(data) : super('Число четное $data');
}
