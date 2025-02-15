import 'package:country_info/model/countries_model.dart';
import 'package:country_info/widgets/country_detail.dart';
import 'package:flutter/material.dart';

class CountriesItem extends StatelessWidget {
  const CountriesItem({super.key, required this.country});
  final CountriesModel country;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.network(
          country.flagUrl,
          width: 60,
          height: 40,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 60,
              height: 40,
              color: Colors.grey[300],
              child: Icon(Icons.flag),
            );
          },
        ),
      ),
      title: Text(country.commonName),
      subtitle: Text(country.capital),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CountryDetail(country: country)),
        );
      },
    );
  }
}
