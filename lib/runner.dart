import 'package:data/di/injection.dart';
import 'package:domain/di/injection.dart';
import 'package:flutter/material.dart';

import 'di/injection.dart';
import 'main.dart';

void runnerApp() {
  configureDependencies();
  configureDomainDependencies();
  configureDataDependencies();
  runApp(MyApp());
}
