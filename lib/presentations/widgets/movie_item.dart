import 'package:flutter/material.dart';
import '../../env/strings.dart';
import '../../styles/xcolors.dart';
import '../../data/models/movie_model.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  const MovieItem({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    String moviePoster = imageUrl + movie.posterPath;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () =>
            Navigator.pushNamed(context, movieScreen, arguments: movie),
        child: GridTile(
          footer: Container(
            decoration: BoxDecoration(
                color: XColor.xBlack,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                )),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.bottomCenter,
            child: Text(
              movie.title,
              style: const TextStyle(
                height: 1.3,
                fontSize: 16,
                color: XColor.xWhite,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          child: Hero(
            tag: movie.id!.toInt(),
            child: Container(
              child: movie.posterPath.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: FadeInImage.assetNetwork(
                        width: double.infinity,
                        height: double.infinity,
                        placeholder: 'assets/images/xloading.gif',
                        image: moviePoster,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset('assets/images/xbackground.png'),
            ),
          ),
        ),
      ),
    );
  }
}
