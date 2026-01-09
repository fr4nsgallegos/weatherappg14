import 'package:flutter/material.dart';
import 'package:weatherappg14/widget/search_city_widget.dart';

class HomePage extends StatelessWidget {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ],
      ),
    );
  }
}
