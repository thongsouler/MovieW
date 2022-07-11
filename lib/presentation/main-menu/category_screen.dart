import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/route_constants.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/data/models/genre_model.dart';
import 'package:movieapp/data/models/movieinfo_model.dart';
import 'package:movieapp/data/models/person.dart';
import 'package:movieapp/presentation/blocs/genrebloc/genre_bloc.dart';
import 'package:movieapp/presentation/blocs/genrebloc/genre_event.dart';
import 'package:movieapp/presentation/blocs/genrebloc/genre_state.dart';
import 'package:movieapp/presentation/blocs/moviebloc/movie_bloc.dart';
import 'package:movieapp/presentation/blocs/moviebloc/movie_bloc_event.dart';
import 'package:movieapp/presentation/blocs/moviebloc/movie_bloc_state.dart';
import 'package:movieapp/presentation/blocs/personbloc/person_bloc.dart';
import 'package:movieapp/presentation/blocs/personbloc/person_event.dart';
import 'package:movieapp/presentation/blocs/personbloc/person_state.dart';
import 'package:movieapp/presentation/blocs/search_movie/search_movie_cubit.dart';
import 'package:movieapp/presentation/blocs/theme/theme_cubit.dart';
import 'package:movieapp/presentation/journeys/movie_detail/movie_detail_arguments.dart';
import 'package:movieapp/presentation/journeys/movie_detail/movie_detail_screen.dart';
import 'package:movieapp/presentation/journeys/search_movie/custom_search_movie_delegate.dart';
import 'package:movieapp/presentation/themes/theme_color.dart';
import 'package:movieapp/presentation/widgets/movie_app_bar.dart';
import '../../common/constants/size_constants.dart';
import '../../common/extensions/size_extensions.dart';
import '../../common/extensions/string_extensions.dart';
import '../themes/theme_color.dart';
import '../themes/theme_text.dart';

class BuildWidgetCategory extends StatefulWidget {
  final int selectedGenre;

  const BuildWidgetCategory({Key? key, this.selectedGenre = 28})
      : super(key: key);

  @override
  BuildWidgetCategoryState createState() => BuildWidgetCategoryState();
}

class BuildWidgetCategoryState extends State<BuildWidgetCategory> {
  late int selectedGenre;

  @override
  void initState() {
    super.initState();
    selectedGenre = widget.selectedGenre;
  }

