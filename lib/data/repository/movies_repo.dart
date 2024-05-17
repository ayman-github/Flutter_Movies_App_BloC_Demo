import 'dart:convert';
import '../models/movie_model.dart';
import '../services/movies_service.dart';

class MoviesRepo {
  final MoviesService moviesService;
  MoviesRepo({required this.moviesService});

  Future<List<Movie>> retrieveMovies() async {
    final response = await moviesService.fetchMovies();
    final movies = jsonDecode(response.body)['results'] as List<dynamic>;

    return movies.map((movie) {
      return Movie.fromJson(movie);
    }).toList();
  }
}
