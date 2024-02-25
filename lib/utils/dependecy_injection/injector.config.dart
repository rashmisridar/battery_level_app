import 'package:battery_level_app/home/data/data_source/history_local_data_source.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:injectable/injectable.dart';



@InjectableInit(preferRelativeImports: true)
_i1.GetIt $initGetIt(
    _i1.GetIt getIt, {
      String? environment,
      _i2.EnvironmentFilter? environmentFilter,
    }) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i4.HistoryLocalDataSource>(() => _i4.HistoryLocalDataSource());

  return getIt;

}
