import 'package:flutter/material.dart';
import '../pages/01_Index/IndexPageApp.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
    '/Main': (BuildContext context) => const IndexPage(),
  };
}
