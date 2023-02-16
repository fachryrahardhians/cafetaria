// To parse this JSON data, do
//
//     final rulesDays = rulesDaysFromJson(jsonString);

// import 'dart:convert';

// RulesDays rulesDaysFromJson(String str) => RulesDays.fromJson(json.decode(str));

// String rulesDaysToJson(RulesDays data) => json.encode(data.toJson());

class RulesDays {
  RulesDays({
    this.closedTime,
    this.day,
    this.isClosed,
    this.openTime,
    this.open24Hr,
    this.date,
  });

  String? closedTime;
  String? day;
  bool? isClosed;
  String? openTime;
  bool? open24Hr;
  DateTime? date;

  RulesDays copyWith({
    String? closedTime,
    String? day,
    bool? isClosed,
    String? openTime,
    bool? open24Hr,
    DateTime? date,
  }) =>
      RulesDays(
        closedTime: closedTime ?? this.closedTime,
        day: day ?? this.day,
        isClosed: isClosed ?? this.isClosed,
        openTime: openTime ?? this.openTime,
        open24Hr: open24Hr ?? this.open24Hr,
        date: date ?? this.date,
      );

  factory RulesDays.fromJson(Map<String, dynamic> json) => RulesDays(
        closedTime: json["closedTime"],
        day: json["day"],
        isClosed: json["isClosed"],
        openTime: json["openTime"],
        open24Hr: json["open24hr"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "closedTime": closedTime,
        "day": day,
        "isClosed": isClosed,
        "openTime": openTime,
        "open24hr": open24Hr,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
      };
}
