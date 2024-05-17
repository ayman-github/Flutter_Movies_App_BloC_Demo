import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../bloc_logic/cubit/movies_cubit.dart';
import '../../styles/xcolors.dart';
import '../../data/models/movie_model.dart';
import '../widgets/movie_item.dart';
import '../widgets/offline.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});
  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late List<Movie> moviesList;
  late List<Movie> searchList;

  bool isSearch = false;
  final searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviesCubit>(context).getMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: XColor.xPink,
        title: _appBarTitle(),
        leading: isSearch
            ? const BackButton(
                color: XColor.xGrey,
              )
            : Container(),
        actions: _buildSearchBarActions(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;

          if (connected) {
            return moviesBodyWidget();
          } else {
            return const Offline();
          }
        },
        child: const CircularProgressIndicator(
          color: XColor.xPink,
        ),
      ),
    );
  }

  Widget moviesBodyWidget() {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        if (state is MoviesLoaded) {
          moviesList = (state).movies;
          return _buildGridWidget();
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: XColor.xPink,
            ),
          );
        }
      },
    );
  }

  Widget _buildGridWidget() {
    return SingleChildScrollView(
      child: Container(
        color: XColor.xGrey,
        child: Column(
          children: [
            _buildMoviesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMoviesList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: searchTextController.text.isEmpty
            ? moviesList.length
            : searchList.length,
        itemBuilder: (ctx, index) {
          return MovieItem(
            movie: searchTextController.text.isEmpty
                ? moviesList[index]
                : searchList[index],
          );
        });
  }

  //* searching ===============================================================

  Widget _appBarTitle() {
    if (!isSearch) {
      return const Text('Movies', style: TextStyle(color: XColor.xGrey));
    } else {
      return _buildSearchField();
    }
  }

  Widget _buildSearchField() {
    return TextField(
      controller: searchTextController,
      cursorColor: XColor.xGrey,
      decoration: const InputDecoration(
        hintText: 'Search movies',
        border: InputBorder.none,
        hintStyle: TextStyle(color: XColor.xGrey, fontSize: 18),
      ),
      style: const TextStyle(color: XColor.xGrey, fontSize: 18),
      onChanged: (searchedItem) {
        searchList = moviesList
            .where((movie) => movie.title.toLowerCase().contains(searchedItem))
            .toList();
        setState(() {});
      },
    );
  }

  List<Widget> _buildSearchBarActions() {
    if (isSearch) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear, color: XColor.xGrey),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(
            Icons.search,
            color: XColor.xGrey,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      isSearch = true;
    });
  }

  void _stopSearching() {
    _clearSearch();

    setState(() {
      isSearch = false;
    });
  }

  void _clearSearch() {
    setState(() {
      searchTextController.clear();
    });
  }
}
