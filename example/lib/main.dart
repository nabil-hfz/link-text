import 'package:flutter/material.dart';
import 'package:link_text/link_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Link Text',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Link Text Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text;

  @override
  void initState() {
    super.initState();
    text = 'https://google.com';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: false,
              onChanged: (newText) {
                text = newText;
                setState(() {});
              },
              style: TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'www.example.com',
                contentPadding:
                const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(25.7),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(25.7),
                ),
              ),
            ),
          ),
          Spacer(),
          TextLinkWidget(
            text: '${text ?? ''}',
            style: Theme.of(context).textTheme.headline4,
            textLinkStyle: TextStyle(fontSize: 32, color: Colors.red),
          ),
          Spacer(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          text = '';
          setState(() {});
        },
        tooltip: 'Clear',
        child: Icon(Icons.clear),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
