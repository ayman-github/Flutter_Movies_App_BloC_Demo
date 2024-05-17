import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_logic/cubit/movies_cubit.dart';
import 'env/strings.dart';
import 'data/models/movie_model.dart';
import 'data/repository/movies_repo.dart';
import 'data/services/movies_service.dart';
import 'presentations/screens/movie_screen.dart';
import 'presentations/screens/movies_screen.dart';

class AppRouter {
  late MoviesRepo moviesRepo;
  late MoviesCubit moviesCubit;

  AppRouter() {
    moviesRepo = MoviesRepo(moviesService: MoviesService());
    moviesCubit = MoviesCubit(moviesRepo);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case moviesScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => moviesCubit,
            child: MoviesScreen(),
          ),
        );

      case movieScreen:
        final movie = settings.arguments as Movie;
        return MaterialPageRoute(
          builder: (_) => MovieScreen(movie: movie),
        );
    }
  }
}
