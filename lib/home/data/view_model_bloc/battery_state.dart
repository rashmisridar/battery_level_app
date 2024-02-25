part of 'battery_bloc.dart';


sealed class BatteryTickerState extends Equatable {
  const BatteryTickerState();

  @override
  List<Object> get props => [];
}

final class BatteryTickerInitial extends BatteryTickerState {}


final class BatteryTickerTickSuccess extends BatteryTickerState {
  const BatteryTickerTickSuccess(this.count,this.batteryPercentage,
      this.batteryCategory,
      this.batteryIndicator);

  final BatteryState count;
  final int batteryPercentage;
  final String batteryCategory;
  final Color batteryIndicator;


  @override
  List<Object> get props => [count,batteryPercentage,
    batteryCategory,batteryIndicator];
}


final class BatteryTickerComplete extends BatteryTickerState {
  const BatteryTickerComplete();
}
