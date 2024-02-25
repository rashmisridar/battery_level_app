import 'dart:async';

import 'package:battery_level_app/home/data/battery_model.dart';
import 'package:battery_level_app/home/data/data_source/history_local_data_source.dart';
import 'package:battery_level_app/utils/color_utils.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'battery_event.dart';
part 'battery_state.dart';


class BatteryBloc extends Bloc<BatteryEvent, BatteryTickerState> {

  BatteryBloc() : super(BatteryTickerInitial()) {
    on<BatteryEventStarted>(
      (event, emit) async {
        ///Battery plus pub used for fetching the battery status (https://pub.dev/packages/battery_plus)
        var battery = Battery();
        /// Battery level returns the percentage of battery
       int batteryLevel= await battery.batteryLevel;
       ///Based on battery level taking the decision on battery status like Good, Poor , Fair
       String batteryCategory =_getBatteryCategory(batteryLevel);
       /// Based on the battery category battery indicator in the ui is displayed in green, orange, and red color
       Color batteryIndicatory = batteryIndicator(batteryCategory)??ColorUtils.green;
       ///Adding batteryStatus to local data base
       batteryStatusInsertQuery(batteryLevel,batteryCategory);
       ///Sending the data in stream
        await emit.onEach<BatteryState>(
         battery.onBatteryStateChanged,
          onData: (tick) => add(_BatteryStatus(tick,batteryLevel,
              batteryCategory,
              batteryIndicatory)),
        );
        emit(const BatteryTickerComplete());
      },
      transformer: restartable(),
    );

    on<_BatteryStatus>((event, emit) => emit(BatteryTickerTickSuccess(event.tick,
        event.batteryPercent,
        event.batteryCategory,event.batteryIndicator)));
  }
  ///Based on battery level taking the decision on battery status like Good, Poor , Fair
  String _getBatteryCategory(int batteryLevel) {
    if (batteryLevel >= 80) {
      return 'Good';
    } else if (batteryLevel >= 30) {
      return 'Fair';
    } else {
      return 'Poor';
    }
  }

  /// Based on the battery category battery indicator in the ui is displayed in green, orange, and red color

  Color? batteryIndicator(String batteryCategory) {
    switch(batteryCategory)
        {
      case "Good":
          return ColorUtils.green;
      case "Fair":
        return ColorUtils.orange;
      case "Poor":
        return ColorUtils.red;
      default :
        return ColorUtils.green;
    }
  }

  Future<void> batteryStatusInsertQuery(batteryLevel,batteryCategory) async {
    HistoryLocalDataSource dbHelper = HistoryLocalDataSource();
    BatteryModel batteryModel = BatteryModel(batteryPercentage: batteryLevel,
        batteryCategory:batteryCategory, timeStamp: DateTime.now().millisecondsSinceEpoch);
    await dbHelper.insertBatteryData(batteryModel);
  }
}
