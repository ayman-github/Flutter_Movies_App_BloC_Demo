class Movie {
  final int? id;
  final String title;
  final String? overview;
  final String posterPath;
  final double? popularity;
  final String? releaseDate;
  final double? voteAverage;
  final String? backdropPath;

  Movie({
    this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.popularity,
    required this.releaseDate,
    required this.voteAverage,
    required this.backdropPath,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      popularity: json['popularity'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'],
      backdropPath: json['backdrop_path'],
    );
  }
}
