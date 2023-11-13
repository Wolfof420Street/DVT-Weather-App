import 'package:dio/dio.dart';
import 'package:dvt_weather_app/app/model/forecast_data.dart';
import 'package:dvt_weather_app/app/model/weather_data.dart';
import 'package:dvt_weather_app/app/network/weather_service.dart';
import 'package:dvt_weather_app/app/utils/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'service_tests.mocks.dart';

@GenerateMocks([Dio])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Weather Service Tests", () {
    late MockDio mockDio;
    late WeatherService weatherService;
    const double testLat = 35.0;
    const double testLon = 139.0;

    setUp(() {
      mockDio = MockDio();
      weatherService = WeatherService(mockDio);
    });

    test("fetchWeather() should return WeatherData on Successful response",
        () async {
      final response = Response(
          statusCode: 200,
          data: {
            "coord": {"lon": 33, "lat": 6},
            "weather": [
              {
                "id": 803,
                "main": "Clouds",
                "description": "broken clouds",
                "icon": "04n"
              }
            ],
            "base": "stations",
            "main": {
              "temp": 30.65,
              "feels_like": 31.52,
              "temp_min": 30.65,
              "temp_max": 30.65,
              "pressure": 1008,
              "humidity": 47,
              "sea_level": 1008,
              "grnd_level": 960
            },
            "visibility": 10000,
            "wind": {"speed": 3.51, "deg": 62, "gust": 8.02},
            "clouds": {"all": 57},
            "dt": 1699803891,
            "sys": {
              "country": "SS",
              "sunrise": 1699760177,
              "sunset": 1699802881
            },
            "timezone": 7200,
            "id": 369195,
            "name": "Nialeir",
            "cod": 200
          },
          requestOptions:
              RequestOptions(baseUrl: AppConstants().baseUrl,
               path: 'weather'));

      when(mockDio.get('${AppConstants().baseUrl}weather',
              options: anyNamed('options'),
              data: anyNamed('data'),
              queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => response);

      final result = await weatherService.fetchWeather(testLat, testLon);

      expect(result, isA<WeatherData>());
    });

    test('fetchWeather throws exception on error response', () async {
      // Arrange
      when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
          .thenThrow(DioException(
        requestOptions:
            RequestOptions(baseUrl: AppConstants().baseUrl, path: 'weather'),
        error: 'Error',
      ));

      // Act & Assert
      expect(() async => await weatherService.fetchWeather(testLat, testLon),
          throwsException);
    });

    test('fetch Forecast should return ForecastData on Successful response',
        () async {
      final response = Response(
          statusCode: 200,
          data: {
            "cod": "200",
            "message": 0,
            "cnt": 40,
            "list": [
              {
                "dt": 1647345600,
                "main": {
                  "temp": 287.39,
                  "feels_like": 286.38,
                  "temp_min": 286.69,
                  "temp_max": 287.39,
                  "pressure": 1021,
                  "sea_level": 1021,
                  "grnd_level": 1018,
                  "humidity": 58,
                  "temp_kf": 0.7
                },
                "weather": [
                  {
                    "id": 803,
                    "main": "Clouds",
                    "description": "broken clouds",
                    "icon": "04d"
                  }
                ],
                "clouds": {"all": 71},
                "wind": {"speed": 3.08, "deg": 128, "gust": 4.3},
                "visibility": 10000,
                "pop": 0,
                "sys": {"pod": "d"},
                "dt_txt": "2022-03-15 12:00:00"
              },
              {
                "dt": 1647356400,
                "main": {
                  "temp": 287.09,
                  "feels_like": 286.13,
                  "temp_min": 286.5,
                  "temp_max": 287.09,
                  "pressure": 1021,
                  "sea_level": 1021,
                  "grnd_level": 1016,
                  "humidity": 61,
                  "temp_kf": 0.59
                },
                "weather": [
                  {
                    "id": 803,
                    "main": "Clouds",
                    "description": "broken clouds",
                    "icon": "04d"
                  }
                ],
                "clouds": {"all": 81},
                "wind": {"speed": 3.28, "deg": 168, "gust": 3.96},
                "visibility": 10000,
                "pop": 0,
                "sys": {"pod": "d"},
                "dt_txt": "2022-03-15 15:00:00"
              },
              {
                "dt": 1647367200,
                "main": {
                  "temp": 285.44,
                  "feels_like": 284.6,
                  "temp_min": 284.47,
                  "temp_max": 285.44,
                  "pressure": 1020,
                  "sea_level": 1020,
                  "grnd_level": 1016,
                  "humidity": 72,
                  "temp_kf": 0.97
                },
                "weather": [
                  {
                    "id": 804,
                    "main": "Clouds",
                    "description": "overcast clouds",
                    "icon": "04d"
                  }
                ],
                "clouds": {"all": 90},
                "wind": {"speed": 2.7, "deg": 183, "gust": 5.59},
                "visibility": 10000,
                "pop": 0,
                "sys": {"pod": "d"},
                "dt_txt": "2022-03-15 18:00:00"
              },
              {
                "dt": 1647766800,
                "main": {
                  "temp": 282.42,
                  "feels_like": 280,
                  "temp_min": 282.42,
                  "temp_max": 282.42,
                  "pressure": 1036,
                  "sea_level": 1036,
                  "grnd_level": 1033,
                  "humidity": 60,
                  "temp_kf": 0
                },
                "weather": [
                  {
                    "id": 802,
                    "main": "Clouds",
                    "description": "scattered clouds",
                    "icon": "03d"
                  }
                ],
                "clouds": {"all": 39},
                "wind": {"speed": 4.58, "deg": 83, "gust": 8.45},
                "visibility": 10000,
                "pop": 0,
                "sys": {"pod": "d"},
                "dt_txt": "2022-03-20 09:00:00"
              }
            ],
            "city": {
              "id": 2643743,
              "name": "London",
              "coord": {"lat": 51.5085, "lon": -0.1257},
              "country": "GB",
              "population": 1000000,
              "timezone": 0,
              "sunrise": 1647324902,
              "sunset": 1647367441
            }
          },
          requestOptions: RequestOptions(
            baseUrl: AppConstants().baseUrl,
            path: 'forecast',
          ));

      when(mockDio.get('${AppConstants().baseUrl}forecast',
              queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => response);

      final result = await weatherService.getForecast(testLat, testLon);

      expect(result, isA<ForecastData>());
    });

    test('getForecast throws exception on error response', () async {
      // Arrange
      when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
          .thenThrow(DioException(
        requestOptions:
            RequestOptions(baseUrl: AppConstants().baseUrl, path: 'forecast'),
        error: 'Error',
      ));

      // Act & Assert
      expect(() async => await weatherService.getForecast(testLat, testLon),
          throwsException);
    });
  });
}
