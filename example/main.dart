import 'package:auto_scroll_view/auto_scroll_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

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

const randomCovers = [
  "https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2634539726.jpg",
  "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2685482998.jpg",
  "https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2662626665.jpg",
  "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2678298618.jpg",
  "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2675102928.jpg",
  "https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2681332523.jpg",
  "https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2711915971.jpg",
  "https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2655000580.jpg",
  "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2707727239.jpg",
  "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2704450439.jpg",
  "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2665872718.jpg",
  "https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2665001891.jpg",
  "https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2707553644.jpg",
  "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2702918768.jpg",
  "https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2656407373.jpg",
  "https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2677520025.jpg",
  "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2640615589.jpg",
  "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2678875868.jpg",
  "https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2652833060.jpg",
  "https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2704531912.jpg",
  "https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2681328483.jpg",
  "https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2676919475.jpg",
  "https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2637896820.jpg",
  "https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2685374824.jpg",
  "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2665927388.jpg",
  "https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2659155163.jpg",
  "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2629056068.jpg",
  "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2651298629.jpg",
  "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2692328438.jpg",
  "https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2675197481.jpg",
  "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2618247457.jpg",
  "https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2629413230.jpg",
  "https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2627392971.jpg",
  "https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2634253484.jpg",
  "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2626260539.jpg",
  "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2656934367.jpg",
  "https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2619560250.jpg",
  "https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2640758773.jpg",
  "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2654767767.jpg",
  "https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2646890883.jpg",
  "https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2585419056.jpg",
  "https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2681062261.jpg",
  "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2630539409.jpg",
  "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2687368709.jpg",
  "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2663205329.jpg",
  "https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2624784272.jpg",
  "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2639843077.jpg",
  "https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2636832800.jpg",
  "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2638872429.jpg",
  "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2673001717.jpg",
  "https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2628762684.jpg",
  "https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2675925721.jpg",
  "https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2664170473.jpg",
  "https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2630022800.jpg",
];

class _MyHomePageState extends State<MyHomePage> {
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
    final size = MediaQuery.of(context).size;
    var itemWidth = (size.width - 8) / 4;
    var itemHeight = itemWidth * 1.4;
    final height = size.height;
    debugPrint('width is $itemWidth; height is $height');

    return Scaffold(
      body: Center(
        child: Container(
          child: Stack(
            children: [
              const Opacity(
                opacity: 0.5,
                child: AutoScrollView(
                    gapSpace: 5,
                    perferSise: 120,
                    aspectRatio: 1.6,
                    speed: 0.8,
                    covers: randomCovers),
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0x33000000), Color(0xff000000)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ],
          ),
          color: Colors.black,
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
