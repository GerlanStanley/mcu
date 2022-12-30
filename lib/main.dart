import 'package:flutter/material.dart';

import 'app/presenter/pages/movies/movies.dart';
import 'core/constants/constants.dart';

void main() {
  runApp(MaterialApp(
    title: "MCU",
    theme: ThemeConstants.dark,
    home: const MoviesPage(),
  ));
}
