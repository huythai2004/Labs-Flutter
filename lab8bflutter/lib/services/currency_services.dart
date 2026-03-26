import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lab8bflutter/model/exchange_rate.dart';

class CurrencyService {

  Future<ExchangeRate> fetchRates() async {

    final response = await http.get(
      Uri.parse("https://open.er-api.com/v6/latest/USD"),
    );

    if (response.statusCode == 200) {

      final Map<String, dynamic> data =
      jsonDecode(response.body);

      return ExchangeRate.fromJson(data);

    }

    throw Exception("Failed to load exchange rates");
  }
}