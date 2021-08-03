import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';

class RecycleTips extends StatefulWidget {
  @override
  _RecycleTipsState createState() => _RecycleTipsState();
}

List<String> images = [
  'assets/images/ksjl9pw181217.jpg',
  'assets/images/fvdou6zj181217.jpg',
  'assets/images/wavylst02single01.jpg',
  'assets/images/x5ft0ije181217.jpg',
];

class _RecycleTipsState extends State<RecycleTips> {
  List<Widget> cards = List.generate(
    images.length,
    (int index) {
      return Card(
        color: Colors.white,
        elevation: 1,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50.0),
                  // boxShadow: [
                  //   BoxShadow(
                  //     offset: Offset(0, 17),
                  //     blurRadius: 23.0,
                  //     spreadRadius: -13.0,
                  //     color: Colors.black54,
                  //   )
                  // ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset(
                    images[index],
                    // fit: BoxFit.fitWidth,
                    // height: 800,
                    // filterQuality: FilterQuality.low,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 15),
              child: ListTile(
                tileColor: Colors.deepPurpleAccent,
                title: Text(
                  'Put everything away after use.',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text(
                    'This might seem like an obvious tip, but failing to'
                    ' put away your belongings is the main culprit of untidiness. '
                    'As you move from one room to another, do a quick scan to see '
                    'if there’s anything that you can take with you. Go out of your way '
                    'to make sure that anything you wear, use or move ends up where it belongs. It’s easy to leave a pair of s',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    },
  );

  TCardController _controller = TCardController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height * 0.8,
        child: Center(
          child: TCard(
            cards: cards,
            controller: _controller,
            size: Size(400, 600),
            onEnd: () {
              setState(() {
                _controller.reset();
              });
            },
          ),
        ),
      ),
    );
  }
}
