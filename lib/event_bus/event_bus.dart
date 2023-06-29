import 'dart:async';

import 'event.dart';

final class EventBus {
  final StreamController _streamController = StreamController.broadcast();

  /// Метод, возвращает стрим при изменении события
  Stream<T> on<T>() async* {
    yield* _streamController.stream.where((event) => event is T).cast<T>();
  }

  /// Добавление события в шину
  void addEvent(Event event) {
    _streamController.add(event);
  }

  /// Закрытие контроллера
  void dispose() {
    _streamController.close();
  }
}
