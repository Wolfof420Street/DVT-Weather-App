import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:dvt_weather_app/app/home/presentation/widgets/image_container.dart';
import 'package:dvt_weather_app/app/home/view_model/weather_view_model.dart';
import 'package:dvt_weather_app/app/model/forecast_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _formatDateTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('EEEE').format(date);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherViewModel>().getLocationData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WeatherViewModel>(
        builder: (context, weatherViewModel, child) {
          if (weatherViewModel.weatherData == null ||
              weatherViewModel.forecastData == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final weatherData = weatherViewModel.weatherData!;
          final forecastData = weatherViewModel.forecastData!;

          return Column(
            children: [
              Expanded(
                flex: 1,
                child: FutureBuilder(
                    future: weatherViewModel
                        .getImagePath('${weatherData.weather?[0].main}'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Show loading indicator while waiting for the image path
                        return const CircularProgressIndicator();
                      }

                      if (snapshot.hasError) {
                        // Handle error state
                        return Text('Error: ${snapshot.error}');
                      }

                      return ImageContainer(
                        imagePath: snapshot.data ?? '',
                        temprature:
                            '${weatherData.main?.temp?.toInt().round()}',
                        weatherCondition: '${weatherData.weather?[0].main}',
                      );
                    }),
              ),
              Expanded(
                flex: 1,
                child: FutureBuilder<Color>(
                    future: weatherViewModel
                        .getBackgroundColor('${weatherData.weather?[0].main}'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Show loading indicator while waiting for the background color
                        return const CircularProgressIndicator();
                      }

                      if (snapshot.hasError) {
                        // Handle error state
                        return Text('Error: ${snapshot.error}');
                      }

                      return Container(
                        color: snapshot.data ?? Colors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${weatherData.main?.tempMin}°\nmin',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12)),
                                  const SizedBox(width: 10),
                                  Text('${weatherData.main?.temp}°\nCurrent',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12)),
                                  const SizedBox(width: 10),
                                  Text('${weatherData.main?.tempMax}°\nmax',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12)),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: forecastData.list.length,
                                itemBuilder: (context, index) {
                                  ForecastItem forecast =
                                      forecastData.list[index];
                                  // Convert timestamp to a formatted date
                                  String day = _formatDateTime(forecast.dt);
                                  return FutureBuilder<String>(
                                    future: weatherViewModel
                                        .getIconPath(forecast.weather[0].main),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        // Show loading indicator while waiting for the icon path
                                        return const CircularProgressIndicator();
                                      }

                                      if (snapshot.hasError) {
                                        // Handle error state
                                        return Text('Error: ${snapshot.error}');
                                      }

                                      if (!snapshot.hasData ||
                                          snapshot.data!.isEmpty) {
                                        // Handle case where no icon is found
                                        return const Icon(Icons.error);
                                      }

                                      // Once the icon path is available, display the icon
                                      return SizedBox(
                                        height: 50,
                                        child: ListTile(
                                          leading: Text(
                                            day,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                          title: Image.asset(
                                            snapshot.data!,
                                            height: 40,
                                            width: 40,
                                          ),
                                          trailing: Text(
                                            '${forecast.main.temp}°',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          );
        },
      ),
    );
  }
}
