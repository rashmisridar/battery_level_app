import 'package:battery_level_app/home/ui/screens/battery_history_screen.dart';
import 'package:battery_level_app/home/ui/screens/home_screen.dart';
import 'package:battery_level_app/utils/router/router_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
final GlobalKey<NavigatorState> parentKey = GlobalKey<NavigatorState>();

class MyRouter{
  late final router = GoRouter(
  navigatorKey: parentKey,
  initialLocation: RouteName.homeScreen,
  redirect: (BuildContext context, GoRouterState state) async {
  }, routes: [
    ///Route of home screen
    GoRoute(
      name: RouteName.homeScreen,
      path: RouteName.homeScreen,
      builder: (context, state) {
        return const HomeScreen();
      },
    ),
    /// Route of History screen
    GoRoute(
      name: RouteName.batteryHistoryScreen,
      path: RouteName.batteryHistoryScreen,
      builder: (context, state) {
        return const BatteryHistoryScreen();
      },
    ),
  ]);
}