import 'package:flutter/material.dart';
import 'package:hive_demo/user.dart';

import 'database_helper.dart';

void main() async {
  await DatabaseHelper.setupDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder<List<User>>(
          future: DatabaseHelper.getAllUsers(),
          initialData: [],
          builder: (context, snapshot) => MyHomePage(
            title: 'Flutter Demo Home Page',
            users: snapshot.data,
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.users}) : super(key: key);
  final String title;
  List<User> users;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future _addUser() async {
    await DatabaseHelper.addRandomUser();
    final newUsers = await DatabaseHelper.getAllUsers();
    setState(() {
      widget.users.replaceRange(0, widget.users.length, newUsers);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: widget.users.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(
                '${widget.users[index].name} (${widget.users[index].age})'),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addUser,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
