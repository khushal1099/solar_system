import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:solar_system/main.dart';
import 'package:solar_system/model/planets_model.dart';


class PlanetProvider extends ChangeNotifier {
  List<Planets> planets = [];
  List<Planets> favoriteplanet = [];
  String Favjson = "";

  Future<void> getData() async {
    var filedata = await rootBundle.loadString("lib/jsons/planets_json.json");
    jsonDecode(filedata);
    planets = planetsFromJson(filedata);
    notifyListeners();
  }

  bool isFavorite(Planets obj) {
    return favoriteplanet.any((element) => element.name == obj.name);
  }

  void addFavorite(Planets planet) {
    if (isFavorite(planet)) {
      print("ALREADY");
    } else {
      favoriteplanet.add(planet);
      notifyListeners();
      print("LEGNTH ==>  ${favoriteplanet.length}");
    }
  }

  void removeFavorite(int index) {
    favoriteplanet.removeAt(index);
    notifyListeners();
  }

  void loadData() {
    String? favorite = prefs.getString("planets");
    if (favorite != null) {
      List<dynamic> decodeList = jsonDecode(favorite);
      favoriteplanet = decodeList.map((e) => Planets.fromJson(e)).toList();
      print(favoriteplanet.length);
    }
    notifyListeners();
  }

  void saveData() {
    Favjson = jsonEncode(favoriteplanet.map((e) => e.toJson()).toList());
    prefs.setString("planets", Favjson);
    notifyListeners();
  }
}
