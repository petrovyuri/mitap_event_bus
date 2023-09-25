import 'package:equatable/equatable.dart';

/// Родительский класс событий
abstract interface class Event<T> extends Equatable {
  const Event(this.data);

  final T data;

  @override
  List<Object?> get props => [data];
}

/// Событие - если счетчик изменился
class CounterIsEven<int> extends Event {
  const CounterIsEven(data) : super('Число четное $data');
}
