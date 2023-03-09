import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvManager {
  static final _instance = EnvManager._();

  factory EnvManager() => _instance;

  EnvManager._();
  static EnvManager get shared => _instance;

  String get apiUrl => dotenv.env['API_BASE_URL']!;

  String get apiKey => dotenv.env['API_KEY']!;
}
