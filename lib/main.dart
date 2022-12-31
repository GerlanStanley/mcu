import 'package:flutter/material.dart';
import 'package:mcu/core/inject/inject.dart';

import 'app/presenter/pages/movies/movies.dart';
import 'core/constants/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Inject.initialize();

  runApp(MaterialApp(
    title: "MCU",
    theme: ThemeConstants.dark,
    home: const MoviesPage(),
  ));
}
