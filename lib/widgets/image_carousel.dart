import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> images;

  const ImageCarousel({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CarouselSlider(
        options: CarouselOptions(height: 300, autoPlay: true),
        items: images.map((img) {
          return Builder(
            builder: (context) {
              return Center(
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(15), // 🔹 Apply border radius
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Image.network(
                      img,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image, size: 50),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
