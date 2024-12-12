// To parse this JSON data, do
//
//     final usData = usDataFromJson(jsonString);

import 'dart:convert';

UsData usDataFromJson(String str) => UsData.fromJson(json.decode(str));

String usDataToJson(UsData data) => json.encode(data.toJson());

class UsData {
  List<Datum>? data;
  List<Source>? source;

  UsData({
    this.data,
    this.source,
  });

  factory UsData.fromJson(Map<String, dynamic> json) => UsData(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    source: json["source"] == null ? [] : List<Source>.from(json["source"]!.map((x) => Source.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "source": source == null ? [] : List<dynamic>.from(source!.map((x) => x.toJson())),
  };
}

class Datum {
  IdNation? idNation;
  Nation? nation;
  int? idYear;
  String? year;
  int? population;
  SlugNation? slugNation;

  Datum({
    this.idNation,
    this.nation,
    this.idYear,
    this.year,
    this.population,
    this.slugNation,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idNation: idNationValues.map[json["ID Nation"]]!,
    nation: nationValues.map[json["Nation"]]!,
    idYear: json["ID Year"],
    year: json["Year"],
    population: json["Population"],
    slugNation: slugNationValues.map[json["Slug Nation"]]!,
  );

  Map<String, dynamic> toJson() => {
    "ID Nation": idNationValues.reverse[idNation],
    "Nation": nationValues.reverse[nation],
    "ID Year": idYear,
    "Year": year,
    "Population": population,
    "Slug Nation": slugNationValues.reverse[slugNation],
  };
}

enum IdNation {
  THE_01000_US
}

final idNationValues = EnumValues({
  "01000US": IdNation.THE_01000_US
});

enum Nation {
  UNITED_STATES
}

final nationValues = EnumValues({
  "United States": Nation.UNITED_STATES
});

enum SlugNation {
  UNITED_STATES
}

final slugNationValues = EnumValues({
  "united-states": SlugNation.UNITED_STATES
});

class Source {
  List<String>? measures;
  Annotations? annotations;
  String? name;
  List<dynamic>? substitutions;

  Source({
    this.measures,
    this.annotations,
    this.name,
    this.substitutions,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    measures: json["measures"] == null ? [] : List<String>.from(json["measures"]!.map((x) => x)),
    annotations: json["annotations"] == null ? null : Annotations.fromJson(json["annotations"]),
    name: json["name"],
    substitutions: json["substitutions"] == null ? [] : List<dynamic>.from(json["substitutions"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "measures": measures == null ? [] : List<dynamic>.from(measures!.map((x) => x)),
    "annotations": annotations?.toJson(),
    "name": name,
    "substitutions": substitutions == null ? [] : List<dynamic>.from(substitutions!.map((x) => x)),
  };
}

class Annotations {
  String? sourceName;
  String? sourceDescription;
  String? datasetName;
  String? datasetLink;
  String? tableId;
  String? topic;
  String? subtopic;

  Annotations({
    this.sourceName,
    this.sourceDescription,
    this.datasetName,
    this.datasetLink,
    this.tableId,
    this.topic,
    this.subtopic,
  });

  factory Annotations.fromJson(Map<String, dynamic> json) => Annotations(
    sourceName: json["source_name"],
    sourceDescription: json["source_description"],
    datasetName: json["dataset_name"],
    datasetLink: json["dataset_link"],
    tableId: json["table_id"],
    topic: json["topic"],
    subtopic: json["subtopic"],
  );

  Map<String, dynamic> toJson() => {
    "source_name": sourceName,
    "source_description": sourceDescription,
    "dataset_name": datasetName,
    "dataset_link": datasetLink,
    "table_id": tableId,
    "topic": topic,
    "subtopic": subtopic,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
