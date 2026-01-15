import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherappg14/models/forecast_model.dart';
import 'package:weatherappg14/models/weather_model.dart';
import 'package:weatherappg14/services/api_service.dart';
import 'package:weatherappg14/widget/forecast_widget.dart';
import 'package:weatherappg14/widget/search_city_widget.dart';
import 'package:weatherappg14/widget/weather_item.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();
  // WeatherModel? _weatherModel;
  ForecastModel? _forecastModel;

  Future<Position?> getPosition() async {
    bool serviceEnabled;
    LocationPermission locationPermission;

    // Verificamos que el servicio este habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      print("Los servicios de ubicación estan deshabilitados");
      return null;
    }

    // Verificamos los permisos
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        print("Permiso de ubicación denegado");
        return null;
      }
    }
    if (locationPermission == LocationPermission.deniedForever) {
      print("Los permisos de ubicación estan permanentemente denegados");
      return null;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      print(position);
      return position;
    } catch (e) {
      print("Error al obtener ubicación: $e");
      return null;
    }
  }

  Future<void> getWeatherByCity() async {
    final city = _searchController.text.trim();
    _searchController.clear();
    if (city.isEmpty) {
      print("Debe ingresar una ciudad");
      return;
    }
    try {
      ForecastModel? result = await ApiService().getForecastInfoByCity(city);
      if (result != null) {
        setState(() {
          _forecastModel = result;
        });
      }
    } catch (e) {
      print("Error al buscar la ciudad ${e}");
    }
  }

  Future<void> getWeatherFromPosition() async {
    Position? _pos = await getPosition();
    if (_pos == null) {
      print("No se pudo obtner la ubicación");
      return null;
    }
    // _weatherModel = await ApiService().getWeatherInfoByPos(
    //   _pos.latitude,
    //   _pos.longitude,
    // );

    _forecastModel = await ApiService().getForecastInfoByPos(
      _pos.latitude,
      _pos.longitude,
    );
    setState(() {});
  }

  // Future<void> getWeather() async {
  //   _weatherModel = await ApiService().getWeatherInfoByName();
  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();
    getWeatherFromPosition();
    // getWeather();
    // getPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     ApiService().getWeatherInfoByName();
      //   },
      // ),
      backgroundColor: Color(0xff2C2F31),
      appBar: AppBar(
        title: Text("Weather App", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Color(0xff2C2F31),
        actions: [
          IconButton(
            onPressed: () {
              getWeatherFromPosition();
            },
            icon: Icon(Icons.location_on_outlined, color: Colors.white),
          ),
        ],
      ),
      body: _forecastModel == null
          ? Center(child: CircularProgressIndicator())
          : Expanded(
              child: ListView(
                children: [
                  SearchCityWidget(
                    controller: _searchController,
                    function: () {
                      getWeatherByCity();
                    },
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                    padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        colors: [Color(0xff6B9AF8), Color(0xff2E5FEC)],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${_forecastModel!.location.name}, ${_forecastModel!.location.country}",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(height: 32),
                        Image.asset(
                          "assets/icons/heavycloudy.png",
                          height: 100,
                        ),
                        Text(
                          "${_forecastModel!.current.tempC} °",
                          style: TextStyle(fontSize: 100, color: Colors.white),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            WeatherItem(
                              value: _forecastModel!.current.visKm,
                              unit: "km/h",
                              image: "windspeed",
                            ),
                            WeatherItem(
                              value: _forecastModel!.current.humidity
                                  .toDouble(),
                              unit: "%",
                              image: "humidity",
                            ),
                            WeatherItem(
                              value: _forecastModel!.current.cloud.toDouble(),
                              unit: "%",
                              image: "cloud",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Text(
                      "Forecast",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        _forecastModel!.forecast.forecastday[0].hour.length,
                        (index) => ForecastWidget(
                          hour: _forecastModel!
                              .forecast
                              .forecastday[0]
                              .hour[index]
                              .time
                              .toString()
                              .substring(11, 16),
                          temp: _forecastModel!
                              .forecast
                              .forecastday[0]
                              .hour[index]
                              .tempC
                              .toString(),
                          isDay: _forecastModel!
                              .forecast
                              .forecastday[0]
                              .hour[index]
                              .isDay,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
