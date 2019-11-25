import 'package:flutter/material.dart';
import 'package:segment_display/segment_display.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //showSemanticsDebugger: true,
      title: 'Flutter Segment Display Example',
      theme: ThemeData(
        accentColor: const Color(0xFFFF0000),
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'Flutter Segment Display Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter;
  double _decimalCounter;
  SegmentStyle _segmentStyle;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _counter = 0;
    _decimalCounter = 0.0;
    _segmentStyle = DefaultSegmentStyle(
      enabledColor: Theme.of(context).accentColor,
      disabledColor: Theme.of(context).accentColor.withOpacity(0.15),
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _decimalCounter += 0.1;
    });
  }

  void _changeSegmentStyle(SegmentStyle segmentStyle) {
    setState(() {
      _segmentStyle = segmentStyle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton<SegmentStyle>(
            tooltip: "Segment style",
            onSelected: _changeSegmentStyle,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<SegmentStyle>(
                  value: DefaultSegmentStyle(
                    enabledColor: Theme.of(context).accentColor,
                    disabledColor:
                        Theme.of(context).accentColor.withOpacity(0.15),
                  ),
                  child: const Text("Default"),
                ),
                PopupMenuItem<SegmentStyle>(
                  value: RectSegmentStyle(
                    enabledColor: Theme.of(context).accentColor,
                    disabledColor:
                        Theme.of(context).accentColor.withOpacity(0.15),
                  ),
                  child: const Text("Rect"),
                ),
                PopupMenuItem<SegmentStyle>(
                  value: HexSegmentStyle(
                    enabledColor: Theme.of(context).accentColor,
                    disabledColor:
                        Theme.of(context).accentColor.withOpacity(0.15),
                  ),
                  child: const Text("Hex"),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SevenSegmentDisplay(
              value: _decimalCounter.toStringAsFixed(1),
              size: 8.0,
              backgroundColor: Colors.transparent,
              segmentStyle: _segmentStyle,
            ),
            const SizedBox(height: 20),
            FourteenSegmentDisplay(
              value: "$_counter:$_counter",
              size: 8.0,
              backgroundColor: Colors.transparent,
              segmentStyle: _segmentStyle,
            ),
            const SizedBox(height: 20),
            SixteenSegmentDisplay(
              value: "$_counter",
              size: 8.0,
              backgroundColor: Colors.transparent,
              segmentStyle: _segmentStyle,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
