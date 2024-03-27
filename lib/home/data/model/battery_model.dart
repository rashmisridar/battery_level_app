// battery_model.dart
class BatteryModel {
  int batteryPercentage;
  String batteryCategory;
  int timeStamp;
  int? id;


  BatteryModel({ this.id,
    required this.batteryPercentage,
  required this.batteryCategory,
  required this.timeStamp});

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'batteryPercentage': batteryPercentage,
      'batteryCategory':batteryCategory,
      'timeStamp':timeStamp
    };
  }

  factory BatteryModel.fromMap(Map<String, dynamic> map) {
    return BatteryModel(
      id :map['id'],
      batteryPercentage: map['batteryPercentage'],
      batteryCategory: map['batteryCategory'],
        timeStamp: map["timeStamp"]
    );
  }
}
