import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
** MEHMET YAVUZ YALCIN **
  This application tries to find the optimal Grid column count for the given Texts.
  The main purpose is to be able to change the Grid crossAxisCount with respect to
the change of font size within device settings.
  Method:
  - From given texts, we try to find the one with maximum width covered.
    * To be able to do this, we are multiplying the given FontSize with the textScaleFactor
    gathered from device settings.
  - After finding the longest text (in terms of width it covers), we are getting the total
  width of the device screen (all in terms of pixel values)
  - We divide the total width to longest text width, and truncate this double value to the
  closest smaller integer. This will give us the crossAxisCount of the GridView.
*/

const double FontSize = 16;
const double PaddingSize = 10.0;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cubtale Challenge',
      theme: ThemeData(
        textTheme: const TextTheme(
          caption:    TextStyle(fontSize: FontSize),
          bodyText1:  TextStyle(fontSize: FontSize),
          bodyText2:  TextStyle(fontSize: FontSize),
          button:     TextStyle(fontSize: FontSize),
          subtitle1:  TextStyle(fontSize: FontSize),
          subtitle2:  TextStyle(fontSize: FontSize),
          headline1:  TextStyle(fontSize: FontSize),
          headline2:  TextStyle(fontSize: FontSize),
          headline3:  TextStyle(fontSize: FontSize),
          headline4:  TextStyle(fontSize: FontSize),
          headline5:  TextStyle(fontSize: FontSize),
          headline6:  TextStyle(fontSize: FontSize),
        ),
        fontFamily: 'Raleway',
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage2(title: 'Cubtale'),
    );
  }
}

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage2> createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> {

  bool hasOverflow = false;
  double longestTextWidth = 0.0;
  late int gridSize = 3;


  TextOverflow Overflow(){
    setState(() {
      hasOverflow = true;
    });
    return TextOverflow.visible;
  }

  //We hold all of the texts here
  var texts = [
    'yavuz', 'denemedeneme', 'selamselamselam', 'selamselamselamse', 'abcde', '123456789',
    'fenafena', 'iyiiyi', 'kocaeli', 'istanbul', 'deneme', 'denememe' , 'Michy', 'Batshuayi',
    'Hakeem', 'Olajuwon', 'Kareem', 'Abdul', 'Jabbar', 'Lebron',
  ];

//THE MINIMUM POSSIBLE CASE
  /* var texts = [
    'yavuz', 'yavuz', 'yavuz', 'yavuz', 'yavuz', 'yavuz',
    'yavuz', 'yavuz', 'yavuz', 'yavuz', 'yavuz', 'yavuz',
    'yavuz', 'yavuz', 'yavuz', 'yavuz', 'yavuz', 'yavuz',
    'yavuz', 'yavuz'
  ];*/

  @override
  Widget build(BuildContext context){

    //Reset the longest text width each time
    longestTextWidth = 0.0;

    //Get the scale factor from device settings
    double textScale = MediaQuery.of(context).textScaleFactor;

    //To find the longest text (the one that covers maximum width)
    for(String txt in texts){
      Size txtSize = _textSize(txt, TextStyle(fontSize: FontSize * textScale));
      if(txtSize.width > longestTextWidth){
        longestTextWidth = txtSize.width;
      }
    }

    //Size of the device
    final totalSize = MediaQuery.of(context).size.width;
    gridSize = ((totalSize - (PaddingSize*2)) / longestTextWidth).truncate();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        title: Text(widget.title, style: TextStyle(color: Colors.teal),),
      ),
      body: Padding(
        padding: EdgeInsets.all(PaddingSize),
        child: GridView.count(
          crossAxisCount: gridSize,
          children: [
            Column(
              children: [
                Text(texts[0], overflow: Overflow()),
                Text(texts[1], overflow: Overflow()),
              ],
            ),
            Column(
              children: [
                Text(texts[2], overflow: Overflow()),
                Text(texts[3], overflow: Overflow()),
              ],
            ),
            Column(
              children: [
                Text(texts[4], overflow: Overflow()),
                Text(texts[5], overflow: Overflow()),
              ],
            ),
            Column(
              children: [
                Text(texts[6], overflow: Overflow()),
                Text(texts[7], overflow: Overflow()),
              ],
            ),
            Column(
              children: [
                Text(texts[8], overflow: Overflow()),
                Text(texts[9], overflow: Overflow()),
              ],
            ),
            Column(
              children: [
                Text(texts[10], overflow: Overflow()),
                Text(texts[11], overflow: Overflow()),
              ],
            ),
            Column(
              children: [
                Text(texts[12], overflow: Overflow()),
                Text(texts[13], overflow: Overflow()),
              ],
            ),
            Column(
              children: [
                Text(texts[14], overflow: Overflow()),
                Text(texts[15], overflow: Overflow()),
              ],
            ),
            Column(
              children: [
                Text(texts[16], overflow: Overflow()),
                Text(texts[17], overflow: Overflow()),
              ],
            ),
            Column(
              children: [
                Text(texts[18], overflow: Overflow()),
                Text(texts[19], overflow: Overflow()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//The code to get the size of the text
Size _textSize(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style), maxLines: 1, textDirection: TextDirection.ltr)
    ..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size;
}
