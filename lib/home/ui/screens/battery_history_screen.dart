import 'package:battery_level_app/home/data/view_model_bloc/history_view_model.dart';
import 'package:battery_level_app/home/ui/widgets/battery_history_widget.dart';
import 'package:battery_level_app/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BatteryHistoryScreen extends StatelessWidget {
  const BatteryHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(StringUtils.batteryHistory,
      style: Theme.of(context).textTheme.headlineSmall,),),
      body: BlocBuilder<BatteryHistoryBloc, BatteryHistoryState>(
        builder: (context, state) {
          if(state is BatteryHistoryInitial)
          {
            ///Fetching the battery status sqflite pub retreiving the data from locally  (https://pub.dev/packages/sqflite)
            context.read<BatteryHistoryBloc>().add(BatteryHistoryEventPressed());
            return const Center(child: CircularProgressIndicator());
          }
          else if (state is BatteryHistorySuccess) {
            return batteryHistoryWidget(context,state.batteryModelList);
          } else {
            return  Center(
              child: Text(StringUtils.waitingForBatteryInfo),
            );
          }
        },
      ),
    );
  }


}
