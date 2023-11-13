class ForecastData {
  String cod;
  int message;
  int cnt;
  List<ForecastItem> list;
  City city;

  ForecastData({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  factory ForecastData.fromJson(Map<String, dynamic> json) => ForecastData(
        cod: json['cod'],
        message: json['message'],
        cnt: json['cnt'],
        list: List<ForecastItem>.from(json['list'].map((x) => ForecastItem.fromJson(x))),
        city: City.fromJson(json['city']),
      );

  Map<String, dynamic> toJson() => {
        'cod': cod,
        'message': message,
        'cnt': cnt,
        'list': List<dynamic>.from(list.map((x) => x.toJson())),
        'city': city.toJson(),
      };
}

class ForecastItem {
  int dt;
  MainWeather main;
  List<Weather> weather;
  Clouds clouds;
  Wind wind;
  int visibility;
  double pop;
  Sys sys;
  String dtTxt;

  ForecastItem({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
  });

  factory ForecastItem.fromJson(Map<String, dynamic> json) => ForecastItem(
        dt: json['dt'],
        main: MainWeather.fromJson(json['main']),
        weather: List<Weather>.from(json['weather'].map((x) => Weather.fromJson(x))),
        clouds: Clouds.fromJson(json['clouds']),
        wind: Wind.fromJson(json['wind']),
        visibility: json['visibility'],
        pop: json['pop'].toDouble(),
        sys: Sys.fromJson(json['sys']),
        dtTxt: json['dt_txt'],
      );

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'main': main.toJson(),
        'weather': List<dynamic>.from(weather.map((x) => x.toJson())),
        'clouds': clouds.toJson(),
        'wind': wind.toJson(),
        'visibility': visibility,
        'pop': pop,
        'sys': sys.toJson(),
        'dt_txt': dtTxt,
      };
}

class MainWeather {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int seaLevel;
  int grndLevel;
  int humidity;
  double tempKf;

  MainWeather({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  factory MainWeather.fromJson(Map<String, dynamic> json) => MainWeather(
        temp: json['temp'].toDouble(),
        feelsLike: json['feels_like'].toDouble(),
        tempMin: json['temp_min'].toDouble(),
        tempMax: json['temp_max'].toDouble(),
        pressure: json['pressure'],
        seaLevel: json['sea_level'],
        grndLevel: json['grnd_level'],
        humidity: json['humidity'],
        tempKf: json['temp_kf'].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'temp': temp,
        'feels_like': feelsLike,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'pressure': pressure,
        'sea_level': seaLevel,
        'grnd_level': grndLevel,
        'humidity': humidity,
        'temp_kf': tempKf,
      };
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json['id'],
        main: json['main'],
        description: json['description'],
        icon: json['icon'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'main': main,
        'description': description,
        'icon': icon,
      };
}

class Clouds {
  int all;

  Clouds({
    required this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json['all'],
      );

  Map<String, dynamic> toJson() => {
        'all': all,
      };
}

class Wind {
  double speed;
  int deg;
  double gust;

  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json['speed'].toDouble(),
        deg: json['deg'],
        gust: json['gust'].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'speed': speed,
        'deg': deg,
        'gust': gust,
      };
}

class Sys {
  String pod;

  Sys({
    required this.pod,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        pod: json['pod'],
      );

  Map<String, dynamic> toJson() => {
        'pod': pod,
      };
}

class City {
  int id;
  String name;
  Coord coord;
  String country;
  int population;
  int timezone;
  int sunrise;
  int sunset;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json['id'],
        name: json['name'],
        coord: Coord.fromJson(json['coord']),
        country: json['country'],
        population: json['population'],
        timezone: json['timezone'],
        sunrise: json['sunrise'],
        sunset: json['sunset'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'coord': coord.toJson(),
        'country': country,
        'population': population,
        'timezone': timezone,
        'sunrise': sunrise,
        'sunset': sunset,
      };
}

class Coord {
  double lat;
  double lon;

  Coord({
    required this.lat,
    required this.lon,
  });

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lat: json['lat'].toDouble(),
        lon: json['lon'].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lon': lon,
      };
}
