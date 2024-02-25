import 'dart:async';
import 'package:battery_level_app/home/data/view_model_bloc/battery_bloc.dart';
import 'package:battery_level_app/home/ui/widgets/battery_success_widget.dart';
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
 /*   const duration = Duration(minutes: 15);
    Timer.periodic(duration, (Timer timer) {
      if(mounted) {
        context.read<BatteryBloc>().add(const BatteryEventStarted());
      }
    });*/
    // Initialize the background fetch
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BatteryBloc, BatteryTickerState>(
      builder: (context, state) {
        if(state is BatteryTickerInitial)
          {
            context.read<BatteryBloc>().add(const BatteryEventStarted());

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
    // Configure the background fetch
    int status = await BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 15, // Set the minimum interval in minutes
        stopOnTerminate: false,
        startOnBoot: true,
        enableHeadless: true,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: NetworkType.NONE,
      ),
          (String taskId) async {
        // Your background task logic goes here
        print('Background fetch taskId: $taskId');
        // Call your method here
        if(mounted) {
          context.read<BatteryBloc>().add(const BatteryEventStarted());
        }

        BackgroundFetch.finish(taskId);
      },(String taskId){

    });
    print('[BackgroundFetch] configure success: $status');

  }
}
