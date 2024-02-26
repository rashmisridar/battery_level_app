import 'dart:async';
import 'package:battery_level_app/home/data/view_model_bloc/battery_bloc.dart';
import 'package:battery_level_app/home/ui/widgets/battery_success_widget.dart';
import 'package:battery_level_app/utils/router/my_router.dart';
import 'package:battery_level_app/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmanager/workmanager.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {

  @override
  void initState() {
    super.initState();
    /// Every 15min fetching the battery status
    startPeriodicTask();
  }

  void startPeriodicTask() {
    parentKey.currentState!.context.read<BatteryBloc>().add(const BatteryEventStarted(addDB: true));

    Workmanager().registerPeriodicTask(
      "periodicTask", // unique name for the task
      "simplePeriodicTask", // task name (you will use this to cancel the task)
      frequency: Duration(minutes: 15), // set the interval
      constraints: Constraints(
        requiresCharging: false,
        networkType: NetworkType.connected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BatteryBloc, BatteryTickerState>(
      builder: (context, state) {
        if(state is BatteryTickerInitial)
          {

            return const Center(child: CircularProgressIndicator());
          }
        else if (state is BatteryTickerTickSuccess) {
          ///Displaying the battery widget
          return batterySuccessWidget(context,state.count,state.batteryPercentage,
              state.batteryCategory,state.batteryIndicator);
        }
        else {
          return  Center(
            child: Text(StringUtils.waitingForBatteryInfo),
          );
        }
      },
    );
  }


}
