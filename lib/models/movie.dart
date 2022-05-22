import 'dart:convert';
import 'package:http/http.dart' as http;

class Movie {
  final String id;
  final String title;
  final String originalTitle;
  final String image;

  Movie(
      {required this.id,
      required this.title,
      required this.originalTitle,
      required this.image});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as String,
      title: json['title'] as String,
      originalTitle: json['original_title'] as String,
      image: json['image'] as String,
    );
  }
}

  // var httpUri =
  //     Uri(scheme: 'https', host: 'ghibliapi.herokuapp.com', path: '/films');

  // Future<List<Movie>> fetchData() async {
  //   final response = await http.get(httpUri);
  //   if (response.statusCode == 200) {
  //     List jsonResponse = json.decode(response.body);
  //     return jsonResponse.map((movie) => Movie.fromJson(movie)).toList();
  //   } else {
  //     throw Exception('Unexpected error occured');
  //   }
  // }

  // @override
  // void initState() {
  //   fetchData().then((value) {
  //     movies.addAll(value);
  //   });

  //   super.initState();
  // };
