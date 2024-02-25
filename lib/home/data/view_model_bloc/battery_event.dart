part of 'battery_bloc.dart';


sealed class BatteryEvent extends Equatable {
  const BatteryEvent();

  @override
  List<Object> get props => [];
}


final class BatteryEventStarted extends BatteryEvent {
  const BatteryEventStarted();
}

final class _BatteryStatus extends BatteryEvent {
  const _BatteryStatus(this.tick,this.batteryPercent,this.batteryCategory,this.batteryIndicator );
  final int batteryPercent;
  final BatteryState tick;
  final String batteryCategory;
  final Color batteryIndicator;

  @override
  List<Object> get props => [tick,batteryPercent,batteryCategory,batteryIndicator];
}
