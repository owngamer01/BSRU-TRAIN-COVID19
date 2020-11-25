import 'dart:convert';
import 'dart:io';
import 'package:covid19/config/config.dart';
import 'package:covid19/model/covid_model.dart';
import 'package:http/http.dart' as http;

class CovidHttp {
  Future<CovidSummaryData> getCovidSummary() async {
    final response = await http.get('$baseURL/today');
    if (response.statusCode == HttpStatus.ok) {
      return CovidSummaryData.fromJson(response.body);
    }
    return null;
  }

  Future<List<CovidSummaryData>> getCovidHistory() async {
    // await Future.delayed(Duration(seconds: 1));
    final response = await http.get('$baseURL/timeline');
    if (response.statusCode == HttpStatus.ok) {
      return (jsonDecode(response.body)['Data'] as List<dynamic>)
        .map((item) => CovidSummaryData.fromMap(item))
        .toList().reversed
        .toList();
    }
    return [];
  }

  Future<CovidCaseSumData> getProvinceCovid() async {
    // await Future.delayed(Duration(seconds: 1));
    final response = await http.get('$baseURL/cases/sum');
    if (response.statusCode == HttpStatus.ok) {
      return CovidCaseSumData.fromJson(response.body);
    }
    return null;
  }
}