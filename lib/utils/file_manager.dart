import 'dart:convert';
import 'dart:io';

class FileManager {
  final String filePath = 'data/movies.json';

  List<dynamic> readMovies() {
    final file = File(filePath);

    if (!file.existsSync()) {
      return [];
    }

    final content = file.readAsStringSync();

    if (content.isEmpty) {
      return [];
    }

    return jsonDecode(content);
  }

  void saveMovies(List<dynamic> movies) {
    final file = File(filePath);

    file.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(movies));
  }
}