import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitap_event_bus/event_bus/event.dart';
import 'package:mitap_event_bus/event_bus/event_bus.dart';

class ListenCubit extends Cubit<String> {
  ListenCubit(this.eventBus) : super('Start') {
    subscription = eventBus.on<CounterIsEven>().listen((event) {
      emit(event.data);
    });
  }

  final EventBus eventBus;
  late final StreamSubscription subscription;

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }
}