  @override
  Widget build(BuildContext conte) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GenreBloc>(
          create: (_) => GenreBloc()..add(GenreEventStarted()),
        ),
        BlocProvider<MovieBloc>(
          create: (_) => MovieBloc()..add(MovieEventStarted(selectedGenre, '')),
        ),
        // BlocProvider<PersonBloc>(
        //   create: (_) => PersonBloc()..add(PersonEventStated()),
        // )
      ],
      child: _buildGenre(context),
    );
  }

  Widget _buildGenre(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              TranslationConstants.search.t(context),
            ),
            builSearch()
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("GENRES",
                  style: Theme.of(context).textTheme.royalBlueSubtitle1),
            ),
            BlocBuilder<GenreBloc, GenreState>(
              builder: (context, state) {
                if (state is GenreLoading) {
                  return Center(
                    child: Platform.isAndroid
                        ? CircularProgressIndicator()
                        : CupertinoActivityIndicator(),
                  );
                } else if (state is GenreLoaded) {
                  List<TMDBGenre> genres = state.genreList;
                  return Container(
                    height: 45,
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          VerticalDivider(
                        color: Colors.transparent,
                        width: 5,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: genres.length,
                      itemBuilder: (context, index) {
                        TMDBGenre genre = genres[index];
                        return Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  TMDBGenre genre = genres[index];
                                  selectedGenre = genre.id;
                                  print("Selected Genre: " +
                                      selectedGenre.toString());
                                  // Thay doi list movie
                                  context.read<MovieBloc>().add(
                                      MovieEventStarted(selectedGenre, ''));
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColor.royalBlue,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    gradient: (genre.id == selectedGenre)
                                        ? LinearGradient(
                                            colors: [
                                              AppColor.violet,
                                              AppColor.royalBlue,
                                            ],
                                          )
                                        : LinearGradient(colors: [
                                            Colors.white60,
                                            Colors.white70
                                          ])
                                    // color: (genre.id == selectedGenre)
                                    //     ? AppColor.violet
                                    //     : Colors.white,
                                    ),
                                child: Text(
                                  genre.name.toUpperCase(),
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            // Container(
            //   child: Text(
            //     'new playing'.toUpperCase(),
            //     style: TextStyle(
            //       fontSize: 12,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.black45,
            //       fontFamily: 'muli',
            //     ),
            //   ),
            // ),

            SizedBox(
              height: 10,
            ),
            BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading) {
                  return Center();
                } else if (state is MovieLoaded) {
                  List<Movie> movieList = state.movieList;

                  return Container(
                    height: 300,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => VerticalDivider(
                        color: Colors.transparent,
                        width: 15,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: movieList.length,
                      itemBuilder: (context, index) {
                        Movie movie = movieList[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  RouteList.movieDetail,
                                  arguments: MovieDetailArguments(movie.id),
                                );
                              },
                              child: ClipRRect(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      width: 180,
                                      height: 250,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                  placeholder: (context, url) => Container(
                                    width: 180,
                                    height: 250,
                                    child: Center(
                                      child: Platform.isAndroid
                                          ? CircularProgressIndicator()
                                          : CupertinoActivityIndicator(),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    width: 180,
                                    height: 250,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/img_not_found.jpg'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 180,
                              child: Text(
                                movie.title,
                                style: Theme.of(context).textTheme.subtitle2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // Container(
                            //   child: Row(
                            //     children: <Widget>[
                            //       Icon(
                            //         Icons.star,
                            //         color: Colors.yellow,
                            //         size: 14,
                            //       ),
                            //       Icon(
                            //         Icons.star,
                            //         color: Colors.yellow,
                            //         size: 14,
                            //       ),
                            //       Icon(
                            //         Icons.star,
                            //         color: Colors.yellow,
                            //         size: 14,
                            //       ),
                            //       Icon(
                            //         Icons.star,
                            //         color: Colors.yellow,
                            //         size: 14,
                            //       ),
                            //       Icon(
                            //         Icons.star,
                            //         color: Colors.yellow,
                            //         size: 14,
                            //       ),
                            //       Text(
                            //         movie.voteAverage,
                            //         style: TextStyle(
                            //           color: Colors.black45,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 12),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       SizedBox(
            //         height: 12,
            //       ),
            //       // BuildWidgetCategory(),
            //       Text(
            //         'Trending persons on this week'.toUpperCase(),
            //         style: Theme.of(context).textTheme.royalBlueSubtitle1,
            //       ),
            //       SizedBox(
            //         height: 12,
            //       ),
            //       Column(
            //         children: <Widget>[
            //           BlocBuilder<PersonBloc, PersonState>(
            //             builder: (context, state) {
            //               if (state is PersonLoading) {
            //                 print("Loading Person ");
            //                 return Center();
            //               } else if (state is PersonLoaded) {
            //                 List<Person> personList = state.personList;
            //                 print(personList.length);
            //                 return Container(
            //                   height: 110,
            //                   child: ListView.separated(
            //                     scrollDirection: Axis.horizontal,
            //                     itemCount: personList.length,
            //                     separatorBuilder: (context, index) =>
            //                         VerticalDivider(
            //                       color: Colors.transparent,
            //                       width: 5,
            //                     ),
            //                     itemBuilder: (context, index) {
            //                       Person person = personList[index];
            //                       return Container(
            //                         child: Column(
            //                           children: <Widget>[
            //                             Card(
            //                               shape: RoundedRectangleBorder(
            //                                 borderRadius:
            //                                     BorderRadius.circular(100),
            //                               ),
            //                               elevation: 3,
            //                               child: ClipRRect(
            //                                 child: CachedNetworkImage(
            //                                   imageUrl:
            //                                       'https://image.tmdb.org/t/p/w200${person.profilePath}',
            //                                   imageBuilder:
            //                                       (context, imageProvider) {
            //                                     return Container(
            //                                       width: 80,
            //                                       height: 80,
            //                                       decoration: BoxDecoration(
            //                                         borderRadius:
            //                                             BorderRadius.all(
            //                                           Radius.circular(100),
            //                                         ),
            //                                         image: DecorationImage(
            //                                           image: imageProvider,
            //                                           fit: BoxFit.cover,
            //                                         ),
            //                                       ),
            //                                     );
            //                                   },
            //                                   placeholder: (context, url) =>
            //                                       Container(
            //                                     width: 80,
            //                                     height: 80,
            //                                     child: Center(
            //                                       child: Platform.isAndroid
            //                                           ? CircularProgressIndicator()
            //                                           : CupertinoActivityIndicator(),
            //                                     ),
            //                                   ),
            //                                   errorWidget:
            //                                       (context, url, error) =>
            //                                           Container(
            //                                     width: 80,
            //                                     height: 80,
            //                                     decoration: BoxDecoration(
            //                                       image: DecorationImage(
            //                                         image: AssetImage(
            //                                             'assets/images/img_not_found.jpg'),
            //                                       ),
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //                             Container(
            //                               child: Center(
            //                                 child: Text(
            //                                   person.name.toUpperCase(),
            //                                   style: TextStyle(
            //                                     color: Colors.black45,
            //                                     fontSize: 8,
            //                                     fontFamily: 'muli',
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //                             Container(
            //                               child: Center(
            //                                 child: Text(
            //                                   person.knowForDepartment
            //                                       .toUpperCase(),
            //                                   style: TextStyle(
            //                                     color: Colors.black45,
            //                                     fontSize: 8,
            //                                     fontFamily: 'muli',
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                       );
            //                     },
            //                   ),
            //                 );
            //               } else {
            //                 return Container();
            //               }
            //             },
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget builSearch() {
    return IconButton(
      onPressed: () {
        showSearch(
          context: context,
          delegate: CustomSearchDelegate(
            BlocProvider.of<SearchMovieCubit>(context),
          ),
        );
      },
      icon: Icon(
        Icons.search,
        color: context.read<ThemeCubit>().state == Themes.dark
            ? Colors.white
            : AppColor.vulcan,
        size: Sizes.dimen_12.h,
      ),
    );
  }
}
