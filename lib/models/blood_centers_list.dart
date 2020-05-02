import 'blood_center.dart';

class BloodCentersList {
  List<BloodCenter> centersList;

  BloodCentersList({this.centersList});

  factory BloodCentersList.fromJson(List<dynamic> json) {
    return BloodCentersList(
        centersList: json.map((i) => BloodCenter.fromJson(i)).toList());
  }
}