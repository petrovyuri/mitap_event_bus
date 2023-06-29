import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitap_event_bus/cubits/counter_cubit/counter_cubit.dart';

class ListenCubit extends Cubit<String> {
  ListenCubit(this.counterCubit) : super('Start') {
    subscription = counterCubit.stream.distinct(
      (previous, next) {
        return next.isOdd;
      },
    ).listen((event) {
      emit("Число четное $event");
    });
  }

  final CounterCubit counterCubit;
  late final StreamSubscription subscription;

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }
}
