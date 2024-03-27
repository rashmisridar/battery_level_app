import 'package:battery_level_app/home/data/model/battery_model.dart';
import 'package:battery_level_app/utils/string_utils.dart';
import 'package:battery_level_app/utils/util.dart';
import 'package:flutter/material.dart';

Widget batteryHistoryWidget(BuildContext context, List<BatteryModel>? batteryModelList, ) {
  return ListView.builder(shrinkWrap: true,
      scrollDirection: Axis.vertical,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      itemCount: batteryModelList!.length,
      itemBuilder: (BuildContext context, int index) {
        return showHistoryWidget(context,batteryModelList[index]);
      });

}

Widget showHistoryWidget(BuildContext context,BatteryModel batteryModel) {
  String dateTimeFormat =Utils().convertTimeMiliSecToDateFormat(batteryModel.timeStamp);
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
    child: Card(
      elevation: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${StringUtils.batteryCategory} : ",style: Theme.of(context).textTheme!.bodyMedium,),
                    Text(batteryModel.batteryCategory ,style: Theme.of(context).textTheme!.labelLarge,),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${StringUtils.batteryPercentage} : ",style: Theme.of(context).textTheme!.bodyMedium,),
                    Text("${batteryModel.batteryPercentage}",style: Theme.of(context).textTheme!.labelLarge,),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${StringUtils.dateTime} : ",style: Theme.of(context).textTheme!.bodyMedium,),
                    Text(dateTimeFormat,style:  Theme.of(context).textTheme!.labelLarge,),
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    ),
  );
}