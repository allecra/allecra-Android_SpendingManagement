import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class APIService {
  // baseUrl = "https://api.exchangerate.host/latest";
  // https://exchangerate.host/#/

  static Map<String, dynamic> parseExchangeRate(String responseBody) {
    var data = json.decode(responseBody) as Map<String, dynamic>;
    return data["rates"];
  }

  static Future<Map<String, dynamic>> getExchangeRate() async {
    try {
      var url = Uri.https('api.exchangerate.host', '/latest', {'q': '{https}'});
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return compute(parseExchangeRate, response.body);
      } else {
        throw Exception('Failed to load json data');
      }
    } catch (_) {}
    return {};
  }

  // https://gist.githubusercontent.com/allecra/abad9b167b51ff3291a18e3f3708b193/raw/fe1cd9f33ce5efda0678704917219c1da63560bf/countries.json

  static Future<List<Map<String, dynamic>>> parseCountry(
      String responseBody) async {
    var data = json.decode(responseBody) as Map<String, dynamic>;
    var listSymbol = await getSymbolCurrency();
    List<Map<String, dynamic>> list =
        (data["countries"]["country"] as List<dynamic>).map((e) {
      Map<String, dynamic> item = {};
      var symbol = listSymbol
          .where((element) => element["abbreviation"] == e["currencyCode"])
          .toList();
      item["countryName"] = e["countryName"];
      item["currencyCode"] = e["currencyCode"];
      item["symbol"] = symbol.isNotEmpty ? symbol[0]["symbol"] : "";
      if (item["symbol"] == null) item["symbol"] = "";
      return item;
    }).toList();
    return list;
  }

  static Future<List<Map<String, dynamic>>> getCountry() async {
    try {
      var url = Uri.https(
        'gist.githubusercontent.com',
        '/allecra/abad9b167b51ff3291a18e3f3708b193/raw/fe1cd9f33ce5efda0678704917219c1da63560bf/countries.json',
        {'q': '{https}'},
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return compute(parseCountry, response.body);
      } else {
        throw Exception('Failed to load json data');
      }
    } catch (_) {}
    return [];
  }

  // https://gist.githubusercontent.com/allecra/abad9b167b51ff3291a18e3f3708b193/raw/fe1cd9f33ce5efda0678704917219c1da63560bf/countries.json
  static List<Map<String, dynamic>> parseSymbolCurrency(String responseBody) {
    var data = json.decode(responseBody) as List<dynamic>;
    List<Map<String, dynamic>> list =
        data.map((e) => e as Map<String, dynamic>).toList();
    return list;
  }

  static Future<List<Map<String, dynamic>>> getSymbolCurrency() async {
    try {
      var url = Uri.https(
        'gist.githubusercontent.com',
        '/allecra/abad9b167b51ff3291a18e3f3708b193/raw/fe1cd9f33ce5efda0678704917219c1da63560bf/countries.json',
        {'q': '{https}'},
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return compute(parseSymbolCurrency, response.body);
      } else {
        throw Exception('Failed to load json data');
      }
    } catch (_) {}
    return [];
  }
}
