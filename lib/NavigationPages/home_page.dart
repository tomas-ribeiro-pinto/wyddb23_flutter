
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Set Status Bar Text Color
      value: SystemUiOverlayStyle.light,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/wyd-home-green.jpg"),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topLeft,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                margin: const EdgeInsets.only(top: 160),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/home-pic.png"),
                    fit: BoxFit.contain,
                    alignment: Alignment.topLeft,
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Transform.scale(
                scale: 0.65,
                child: Container(
                  margin: const EdgeInsets.only(top:45, right: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 194, 194, 194),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: FloatingActionButton( 
                      backgroundColor: const Color.fromARGB(255, 35, 35, 35),
                      foregroundColor: Colors.white,
                      onPressed:() {},
                      child: const Text(
                        "EN",
                        style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        color: Colors.white,
                        fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top:90),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(
                "Hello, Lisboa",
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  color: Colors.white,
                  fontSize: 33,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}