import 'package:flutter/material.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({
    Key? key,
    required this.title,
    required this.originalTitle,
  }) : super(key: key);

  final String title;
  final String originalTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            originalTitle,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 12.0,
            ),
          )
        ],
      ),
    );
  }
}
