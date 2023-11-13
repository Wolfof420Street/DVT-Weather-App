import 'package:dvt_weather_app/app/model/forecast_data.dart';
import 'package:dvt_weather_app/app/model/weather_data.dart';
import 'package:dvt_weather_app/app/network/weather_service.dart';
import 'package:dvt_weather_app/app/utils/app_colors.dart';
import 'package:dvt_weather_app/app/utils/icon_paths.dart';
import 'package:dvt_weather_app/app/utils/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class WeatherViewModel with ChangeNotifier {
  final WeatherService _weatherService;
  WeatherData? _weatherData;
  ForecastData? _forecastData;
 
  double _lat = 0.0;
  double _lon = 0.0;
  String _imagePath = '';
  String _iconPath = '';
  Color? _backgroundColor = Colors.white;

  WeatherViewModel(this._weatherService);

  WeatherData? get weatherData => _weatherData;
  ForecastData? get forecastData => _forecastData;
  double get lat => _lat;
  double get lon => _lon;
  String get imagePath => _imagePath;
  String get iconPath => _iconPath;
  Color? get backgroundColor => _backgroundColor;

  Future<void> getWeatherData() async {
    try {
    

      _weatherData = await _weatherService.fetchWeather(_lat, _lon);

      debugPrint('Weather data: ${_weatherData!.toJson()}');

    
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getImagePath(String weatherCondition) async {
    try {
      

      switch (weatherCondition) {
        case 'Rain':
          _imagePath = ImagePaths().forestRainy;
          _iconPath = IconPaths().rainIcon;
          break;
        case 'Clouds':
          _imagePath = ImagePaths().forestCloudy;
          _iconPath = IconPaths().partlySunnyIcon;
          break;
        default:
          _imagePath = ImagePaths().forestSunny;
          _iconPath = IconPaths().sunnyIcon;
          break;
      }
     
      return _imagePath;
    } catch (e) {
     
      rethrow;
    }
  }

  Future<void> getForecastData() async {
    try {
     

      _forecastData = await _weatherService.getForecast(_lat, _lon);

      debugPrint('Forecast data: ${_forecastData!.toJson()}');

     
      notifyListeners();
    } catch (e) {
     
      rethrow;
    }
  }

  Future<void> getLocationData() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    _lat = locationData.latitude!;
    _lon = locationData.longitude!;

    await getWeatherData();
    await getForecastData();

    notifyListeners();
  }

  Future<Color> getBackgroundColor(String weatherCondition) async {
    try {
      
      switch (weatherCondition) {
        case 'Rain':
          _backgroundColor = AppColors.rainy;
          break;
        case 'Clouds':
          _backgroundColor = AppColors.cloudy;
          break;
        default:
          _backgroundColor = AppColors.sunny;
          break;
      }
    
      return _backgroundColor!;
    } catch (e) {
     
      rethrow;
    }
  }

  Future<String> getIconPath(String weatherCondition) async {
    try {

      switch (weatherCondition) {
        case 'Rain':
          _iconPath = IconPaths().rainIcon;
          break;
        case 'Clouds':
          _iconPath = IconPaths().partlySunnyIcon;
          break;
        default:
          _iconPath = IconPaths().sunnyIcon;
          break;
      }
      
      return _iconPath;
    } catch (e) {
    
      rethrow;
    }
  }
}
