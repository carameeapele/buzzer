import 'package:buzzer/screens/loading.dart';
import 'package:buzzer/screens/movies/movie.dart';
import 'package:buzzer/style/text_style.dart';
import 'package:buzzer/widgets/app_bar_widget.dart';
import 'package:buzzer/widgets/menu_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'movie_tile.dart';
import 'package:http/http.dart' as http;

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  var movies;

  Future<String> getData() async {
    var httpUri =
        Uri(scheme: 'https', host: 'ghibliapi.herokuapp.com', path: '/films');

    final dummyResponse = await http.get(httpUri);
    return dummyResponse.body.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: false,
      appBar: AppBarWidget(
        title: 'Events',
      ),
      drawer: const MenuDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Movies',
                style: subtitleTextStyle,
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextButton(
                onPressed: () async {
                  var httpUri = Uri(
                      scheme: 'https',
                      host: 'ghibliapi.herokuapp.com',
                      path: '/films');

                  final dummyResponse = await http.get(httpUri);
                  //print('');
                },
                child: const Text('click me'),
              ),
              FutureBuilder(
                  future: getData(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      movies = parseMovies(snapshot.data);
                      return ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          var item = movies[index];
                          return MovieTile(
                            title: item.title,
                            originalTitle: item.originalTitle,
                          );
                        },
                      );
                    }

                    return Loading();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
