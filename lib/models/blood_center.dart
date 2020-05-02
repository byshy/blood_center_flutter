class BloodCenter {
  double long;
  double lat;
  String name;

  BloodCenter({this.name, this.long, this.lat});

  factory BloodCenter.fromJson(Map<String, dynamic> json) => BloodCenter(
    long: json["longitude"],
    lat: json["latitude"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "longitude": long,
    "latitude": lat,
    "name": name,
  };
}