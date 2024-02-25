import 'package:battery_level_app/utils/router/my_router.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils{
  deviceHeight()
  {
    double height = MediaQuery.of(parentKey.currentContext!).size.height;
    return height;
  }

  String convertTimeMiliSecToDateFormat(int timeStamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    String formattedDateTime = DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
    print(formattedDateTime);
    return formattedDateTime;
  }
}