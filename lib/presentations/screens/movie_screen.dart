import 'package:flutter/material.dart';
import '../../env/strings.dart';
import '../../styles/xcolors.dart';
import '../../data/models/movie_model.dart';
import '../widgets/movie_details.dart';

class MovieScreen extends StatelessWidget {
  final Movie movie;
  const MovieScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: XColor.xBlack.withOpacity(0.8),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          _buildSliverList(),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    String moviePoster = imageUrl + movie.posterPath;

    return SliverAppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: BackButton(
          style: TextButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: XColor.xGrey,
            foregroundColor: XColor.xBlack,
          ),
        ),
      ),
      expandedHeight: 500,
      pinned: true,
      stretch: true,
      backgroundColor: XColor.xBlack,
      flexibleSpace: FlexibleSpaceBar(
        //centerTitle: true,
        title: Text(
          movie.title,
          style: const TextStyle(color: XColor.xWhite),
        ),
        background: Hero(
          tag: movie.id!.toInt(),
          child: Image.network(
            moviePoster,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MovieDetails(
                    title: 'Overview', description: movie.overview.toString()),
                MovieDetails(
                    title: 'Popularity',
                    description: movie.popularity.toString()),
                MovieDetails(
                    title: 'Release Date',
                    description: movie.releaseDate.toString()),
                MovieDetails(
                    title: 'Vote Average',
                    description: movie.voteAverage.toString()),
              ],
            ),
          ),
          const SizedBox(height: 500),
        ],
      ),
    );
  }
}
