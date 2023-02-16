// To parse this JSON data, do
//
//     final rulesDays = rulesDaysFromJson(jsonString);

// import 'dart:convert';

// RulesDays rulesDaysFromJson(String str) => RulesDays.fromJson(json.decode(str));

// String rulesDaysToJson(RulesDays data) => json.encode(data.toJson());

class Rules {
  Rules({
    this.closedTime,
    this.day,
    this.isClosed,
    this.openTime,
    this.open24Hr,
  });

  String? closedTime;
  String? day;
  bool? isClosed;
  String? openTime;
  bool? open24Hr;

  Rules copyWith({
    String? closedTime,
    String? day,
    bool? isClosed,
    String? openTime,
    bool? open24Hr,
  }) =>
      Rules(
        closedTime: closedTime ?? this.closedTime,
        day: day ?? this.day,
        isClosed: isClosed ?? this.isClosed,
        openTime: openTime ?? this.openTime,
        open24Hr: open24Hr ?? this.open24Hr,
      );

  factory Rules.fromJson(Map<String, dynamic> json) => Rules(
        closedTime: json["closedTime"],
        day: json["day"],
        isClosed: json["isClosed"],
        openTime: json["openTime"],
        open24Hr: json["open24hr"],
      );

  Map<String, dynamic> toJson() => {
        "closedTime": closedTime,
        "day": day,
        "isClosed": isClosed,
        "openTime": openTime,
        "open24hr": open24Hr,
      };
}
