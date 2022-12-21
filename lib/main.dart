import 'package:ddstudy_ui/ui/navigation/global_navigator.dart';
import 'package:ddstudy_ui/ui/widgets/roots/loader.dart';
import 'package:flutter/material.dart';

import 'data/services/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: GlobalNavigator.key,
      onGenerateRoute: (settings) =>
          GlobalNavigator.onGeneratedRoutes(settings, context),
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: LoaderWidget.create(),
    );
  }
}
