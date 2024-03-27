import 'dart:async';

import 'package:battery_level_app/home/data/model/battery_model.dart';
import 'package:battery_level_app/home/data/repository/history_repository.dart';
import 'package:battery_level_app/home/data/view_model_bloc/battery_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// Events
abstract class BatteryHistoryEvent extends Equatable {}

class BatteryHistoryEventPressed extends BatteryHistoryEvent {

  BatteryHistoryEventPressed();

  @override
  List<Object?> get props => [];
}

// States
abstract class BatteryHistoryState extends Equatable {}

class BatteryHistoryInitial extends BatteryHistoryState {
  @override
  List<Object?> get props => [];
}

class BatteryHistoryLoading extends BatteryHistoryState {
  @override
  List<Object?> get props => [];

}

class BatteryHistorySuccess extends BatteryHistoryState {
  @override
  List<Object?> get props => [batteryModelList];
  List<BatteryModel>? batteryModelList;
  BatteryHistorySuccess({required this.batteryModelList});
}

class BatteryHistoryFailure extends BatteryHistoryState {
  final String message;

  BatteryHistoryFailure({required this.message});

  @override
  List<Object?> get props => [message];

}

// BLoC
class BatteryHistoryBloc extends Bloc<BatteryHistoryEvent, BatteryHistoryState> {
  final BatteryHistoryRepository batteryHistoryRepository;
  final _batteryHistoryController = StreamController<List<BatteryModel>>.broadcast();

  // Expose a stream for the UI to listen to
  Stream<List<BatteryModel>> get streamData => _batteryHistoryController.stream;

  // Method to add new data to the stream
  void updateOrderList(List<BatteryModel> batteryList) {
    _batteryHistoryController.add(batteryList);
  }

  // Clean up resources when the BLoC is no longer needed
  void dispose() {
    _batteryHistoryController.close();
  }

  BatteryHistoryBloc({required this.batteryHistoryRepository}) : super(BatteryHistoryInitial())
  {
    on<BatteryHistoryEvent>(_onFetchEvent);
  }

  Future<BatteryHistoryState?> _onFetchEvent(
      BatteryHistoryEvent event, Emitter<BatteryHistoryState> emit) async {
    if (event is BatteryHistoryEventPressed) {

      emit(BatteryHistoryLoading());
      try {
        List<BatteryModel>? batterModelList = await batteryHistoryRepository.fetchBatteryHistory();

        emit(BatteryHistorySuccess( batteryModelList:batterModelList));
        _batteryHistoryController.add(batterModelList!);

      } catch (e) {
        emit(BatteryHistoryFailure(message: e.toString()));
      }
    }
  }
}
