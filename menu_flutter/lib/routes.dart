import 'package:flutter/material.dart';

class Routes {
  static final Router _router = Router();

  static void initRoutes() {
    _router.define("/detail/:id", handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return DetailPage(params["id"]);
    }));
  }

  static void navigateTo(context, String route) {
    _router.navigateTo(context, route);
  }
}
