import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../Components/my_text.dart';
import '../language_constants.dart';

class VisitPage extends StatelessWidget {
  const VisitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      color:Color(0xFFf6be18),
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              getBanner(screenSize, context),
              StickyHeader(
                header: Stack(
                  children: [
                    Container(
                      color: Color(0xFFf6be18),
                      width: screenSize.width,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05, vertical: 20),
                        child: MyText(
                          translation(context).visit.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: screenSize.height * 0.04,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02, vertical: 18),
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        alignment: Alignment.topRight,
                          child: TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 15)),
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return Color(0xFFd53f28);
                            }),
                          ),
                          onPressed: () {}, 
                          child: Container(
                            width: screenSize.width * 0.5,
                            alignment: Alignment.center,
                            child: MyText(
                            translation(context).seeMap.toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: screenSize.height * 0.02,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                content: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: MyText(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: screenSize.height * 0.02,
                        ),
                      ),
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      spacing: 25.0,
                      children: [
                        getVisitButton(screenSize, "Torre de Belém", "https://cdn-imgix.headout.com/microbrands-content-image/image/f94caf06c3d6d7779a089fea20611e99-AdobeStock_314194172.jpeg"),
                        getVisitButton(screenSize, "Rua Augusta", "https://www.lisbonportugaltourism.com/images/lisbon-rua-augusta.jpg"),
                        getVisitButton(screenSize, "Elevador S. Justa", "https://offloadmedia.feverup.com/lisboasecreta.co/wp-content/uploads/2020/05/16095345/curiosidades-sobre-o-Elevador-de-Santa-Justa-%40kit-suman.jpg"),
                        getVisitButton(screenSize, "Terreiro do Paço", "https://www.lisbonguru.com/wp-content/uploads/2015/12/terreiro-paco-dia.jpg"),
                        getVisitButton(screenSize, "Parque Eduardo VII", "https://offloadmedia.feverup.com/lisboasecreta.co/wp-content/uploads/2020/09/07044241/Parques-e-Jardins-de-Lisboa-Parque-Eduardo-VII-o-roteiro-obrigat%C3%B3rio-Foto-por-Kit-Suman-scaled.jpg"),
                        getVisitButton(screenSize, "Castelo S. Jorge", "https://s7a5n8m2.stackpathcdn.com/wp-content/uploads/2015/03/castelo-sao-jorge-fortifica%C3%A7%C3%A3o-e1598288055243.jpg"),
                      ],
                    ),
                    Container(
                      height: 150,
                      color: Colors.transparent,
                    ),
                  ],
                              ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  Container getVisitButton(Size screenSize, String string, String url)
  {
    return Container(
      child: GestureDetector(
        child: Container(
         decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10)
         ),
         margin: EdgeInsets.only(top:20),
         height: screenSize.width * 0.27,
         width: screenSize.width * 0.4,
         child: Stack(
           children: [
            CachedNetworkImage(
              imageUrl: url,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: screenSize.width * 0.06,),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.white.withOpacity(0.8), Colors.white.withOpacity(0.0)]
                )
              ),
            ),
            Container(
              width: screenSize.width * 0.5,
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              alignment: Alignment.bottomLeft,
              child: MyText(
              string.toUpperCase(),
              style: TextStyle(
                  letterSpacing: -0.1,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: screenSize.width * 0.045,
                ),
              ),
            ),
           ],
         ),
        ),
        onTap:(){
         print("you clicked me");
        }
      ),
    );
  }


  Container getBanner(Size screenSize, BuildContext context) {
    return Container(
        height: screenSize.height * 0.05,
        width: screenSize.width,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
      );
  }
}