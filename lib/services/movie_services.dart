import 'dart:io';

import '../models/movie.dart';
import '../utils/file_manager.dart';

class MovieService {
  final FileManager fileManager = FileManager();

  // Generate movie ID automatically
  int getNextId() {
    List<dynamic> movies = fileManager.readMovies();

    if (movies.isEmpty) {
      return 1;
    }

    int maxId = 0;

    for (var movie in movies) {
      int id = movie['id'];

      if (id > maxId) {
        maxId = id;
      }
    }

    return maxId + 1;
  }

  // Add movie
  void addMovie(Movie movie) {
    List<dynamic> movies = fileManager.readMovies();

    movies.add(movie.toJson());

    fileManager.saveMovies(movies);

    print('');
    print('Movie added successfully!');
  }

  // Remove movie
  void removeMovie(int id) {
    List<dynamic> movies = fileManager.readMovies();

    int oldLength = movies.length;

    movies.removeWhere(
      (movie) => movie['id'] == id,
    );

    if (movies.length == oldLength) {
      print('Movie not found!');
      return;
    }

    fileManager.saveMovies(movies);

    print('Movie removed successfully!');
  }

  // Get all movies
  List<Movie> getMovies() {
    List<dynamic> movies = fileManager.readMovies();

    return movies
        .map((movie) => Movie.fromJson(movie))
        .toList();
  }

  // Export movies 
  Future<void> exportCsv() async {
    List<Movie> movies = getMovies();

    if (movies.isEmpty) {
      print('No movies to export.');
      return;
    }

    final userProfile = Platform.environment['UserProfile'];

    if (userProfile == null) {
      print('Could not find Downloads folder.');
      return;
    }

    final downloadsFolder = Directory(
      '$userProfile\\Downloads',
    );

    if (!downloadsFolder.existsSync()) {
      downloadsFolder.createSync(recursive: true);
    }

    final file = File(
      '${downloadsFolder.path}\\movies.csv',
    );

    final sink = file.openWrite();

    // CSV header
    sink.writeln(
      'id,name,genre,year,director,actors,rating',
    );

    // Movie data
    for (final movie in movies) {
      sink.writeln(
        '${movie.id},'
        '${escapeCsv(movie.name)},'
        '${escapeCsv(movie.genre)},'
        '${movie.year},'
        '${escapeCsv(movie.director)},'
        '${escapeCsv(movie.actors.join('|'))},'
        '${movie.rating}',
      );
    }

    await sink.close();

    print('');
    print('CSV exported successfully!');
    print('File: ${file.path}');
  }

  // Escape CSV values
  String escapeCsv(String value) {
    return '"${value.replaceAll('"', '""')}"';
  }
}