import 'package:country_info/model/countries_model.dart';
import 'package:country_info/widgets/countries_item.dart';
import 'package:flutter/material.dart';

class CountriesList extends StatelessWidget {
  const CountriesList({super.key, required this.countries});

  final List<CountriesModel> countries;

  @override
  Widget build(BuildContext context) {
    Map<String, List<CountriesModel>> groupedCountries = {};

    for (var country in countries) {
      String firstLetter = country.commonName[0]
          .toUpperCase(); //we're searching for the first intial letter
      if (!groupedCountries.containsKey(firstLetter)) {
        // if groupCountries does not have the key of the first letter we initalize it by adding an array to it and the then the country that belongs to that first letter
        groupedCountries[firstLetter] = [];
      }
      groupedCountries[firstLetter]!.add(country);
    }

    return ListView(
      children: groupedCountries.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                entry.key,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              children: entry.value.map((country) {
                return CountriesItem(country: country);
              }).toList(),
            ),
          ],
        );
      }).toList(),
    );
  }
}
