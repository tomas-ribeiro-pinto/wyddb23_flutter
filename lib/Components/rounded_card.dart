import 'package:flutter/material.dart';

class roundedCard extends StatelessWidget {
  const roundedCard({
    super.key,
    required this.imageUrl
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.width * 0.45,
      width: screenSize.width * 0.45,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          imageUrl,
          fit: BoxFit.cover
        ),
      )
    );
  }
}