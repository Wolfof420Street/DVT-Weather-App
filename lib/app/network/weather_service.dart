import 'package:dio/dio.dart';
import 'package:dvt_weather_app/app/model/forecast_data.dart';
import 'package:dvt_weather_app/app/model/weather_data.dart';
import 'package:dvt_weather_app/app/network/loggng_interceptor.dart';
import 'package:dvt_weather_app/app/utils/configs.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class WeatherService {
  final Dio _dio;

  WeatherService(this._dio);

  Future<WeatherData> fetchWeather(double lat, double lon) async {
    
 

  final Map<String, dynamic> queryParams = {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'appid': apiKey,
      'units': 'metric',
    };

    try {
      // Making the GET request
      final response = await _dio.get(
        '${AppConstants().baseUrl}weather',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        
        debugPrint('WeatherService: ${response.data}');

        return WeatherData.fromJson(response.data);

      } else {
        
        debugPrint('WeatherService Error: ${response.data}');
        throw Exception('Failed to load weather data');
      }

    }  catch (e) {
      
      debugPrint('DioError Weather: $e');
      rethrow; 
    }
  }

  Future<ForecastData> getForecast(double lat, double lon) async {

 

    final Map<String, dynamic> queryParams = {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'appid': apiKey,
      'units': 'metric'
    };

    try {
      // Making the GET request
      final response = await _dio.get(
        '${AppConstants().baseUrl}forecast',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {

        debugPrint('Forecast: ${response.data}');
       
        return ForecastData.fromJson(response.data);

      } else {

         debugPrint('Forecast Error: ${response.data}');

       
        throw Exception('Failed to load weather data');
      }

    } catch (e) {
      
      debugPrint('DioError Forecast: $e');
      rethrow; 
    }
  }

}
