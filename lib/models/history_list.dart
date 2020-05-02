import 'history.dart';

class HistoryList {
  List<History> historyList;

  HistoryList({this.historyList});

  factory HistoryList.fromJson(List<dynamic> json) {
    return HistoryList(
        historyList: json.map((i) => History.fromJson(i)).toList());
  }
}