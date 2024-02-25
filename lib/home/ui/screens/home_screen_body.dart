import 'dart:async';
import 'package:battery_level_app/home/data/view_model_bloc/battery_bloc.dart';
import 'package:battery_level_app/home/ui/widgets/battery_success_widget.dart';
import 'package:battery_level_app/utils/router/my_router.dart';
import 'package:battery_level_app/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:background_fetch/background_fetch.dart';

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
    // Initialize the background fetch
    initPlatformState();
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

  Future<void> initPlatformState() async {
    // Load persisted fetch events from SharedPreferences


    // Configure BackgroundFetch.
    try {
      var status = await BackgroundFetch.configure(BackgroundFetchConfig(
          minimumFetchInterval: 15,
          forceAlarmManager: false,
          stopOnTerminate: false,
          startOnBoot: true,
          enableHeadless: true,
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresStorageNotLow: false,
          requiresDeviceIdle: false,
          requiredNetworkType: NetworkType.NONE
      ), _onBackgroundFetch, _onBackgroundFetchTimeout);
      print('[BackgroundFetch] configure success: $status');
      setState(() {
        //_status = status;
      });

      // Schedule a "one-shot" custom-task in 10000ms.
      // These are fairly reliable on Android (particularly with forceAlarmManager) but not iOS,
      // where device must be powered (and delay will be throttled by the OS).
      BackgroundFetch.scheduleTask(TaskConfig(
          taskId: "com.transistorsoft.customtask",
          delay: 10000,
          periodic: false,
          forceAlarmManager: true,
          stopOnTerminate: false,
          enableHeadless: true
      ));
    } on Exception catch(e) {
      print("[BackgroundFetch] configure ERROR: $e");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  void _onBackgroundFetchTimeout(String taskId) {
    print("[BackgroundFetch] TIMEOUT: $taskId");
    BackgroundFetch.finish(taskId);
  }

  void _onBackgroundFetch(String taskId) async {
    // This is the fetch-event callback.
    print("[BackgroundFetch] Event received: $taskId");

    parentKey.currentState!.context.read<BatteryBloc>().add(const BatteryEventStarted(addDB: true));

    if (taskId == "flutter_background_fetch") {
      // Perform an example HTTP request.

    }
    // IMPORTANT:  You must signal completion of your fetch task or the OS can punish your app
    // for taking too long in the background.
    BackgroundFetch.finish(taskId);
  }
}
