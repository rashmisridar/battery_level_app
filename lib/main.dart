import 'package:battery_level_app/home/data/view_model_bloc/battery_bloc.dart';
import 'package:battery_level_app/home/data/view_model_bloc/history_view_model.dart';
import 'package:battery_level_app/my_app.dart';
import 'package:battery_level_app/utils/dependecy_injection/get_it_init.dart';
import 'package:battery_level_app/utils/router/my_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmanager/workmanager.dart';

void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false, // Set to true if you want to see debug print statements
  );
  ///Entry point flutter app
  runApp(const MyApp());


}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    // Your background task logic goes here
    print("Background task executed");
    parentKey.currentState!.context.read<BatteryBloc>().add(const BatteryEventStarted(addDB: true));

    return Future.value(true);
  });
}
