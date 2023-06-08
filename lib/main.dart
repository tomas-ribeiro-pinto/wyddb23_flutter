import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WYD Don Bosco 23',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 2, 153, 68),),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'WYD Don Bosco 23'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int pageIndex = 0;

  final pages = [
    const Page1(title: 'WYD Don Bosco 23'),
    const Page2(),
    const Page3(),
    const Page4(),
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:const Color.fromARGB(255, 2, 153, 68),
    ));
    return Scaffold(
      /** 
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      */
      body:  
        pages[pageIndex],
        backgroundColor: Colors.white,
        /** 
        Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: _incrementCounter, 
              icon: Icon(Icons.add), 
              label: Text("Tap on this"),
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      */
      // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
              color: const Color.fromARGB(255, 2, 153, 68),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
        child: SafeArea(
              child: Container(
                    height: 65,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 2, 153, 68),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        
                      ),
                  ),
                  child: OverflowBox(
                    maxHeight: 110,
                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                        IconButton(
                          enableFeedback: false,
                          onPressed: () {
                            setState(() {
                              pageIndex = 0;
                            });
                          },
                          icon: pageIndex == 0
                              ? const Icon(
                                  Icons.home_filled,
                                  color: Colors.white,
                                  size: 35,
                                )
                              : const Icon(
                                  Icons.home_outlined,
                                  color: Colors.white,
                                  size: 35,
                                ),
                        ),
                        IconButton(
                          enableFeedback: false,
                          onPressed: () {
                            setState(() {
                              pageIndex = 1;
                            });
                          },
                          icon: pageIndex == 1
                              ? const Icon(
                                  Icons.work_rounded,
                                  color: Colors.white,
                                  size: 35,
                                )
                              : const Icon(
                                  Icons.work_outline_outlined,
                                  color: Colors.white,
                                  size: 35,
                                ),
                        ),
                          Container(
                            margin: EdgeInsets.only(bottom: 35),
                            decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color.fromARGB(255, 194, 194, 194),
                              width: 0.3,
                            ),
                            borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 40,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                          ),
                          child: IconButton(
                                enableFeedback: false,
                                onPressed: () {
                                  setState(() {
                                    pageIndex = 3;
                                  });
                                },
                                icon: Image.asset(
                                  'assets/images/wyd-logo-cor.png',
                                  fit: BoxFit.fill,
                                  height: 70,
                                ),
                              ),
                            ),
                          IconButton(
                            enableFeedback: false,
                            onPressed: () {
                              setState(() {
                                pageIndex = 3;
                              });
                            },
                            icon: pageIndex == 3
                                ? const Icon(
                                    Icons.access_alarm_outlined,
                                    color: Colors.white,
                                    size: 35,
                                  )
                                : const Icon(
                                    Icons.person_outline,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                          ),
                          IconButton(
                            enableFeedback: false,
                            onPressed: () {
                              setState(() {
                                pageIndex = 3;
                              });
                            },
                            icon: pageIndex == 3
                                ? const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 35,
                                  )
                                : const Icon(
                                    Icons.person_outline,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                          ),
                                      ],
                                    ),
                  ),
                    ),
                  ),
            ),
    );
  }
}

class Page1 extends StatefulWidget {
  const Page1({super.key, required this.title});
  
  final String title;

  @override
  State<Page1> createState() => _Page1State();

}

class _Page1State extends State<Page1> {  

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/wyd-home-green.jpg"),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topLeft,
          ),
          
        ),
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            //
            // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
            // action in the IDE, or press "p" in the console), to see the
            // wireframe for each widget.
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                  height: 50.0,
                child: ElevatedButton.icon(
                  onPressed: _incrementCounter, 
                  icon: Icon(Icons.add, size: 24.0) , 
                  label: Text("Tap on this"),
                ),
              ),
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
    );
  }
}
  
class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffC4DFCB),
      child: Center(
        child: Text(
          "Page Number 2",
          style: TextStyle(
            color: Colors.green[900],
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
  
class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffC4DFCB),
      child: Center(
        child: Text(
          "Page Number 3",
          style: TextStyle(
            color: const Color.fromARGB(255, 2, 153, 68),
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
  
class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffC4DFCB),
      child: Center(
        child: Text(
          "Page Number 4",
          style: TextStyle(
            color: Colors.green[900],
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
