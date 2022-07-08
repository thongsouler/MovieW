import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/presentation/blocs/search_movie/search_movie_cubit.dart';
import 'package:movieapp/presentation/blocs/theme/theme_cubit.dart';
import 'package:movieapp/presentation/journeys/home/home_screen.dart';
import 'package:movieapp/presentation/journeys/search_movie/custom_search_movie_delegate.dart';
import 'package:movieapp/presentation/themes/theme_color.dart';
import 'package:movieapp/presentation/widgets/movie_app_bar.dart';
import '../../common/constants/translation_constants.dart';
import '../../common/extensions/string_extensions.dart';
import '../../common/constants/size_constants.dart';
import '../../common/extensions/size_extensions.dart';
import '../blocs/search_movie/search_movie_cubit.dart';
import '../journeys/search_movie/custom_search_movie_delegate.dart';

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
}
