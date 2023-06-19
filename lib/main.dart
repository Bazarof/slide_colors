import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyScaffold(),
    );
  }
}

class MyScaffold extends StatefulWidget {
  const MyScaffold({super.key});

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  
  final offsets = <Offset>[Offset.zero, Offset.zero];
  var isUp = <bool>[true, true];
  int index = 0;

  final colorsRgb = <Color>[Colors.red, Colors.green, Colors.blue];
  Color fcolor = Colors.red;
  final wColors = ['RED', 'GREEN', 'BLUE'];
  String wColor = 'RED';

  Color setColor(List isUp){
    int i = 0;
    for(i; i < isUp.length; i++){
      if(isUp[i]){
        return colorsRgb[i];
      }
    }
    return colorsRgb[i];
  }

  String setText(List isUp){
    int i = 0;
    for(i; i < isUp.length; i++){
      if(isUp[i]){
        return wColors[i];
      }
    }
    return wColors[i];
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Center(
            child: AnimatedSlide(
              offset: Offset.zero,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              child: Container(
                height: screenSize.height,
                width: screenSize.width,
                color: colorsRgb.last,
              ),
            ),
          ),
          Center(
            child: AnimatedSlide(
              offset: offsets[1],
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              child: Container(
                height: screenSize.height,
                width: screenSize.width,
                color: colorsRgb[1],
              ),
            ),
          ),
          Center(
            child: AnimatedSlide(
              offset: offsets[0],
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              child: Container(
                height: screenSize.height,
                width: screenSize.width,
                color: colorsRgb.first,
              ),
            ),
          ),
          Center(
            child: BigCard(
                displayText: wColor, textColor: fcolor),
          ),
          Positioned(
            bottom: 30,
            child: Container(
              width: screenSize.width,
              margin: const EdgeInsets.symmetric(vertical: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Up
                  FloatingActionButton(
                    foregroundColor: fcolor, 
                    backgroundColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        if(!isUp[index]){
                          offsets[index] = Offset(offsets[index].dx, offsets[index].dy-1);
                          isUp[index] = true;
                        }else{
                          if(!((index-1) == -1)){
                            index--;
                            offsets[index] = Offset(offsets[index].dx, offsets[index].dy-1);
                            isUp[index] = true;
                          }
                        }
                        //setting the foreground color
                        fcolor = setColor(isUp);
                        //setting the text
                        wColor = setText(isUp);
                      });
                    },
                    child: const Icon(Icons.arrow_upward, size: 40.0),
                  ),
                  //Down
                  FloatingActionButton(
                    foregroundColor: fcolor,
                    backgroundColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        if(isUp[index]){
                          offsets[index] = Offset(offsets[index].dx, offsets[index].dy+1);
                          isUp[index] = false;
                        }else{
                          if(!((index+1) == isUp.length)){
                            index++;
                            offsets[index] = Offset(offsets[index].dx, offsets[index].dy+1);
                            isUp[index] = false;
                          }
                        }
                        //setting the foreground color
                        fcolor = setColor(isUp);
                        //setting the text
                        wColor = setText(isUp);
                      });
                    },
                    child: const Icon(Icons.arrow_downward, size: 40.0,),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({super.key, required this.displayText, required this.textColor});

  final String displayText;

  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: Wrap(
              spacing: 8.0,
              children: [
                Text(
                  displayText,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text('on screen', style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),),
              ],
            )),
      ),
    );
  }
}
