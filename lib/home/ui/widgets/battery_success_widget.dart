import 'package:battery_level_app/utils/router/my_navigator.dart';
import 'package:battery_level_app/utils/string_utils.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Widget batterySuccessWidget(BuildContext context, BatteryState state,
    int batteryPercentage,String batteryCategory,
    Color batteryIndicator) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10.0,10,10,10),
    child: Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(StringUtils.batteryInformation,
                  style: Theme.of(context).textTheme!.headlineSmall,
                ),

                IconButton(onPressed: ((){
                  MyNavigator.goToBatteryHistory(context);

                }), icon: Icon(Icons.battery_saver_sharp))
              ],
            ),
            SizedBox(height: 30,),

            Card(
              elevation: 5, // Set the elevation for the card
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Column(
                      children: [
                        Text(StringUtils.batteryStatus,
                          style: Theme.of(context).textTheme!.bodySmall,
                        ),

                        SizedBox(height: 10,),
                        Text("${state.name.toUpperCase()}",
                          style: Theme.of(context).textTheme!.headlineSmall,
                        ),
                      ],
                    ),

                    VerticalDivider(
                      color: Colors.grey,
                      thickness: 2,
                    ),

                    Column(
                      children: [
                        Text(StringUtils.batteryCategory,
                          style: Theme.of(context).textTheme!.bodySmall,
                        ),

                        SizedBox(height: 10,),
                        Text(batteryCategory,
                          style: Theme.of(context).textTheme!.headlineSmall,
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(height: 30,),
            CircularPercentIndicator(
              animation: true,
              animationDuration: 1200,
              lineWidth: 15.0,
              radius: 170.0,
              percent: batteryPercentage/100,
              center:  Text("$batteryPercentage %",style:Theme.of(context).textTheme!.headlineLarge,),
              progressColor: batteryIndicator,
            )
          ],
        ),
      ],
    ),
  );
}