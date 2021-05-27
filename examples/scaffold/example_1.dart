import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: DataPage(),
      home: FlutterExample(),
    );
  }
}

class FlutterExample extends StatefulWidget {
  @override
  _FlutterExampleController createState() => _FlutterExampleController();
}

class _FlutterExampleController extends State<FlutterExample> {
  int count = 0;

  void set() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _FlutterExampleView(this);
}

class _FlutterExampleView extends StatelessWidget {
  final _FlutterExampleController state;
  const _FlutterExampleView(this.state, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Example'),
      ),
      body: Center(
        child: Text('Button pressed ${state.count} times.'),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          state.count++;
          state.set();
        },
        tooltip: 'Increment Counter',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      drawer: Drawer(
        elevation: 20.0,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Ivan Gavrilov"),
              accountEmail: Text("ivan@calckit.io"),
              currentAccountPicture: CircleAvatar(backgroundColor: Colors.white, child: Text("IG")),
            ),
            ListTile(title: new Text("List Tile 1"), leading: new Icon(Icons.android_rounded)),
            Divider(height: 1),
            ListTile(title: new Text("List Tile 2"), leading: new Icon(Icons.android_rounded)),
            ListTile(title: new Text("List Tile 3"), leading: new Icon(Icons.android_rounded)),
            ListTile(title: new Text("List Tile 4"), leading: new Icon(Icons.android_rounded))
          ],
        ),
      ),
    );
  }
}
