import 'package:battery_level_app/home/data/repository/history_repository.dart';
import 'package:battery_level_app/home/data/view_model_bloc/history_view_model.dart';
import 'package:battery_level_app/home/data/view_model_bloc/battery_bloc.dart';
import 'package:battery_level_app/utils/router/my_router.dart';
import 'package:battery_level_app/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ///Bloc provider registration
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) =>  BatteryBloc(),
      ),
      BlocProvider(
        create: (context) =>  BatteryHistoryBloc(batteryHistoryRepository: BatteryHistoryRepository()),
      ),
      ],
      child: Builder(
          builder: (context) {
            ///GoRouter 2.0 for screen navigation
            return MaterialApp.router(
              routerConfig: MyRouter().router,
              /// Custom Theme handling
              theme: AppTheme.dark,
            );
          }
      ),
    );
  }
}
