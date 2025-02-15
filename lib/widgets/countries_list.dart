import 'package:country_info/model/countries_model.dart';
import 'package:country_info/widgets/countries_item.dart';
import 'package:flutter/material.dart';

class CountriesList extends StatelessWidget {
  const CountriesList({super.key, required this.countries});

  final List<CountriesModel> countries;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: countries.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: CountriesItem(country: countries[index]),
          );
        },
      ),
    );
  }
}
