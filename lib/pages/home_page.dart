import 'package:flutter/material.dart';
import 'package:weatherappg14/services/api_service.dart';
import 'package:weatherappg14/widget/search_city_widget.dart';
import 'package:weatherappg14/widget/weather_item.dart';

class HomePage extends StatelessWidget {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ApiService().getWeatherInfoByName();
        },
      ),
      backgroundColor: Color(0xff2C2F31),
      appBar: AppBar(
        title: Text("Weather App", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Color(0xff2C2F31),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.location_on_outlined, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          SearchCityWidget(controller: _searchController, function: () {}),
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
                  "lima, Perú",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 32),
                Image.asset("assets/icons/heavycloudy.png", height: 100),
                Text(
                  "23.9 °",
                  style: TextStyle(fontSize: 100, color: Colors.white),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WeatherItem(value: 18, unit: "km/h", image: "windspeed"),
                    WeatherItem(value: 76, unit: "%", image: "humidity"),
                    WeatherItem(value: 58, unit: "%", image: "cloud"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
