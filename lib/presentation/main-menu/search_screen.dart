import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/presentation/blocs/movie_tabbed/movie_tabbed_cubit.dart';
import 'package:movieapp/presentation/blocs/search_movie/search_movie_cubit.dart';
import 'package:movieapp/presentation/blocs/theme/theme_cubit.dart';
import 'package:movieapp/presentation/main-menu/main_home_screen.dart';
import 'package:movieapp/presentation/journeys/home/movie_tabbed/movie_list_view_builder.dart';
import 'package:movieapp/presentation/journeys/home/movie_tabbed/movie_tabbed_constants.dart';
import 'package:movieapp/presentation/journeys/search_movie/custom_search_movie_delegate.dart';
import 'package:movieapp/presentation/themes/theme_color.dart';
import 'package:movieapp/presentation/widgets/movie_app_bar.dart';
import '../../common/constants/translation_constants.dart';
import '../../common/extensions/string_extensions.dart';
import '../../common/constants/size_constants.dart';
import '../../common/extensions/size_extensions.dart';
import '../blocs/search_movie/search_movie_cubit.dart';
import '../journeys/search_movie/custom_search_movie_delegate.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration.zero,
        () => showSearch(
              context: context,
              delegate: CustomSearchDelegate(
                BlocProvider.of<SearchMovieCubit>(context),
              ),
            ));
    return Container();
  }

  Widget buildRandomMovie() {
    return BlocBuilder<MovieTabbedCubit, MovieTabbedState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: Sizes.dimen_4.h),
          child: Column(
            children: <Widget>[
              if (state is MovieTabChanged)
               Expanded(
                        child: MovieListViewBuilder(movies: state.movies),
                      ),               
            ],
          ),
        );
      },
    );
    
  }
}
