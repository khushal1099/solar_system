// To parse this JSON data, do
//
//     final planets = planetsFromJson(jsonString);

import 'dart:convert';

List<Planets> planetsFromJson(String str) => List<Planets>.from(json.decode(str).map((x) => Planets.fromJson(x)));

String planetsToJson(List<Planets> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Planets {
  String? position;
  String? name;
  String? type;
  String? radius;
  String? orbitalPeriod;
  String? gravity;
  String? velocity;
  String? distance;
  String? description;
  String? image;
  bool? isFavourite;

  Planets({
    this.position,
    this.name,
    this.type,
    this.radius,
    this.orbitalPeriod,
    this.gravity,
    this.velocity,
    this.distance,
    this.description,
    this.image,
    this.isFavourite = false
  });

  factory Planets.fromJson(Map<String, dynamic> json) => Planets(
    position: json["position"],
    name: json["name"],
    type: json["type"],
    radius: json["radius"],
    orbitalPeriod: json["orbital_period"],
    gravity: json["gravity"],
    velocity: json["velocity"],
    distance: json["distance"],
    description: json["description"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "position": position,
    "name": name,
    "type": type,
    "radius": radius,
    "orbital_period": orbitalPeriod,
    "gravity": gravity,
    "velocity": velocity,
    "distance": distance,
    "description": description,
    "image": image,
  };
}
