/*
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../model/airport.dart';

class AirportsController extends GetxController {
  List<Airport> airports = [];

  RxList<Airport> searchResults = <Airport>[].obs;


  @override
  void onInit() {
    super.onInit();
    loadAirports();
  }

  loadAirports() async {
    return Future.delayed(const Duration(seconds: 1), () async {
      final String response =
          await rootBundle.loadString('assets/data/airports.json');
      var airportsList = json.decode(response);
      for (Map<String, dynamic> airportData in airportsList) {
        airports.add(Airport.fromJson(airportData));
      }
    });
  }

  void clearSearch() {
    searchResults.clear();
  }

  searchAirports(String? arg) async {
    if (null != arg && arg.length > 1) {
      arg = arg.toLowerCase();
      List<Airport> airportsList = [];
      for (var airport in airports) {
        if (airport.name.toLowerCase().contains(arg) ||
            airport.cityCode.toLowerCase().contains(arg)) {
          airportsList.add(airport);
        }
      }
      searchResults.value = airportsList;
    }
  }
}
*/
