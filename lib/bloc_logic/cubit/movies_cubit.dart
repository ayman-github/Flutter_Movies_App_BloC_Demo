import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/movie_model.dart';
import '../../data/repository/movies_repo.dart';

part 'Movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MoviesRepo moviesRepo;
  List<Movie> movies = [];

  MoviesCubit(this.moviesRepo) : super(MoviesInitial());

  List<Movie> getMovie() {
    moviesRepo.retrieveMovies().then((movies) {
      emit(MoviesLoaded(movies));
      this.movies = movies;
      print(movies.map((e) => e.popularity));
    });
    return movies;
  }
}
