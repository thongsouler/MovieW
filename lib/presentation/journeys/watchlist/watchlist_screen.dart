import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/presentation/blocs/watchlist/watchlist_cubit.dart';

import '../../../common/constants/translation_constants.dart';
import '../../../common/extensions/string_extensions.dart';
import '../../../di/get_it.dart';
import 'watchlist_movie_grid_view.dart';

class WatchlistScreen extends StatefulWidget {
  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  late WatchlistCubit _watchlistBloc;

  @override
  void initState() {
    super.initState();
    _watchlistBloc = getItInstance<WatchlistCubit>();
    _watchlistBloc.loadWatchlistMovie();
  }

  @override
  void dispose() {
    _watchlistBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TranslationConstants.watchlist.t(context),
        ),
      ),
      body: BlocProvider.value(
        value: _watchlistBloc,
        child: BlocBuilder<WatchlistCubit, WatchlistState>(
          builder: (context, state) {
            if (state is WatchlistMoviesLoaded) {
              if (state.movies.isEmpty) {
                return Center(
                  child: Text(
                    TranslationConstants.noFavoriteMovie.t(context),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                );
              }
              return WatchlistMovieGridView(
                movies: state.movies,
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
