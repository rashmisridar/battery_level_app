import 'package:battery_level_app/utils/router/router_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyNavigator {

  static goToHomeScreen(BuildContext context) {
    context.go(RouteName.homeScreen,);
  }

  static  goToBatteryHistory(BuildContext context) {
    context.push(RouteName.batteryHistoryScreen,);
  }
}