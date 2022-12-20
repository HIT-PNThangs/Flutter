import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'alerts_controller.dart';

class AlertsPage extends GetView<AlertsController> {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Alerts Page",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
