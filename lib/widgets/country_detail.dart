import 'package:country_info/model/countries_model.dart';
import 'package:country_info/widgets/image_carousel.dart';
import 'package:flutter/material.dart';

class CountryDetail extends StatelessWidget {
  CountryDetail({super.key, required this.country})
      : images = [country.flagUrl, country.coatOfArm];

  final CountriesModel country;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          country.commonName,
          textAlign: TextAlign.start,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: ImageCarousel(images: images),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.all(1)),
                    _countryInfoSection('Capital', country.capital),
                    _countryInfoSection('Continent', country.continents),
                    _countryInfoSection(
                        'Population', country.population.toString()),
                    _countryInfoSection('Subregion', country.subregion),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.all(1)),
                        _countryInfoSection(
                            'Independence', country.independent),
                        _countryInfoSection('Area', country.area.toString()),
                        _countryInfoSection('Currency', country.currencyName),
                        _countryInfoSection('Language', country.firstLanguage),
                        _countryInfoSection('Timezone', country.timezones),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _countryInfoSection(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        '$label: $value',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
