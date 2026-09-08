class Movie {
  int id;
  String name;
  String genre;
  int year;
  String director;
  List<String> actors;
  double rating;

  Movie({
    required this.id,
    required this.name,
    required this.genre,
    required this.year,
    required this.director,
    required this.actors,
    required this.rating,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'genre': genre,
      'year': year,
      'director': director,
      'actors': actors,
      'rating': rating,
    };
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      name: json['name'],
      genre: json['genre'],
      year: json['year'],
      director: json['director'],
      actors: List<String>.from(json['actors']),
      rating: json['rating'].toDouble(),
    );
  }
}
