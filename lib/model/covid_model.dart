import 'dart:convert';

import 'package:flutter/foundation.dart';

class CovidSummaryData {
  final int recovered;
  final int hospitalized;
  final int deaths;
  final String date;

  CovidSummaryData({
    this.recovered,
    this.hospitalized,
    this.deaths,
    this.date,
  });

  CovidSummaryData copyWith({
    int recovered,
    int hospitalized,
    int deaths,
    String date,
  }) {
    return CovidSummaryData(
      recovered: recovered ?? this.recovered,
      hospitalized: hospitalized ?? this.hospitalized,
      deaths: deaths ?? this.deaths,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Recovered': recovered,
      'Hospitalized': hospitalized,
      'Deaths': deaths,
      'Date': date,
    };
  }

  factory CovidSummaryData.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return CovidSummaryData(
      recovered: map['Recovered'],
      hospitalized: map['Hospitalized'],
      deaths: map['Deaths'],
      date: map['Date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CovidSummaryData.fromJson(String source) => CovidSummaryData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CovidSummaryData(recovered: $recovered, hospitalized: $hospitalized, deaths: $deaths, date: $date)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is CovidSummaryData &&
      o.recovered == recovered &&
      o.hospitalized == hospitalized &&
      o.deaths == deaths &&
      o.date == date;
  }

  @override
  int get hashCode {
    return recovered.hashCode ^
      hospitalized.hashCode ^
      deaths.hashCode ^
      date.hashCode;
  }
}


class CovidCaseSumData {
  final Map<String, int> province;
  final Map<String, int> gender;

  CovidCaseSumData({
    this.province,
    this.gender,
  });

  CovidCaseSumData copyWith({
    Map<String, int> province,
    Map<String, int> gender,
  }) {
    return CovidCaseSumData(
      province: province ?? this.province,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Province': province,
      'Gender': gender,
    };
  }

  factory CovidCaseSumData.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return CovidCaseSumData(
      province: Map<String, int>.from(map['Province']),
      gender: Map<String, int>.from(map['Gender']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CovidCaseSumData.fromJson(String source) => CovidCaseSumData.fromMap(json.decode(source));

  @override
  String toString() => 'CovidCaseSumData(province: $province, gender: $gender)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is CovidCaseSumData &&
      mapEquals(o.province, province) &&
      mapEquals(o.gender, gender);
  }

  @override
  int get hashCode => province.hashCode ^ gender.hashCode;
}
