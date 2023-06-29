import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitap_event_bus/event_bus/app_bloc_observer.dart';
import 'package:mitap_event_bus/event_bus/bloc_event_observer.dart';
import 'package:mitap_event_bus/event_bus/event.dart';
import 'package:mitap_event_bus/events.dart';

class ListenCubit extends Cubit<String> with BlocEventObserver {
  ListenCubit() : super('Start') {
    AppBlocObserver.instance.addObserver(this);
  }

  @override
  Future<void> close() {
    AppBlocObserver.instance.deleteObserver(this);
    return super.close();
  }

  @override
  List<Type> get observableEventTypes => [CounterIsEven];

  @override
  void onEventEmitted(Event event) {
    emit("aasdasd");
  }
}
