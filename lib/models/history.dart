class History {
  DateTime date;
  String bloodCenterId;

  History({
    this.date,
    this.bloodCenterId,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        date: DateTime.parse(json["date"]),
        bloodCenterId: json["blood_center_id"],
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "blood_center_id": bloodCenterId,
      };
}
