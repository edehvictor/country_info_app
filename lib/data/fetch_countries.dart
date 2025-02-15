import 'dart:async';
import 'dart:convert';
import 'package:country_info/model/countries_model.dart';
import 'package:http/http.dart' as http;

Future<List<CountriesModel>> fetchCountries() async {
  // String? token = "2160|XF1uBKfMQwbyKiPYnSGDRBwMYeV9UGPqgrcMUTuA";
  String url = 'https://restcountries.com/v3.1/all';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((datum) => CountriesModel.fromJson(datum)).toList();
    } else {
      throw Exception('Failed to load countries');
    }
  } catch (e) {
    throw Exception('Error bro:$e');
  }
}
