import 'dart:async';

import 'package:battery_level_app/home/data/battery_model.dart';
import 'package:battery_level_app/home/data/repository/history_repository.dart';
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
      } catch (e) {
        emit(BatteryHistoryFailure(message: e.toString()));
      }
    }
  }
}
