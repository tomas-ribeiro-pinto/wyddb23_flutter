import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wyddb23_flutter/Components/my_text.dart';

class roundedCard extends StatelessWidget {
  const roundedCard({
    super.key,
    this.imageAsset,
    this.imageUrl,
    required this.title
  });

  final String? imageAsset;
  final String? imageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.width * 0.45,
      width: screenSize.width * 0.45,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned(
              height: screenSize.width * 0.45,
              width: screenSize.width * 0.45,
              child: 
              imageUrl == null 
              ? Image.asset(
                imageAsset ?? "assets/images/wyd-welcome.png",
                fit: BoxFit.cover
              )
              : CachedNetworkImage(
                imageUrl: imageUrl ?? "",
                fit: BoxFit.cover
              )
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.8), Colors.black.withOpacity(0.0)]
                )
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: screenSize.width * 0.04),
              alignment: Alignment.bottomCenter,
              child: MyText(
                title,
                style: TextStyle(
                  letterSpacing: -0.1,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: screenSize.width * 0.045,
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}