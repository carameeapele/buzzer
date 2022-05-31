import 'dart:convert';
import 'package:http/http.dart' as http;

class Movie {
  final String id;
  final String title;
  final String originalTitle;

  Movie({
    required this.id,
    required this.title,
    required this.originalTitle,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as String,
      title: json['title'] as String,
      originalTitle: json['original_title_romanised'] as String,
    );
  }
}

List<Movie> parseMovies(String response) {
  final parsed = jsonDecode(response).cast<Map<String, dynamic>>();
  return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
}

  // @override
  // void initState() {
  //   fetchData().then((value) {
  //     movies.addAll(value);
  //   });

  //   super.initState();
  // };
