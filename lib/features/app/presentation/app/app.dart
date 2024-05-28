import 'package:flutter/material.dart';
import 'package:weather_test/features/weather/presentation/current_temperature/current_temperature_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This global key is needed for [MaterialApp]
  // to work properly when Widgets Inspector is enabled.
  static final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) => MaterialApp(
        darkTheme: ThemeData.dark(),
        theme: ThemeData.light(),
        home: const CurrentTemperatureScreen(),
        builder: (context, child) => MediaQuery.withClampedTextScaling(
          key: _globalKey,
          minScaleFactor: 1.0,
          maxScaleFactor: 2.0,
          child: child!,
        ),
      );
}
