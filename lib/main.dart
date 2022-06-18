import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'src/app.dart';
import 'src/common/environment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load configuration files
  await dotenv.load(fileName: 'assets/env/${Environment.fileName}');
  runApp(MyApp());
}
