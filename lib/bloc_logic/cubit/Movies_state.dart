part of 'movies_cubit.dart';

@immutable
sealed class MoviesState {}

final class MoviesInitial extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<Movie> movies;

  MoviesLoaded(this.movies);
}
