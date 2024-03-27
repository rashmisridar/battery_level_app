import 'package:battery_level_app/home/data/model/battery_model.dart';
import 'package:battery_level_app/home/data/data_source/history_local_data_source.dart';
import 'package:battery_level_app/utils/dependecy_injection/get_it_init.dart';

class BatteryHistoryRepository{


  final _historyLocalDataSource = getIt<HistoryLocalDataSource>();


  Future<List<BatteryModel>?> fetchBatteryHistory() async {
    return _historyLocalDataSource.fetchBatteryHistory();
  }
}