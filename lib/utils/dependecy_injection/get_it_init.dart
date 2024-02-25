import 'package:battery_level_app/utils/dependecy_injection/injector.config.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void configureDependencies() => $initGetIt(getIt);
