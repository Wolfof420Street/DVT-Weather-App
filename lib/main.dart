import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dvt_weather_app/app/home/presentation/screens/home_screen.dart';
import 'package:dvt_weather_app/app/home/view_model/weather_view_model.dart';
import 'package:dvt_weather_app/app/network/weather_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    if (kReleaseMode) {
      
    } else {
      
      FlutterError.dumpErrorToConsole(details);
    }
  };

  runZonedGuarded(() {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => WeatherViewModel(WeatherService(Dio()))),
        ],
        child: const MyApp(),
      ),
    );
  }, (error, stack) {
    
  });
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DVT Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(
        key: Key('home_screen'),
      ),
    );
  }
}
