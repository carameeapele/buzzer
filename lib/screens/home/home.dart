import 'package:buzzer/components/menu_list_tile.dart';
import 'package:buzzer/main.dart';
import 'package:buzzer/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Future<List<Movie>> movies;

  void initState() {
    super.initState();
    //movies = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          'Today',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto',
            fontSize: 25.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrange,
              padding: const EdgeInsets.all(6.0),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        elevation: 0.0,
        backgroundColor: Colors.deepOrange,
        child: ListView(
          padding: const EdgeInsets.only(left: 20.0),
          children: <Widget>[
            const DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Roboto',
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              selected: true,
              selectedColor: Colors.white,
              title: Text(
                'Today',
                style: menuListTile,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              selected: false,
              title: Text(
                'Tasks',
                style: menuListTile,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Timetable',
                style: menuListTile,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Calendar',
                style: menuListTile,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Settings',
                style: menuListTile,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }
}
