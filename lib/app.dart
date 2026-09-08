import 'dart:io';

import 'models/movie.dart';
import 'services/movie_services.dart';

Future<void> runApp() async{
  while (true) {
    print('');
    print('================================');
    print('         | MOVIE CLI APP |');
    print('================================');
    print('');
    print('1.| Add Movie');
    print('2.| Remove Movie');
    print('3.| Show All Movies');
    print('4.| Filter Movies');
    print('5.| Export Movies to CSV');
    print('6.| Exit');
    print('');
    print('================================');
    print('Enter your choice:');

    String? choice = stdin.readLineSync();

    print('');

    switch (choice) {
      case '1':
        print('');
        print('===== ADD MOVIE =====');

        MovieService movieService = MovieService();

        // ID is generated automatically
        int id = movieService.getNextId();

        print('Movie ID: $id');

        print('Enter movie name:');
        String name = stdin.readLineSync()!;

        print('Enter movie genre:');
        String genre = stdin.readLineSync()!;

        print('Enter movie year:');
        int year = int.parse(stdin.readLineSync()!);

        print('Enter movie director:');
        String director = stdin.readLineSync()!;

        print('Enter movie actors:');
        String actorsInput = stdin.readLineSync()!;

        List<String> actors = actorsInput.split(',');

        print('Enter movie rating:');
        double rating = double.parse(stdin.readLineSync()!);

        Movie movie = Movie(
          id: id,
          name: name,
          genre: genre,
          year: year,
          director: director,
          actors: actors,
          rating: rating,
        );

        movieService.addMovie(movie);

        break;

      case '2':
        print('');
        print('===== REMOVE MOVIE =====');

        print('Enter movie ID:');

        int id = int.parse(stdin.readLineSync()!);

        MovieService movieService = MovieService();

        movieService.removeMovie(id);

        break;

      case '3':
        print('');
        print('===== ALL MOVIES =====');
        print('');

        MovieService movieService = MovieService();

        List<Movie> movies = movieService.getMovies();

        if (movies.isEmpty) {
          print('No movies found!');
        } else {
          for (Movie movie in movies) {
            print('');
            print('ID: ${movie.id}');
            print('Name: ${movie.name}');
            print('Genre: ${movie.genre}');
            print('Year: ${movie.year}');
            print('Director: ${movie.director}');
            print('Actors: ${movie.actors.join(', ')}');
            print('Rating: ${movie.rating}');
            print('--------------------------------');
          }
        }

        break;

      case '4':
        while (true) {
          print('');
          print('===== FILTER MOVIES =====');
          print('');
          print('1. Get All Movies Reports');
          print('2. Filter by Genre');
          print('3. Filter by Year');
          print('4. Back to Main Menu');
          print('');
          print('Enter your choice:');
          String? filterChoice = stdin.readLineSync();

          MovieService movieService = MovieService();
          List<Movie> movies = movieService.getMovies();

          print('');

          switch (filterChoice) {
            case '1':
              print('===== ALL MOVIES REPORT =====');
              print('');

              if (movies.isEmpty) {
                print('No movies found!');
              } else {
                print('Total Movies: ${movies.length}');

                double totalRating = 0;

                for (Movie movie in movies) {
                  totalRating += movie.rating;
                }

                double averageRating =
                    totalRating / movies.length;

                print(
                  'Average Rating: ${averageRating.toStringAsFixed(2)}',
                );
              }

              break;

            case '2':
              print('Enter genre:');

              String genre =
                  stdin.readLineSync()!.trim().toLowerCase();

              List<Movie> filteredMovies = movies
                  .where(
                    (movie) =>
                        movie.genre.toLowerCase() == genre,
                  )
                  .toList();

              print('');
              print('===== MOVIES BY GENRE =====');

              if (filteredMovies.isEmpty) {
                print('No movies found for genre: $genre');
              } else {
                for (Movie movie in filteredMovies) {
                  print('');
                  print('ID: ${movie.id}');
                  print('Name: ${movie.name}');
                  print('Genre: ${movie.genre}');
                  print('Year: ${movie.year}');
                  print('Director: ${movie.director}');
                  print(
                    'Actors: ${movie.actors.join(', ')}',
                  );
                  print('Rating: ${movie.rating}');
                  print('--------------------------------');
                }
              }

              break;

            case '3':
              print('Enter year:');

              int year =
                  int.parse(stdin.readLineSync()!);

              List<Movie> filteredMovies = movies
                  .where(
                    (movie) => movie.year == year,
                  )
                  .toList();

              print('');
              print('===== MOVIES BY YEAR =====');

              if (filteredMovies.isEmpty) {
                print('No movies found for year: $year');
              } else {
                for (Movie movie in filteredMovies) {
                  print('');
                  print('ID: ${movie.id}');
                  print('Name: ${movie.name}');
                  print('Genre: ${movie.genre}');
                  print('Year: ${movie.year}');
                  print('Director: ${movie.director}');
                  print(
                    'Actors: ${movie.actors.join(', ')}',
                  );
                  print('Rating: ${movie.rating}');
                  print('--------------------------------');
                }
              }

              break;

            case '4':
              break;

            default:
              print('Invalid choice!');
          }

          if (filterChoice == '4') {
            break;
          }
        }

        break;

case '5':
  print('');
  print('===== EXPORT MOVIES TO CSV =====');

  MovieService movieService = MovieService();

  await movieService.exportCsv();

  break;

      case '6':
        print('Goodbye!');
        return;

      default:
        print('Invalid choice!');
    }
  }
}