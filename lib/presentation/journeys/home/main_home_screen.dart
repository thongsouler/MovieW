import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/data/models/person.dart';
import 'package:movieapp/presentation/blocs/personbloc/person_bloc.dart';
import 'package:movieapp/presentation/blocs/personbloc/person_event.dart';
import 'package:movieapp/presentation/blocs/personbloc/person_state.dart';
import 'package:movieapp/presentation/journeys/favorite/favorite_screen.dart';
import 'package:movieapp/presentation/journeys/search_movie/search_movie_card.dart';
import 'package:movieapp/presentation/main-menu/category_screen.dart';
import 'package:movieapp/presentation/main-menu/profile_screen.dart';
import 'package:movieapp/presentation/main-menu/search_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../di/get_it.dart';
import '../../blocs/movie_backdrop/movie_backdrop_cubit.dart';
import '../../blocs/movie_carousel/movie_carousel_cubit.dart';
import '../../blocs/movie_tabbed/movie_tabbed_cubit.dart';
import '../../blocs/search_movie/search_movie_cubit.dart';
import '../../widgets/app_error_widget.dart';
import '../drawer/navigation_drawer.dart';
import 'movie_carousel/movie_carousel_widget.dart';
import 'movie_tabbed/movie_tabbed_widget.dart';
import '../../../common/extensions/size_extensions.dart';
import '../../themes/theme_text.dart';

class MainHomeScreen extends StatefulWidget {
  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  late MovieCarouselCubit movieCarouselCubit;
  late MovieBackdropCubit movieBackdropCubit;
  late MovieTabbedCubit movieTabbedCubit;
  late SearchMovieCubit searchMovieCubit;
  var _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    movieCarouselCubit = getItInstance<MovieCarouselCubit>();
    movieBackdropCubit = movieCarouselCubit.movieBackdropCubit;
    movieTabbedCubit = getItInstance<MovieTabbedCubit>();
    searchMovieCubit = getItInstance<SearchMovieCubit>();
    movieCarouselCubit.loadCarousel();
  }

  @override
  void dispose() {
    super.dispose();
    movieCarouselCubit.close();
    movieBackdropCubit.close();
    movieTabbedCubit.close();
    searchMovieCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => movieCarouselCubit,
        ),
        BlocProvider(
          create: (context) => movieBackdropCubit,
        ),
        BlocProvider(
          create: (context) => movieTabbedCubit,
        ),
        BlocProvider.value(
          value: searchMovieCubit,
        ),
        //Person Bloc
        BlocProvider<PersonBloc>(
          create: (_) => PersonBloc()..add(PersonEventStated()),
        )
      ],
      child: Scaffold(
        drawer: const NavigationDrawer(),
        bottomNavigationBar: SalomonBottomBar(
            currentIndex: _currentIndex,
            onTap: (i) => setState(() => _currentIndex = i),
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: Icon(Icons.home),
                title: Text("Home"),
                selectedColor: Colors.purple,
              ),

              /// Likes
              SalomonBottomBarItem(
                icon: Icon(Icons.favorite_border),
                title: Text("Likes"),
                selectedColor: Colors.pink,
              ),

              /// Search
              SalomonBottomBarItem(
                icon: Icon(Icons.search),
                title: Text("Search"),
                selectedColor: Colors.orange,
              ),

              /// Profile
              SalomonBottomBarItem(
                icon: Icon(Icons.person),
                title: Text("Profile"),
                selectedColor: Colors.teal,
              ),
            ]),
        body: BlocBuilder<MovieCarouselCubit, MovieCarouselState>(
          builder: (context, state) {
            if (state is MovieCarouselLoaded) {
              switch (_currentIndex) {
                case 0:
                  return Stack(fit: StackFit.expand, children: [
                    LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: constraints.maxHeight - 150),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // FractionallySizedBox(
                                //   alignment: Alignment.topCenter,
                                //   // heightFactor: 0.7,
                                //   child: MovieCarouselWidget(
                                //     movies: state.movies,
                                //     defaultIndex: state.defaultIndex,
                                //   ),
                                // ),
                                // FractionallySizedBox(
                                //   alignment: Alignment.bottomCenter,
                                //   // heightFactor: 0.35,
                                //   child: MovieTabbedWidget(),
                                // ),

                                Container(
                                  height: constraints.maxHeight * 0.7,
                                  child: MovieCarouselWidget(
                                    movies: state.movies,
                                    defaultIndex: state.defaultIndex,
                                  ),
                                ),
                                Container(
                                    height: constraints.maxHeight * 0.4,
                                    child: MovieTabbedWidget()),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 12,
                                      ),
                                      // BuildWidgetCategory(),
                                      Text(
                                        'Trending persons on this week'
                                            .toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .royalBlueSubtitle1,
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Column(
                                        children: <Widget>[
                                          BlocBuilder<PersonBloc, PersonState>(
                                            builder: (context, state) {
                                              if (state is PersonLoading) {
                                                print("Loading Person ");
                                                return Center();
                                              } else if (state
                                                  is PersonLoaded) {
                                                List<Person> personList =
                                                    state.personList;
                                                print(personList.length);
                                                return buildTrendingPersonRow(
                                                    personList);
                                              } else {
                                                return Container();
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text("WOWWWW"),
                              ]),
                        ),
                      );
                    }),
                  ]);

                // return Stack(
                //   fit: StackFit.expand,
                //   children: <Widget>[
                //     FractionallySizedBox(
                //       alignment: Alignment.topCenter,
                //       heightFactor: 0.7,
                //       child: MovieCarouselWidget(
                //         movies: state.movies,
                //         defaultIndex: state.defaultIndex,
                //       ),
                //     ),
                //     FractionallySizedBox(
                //       alignment: Alignment.bottomCenter,
                //       heightFactor: 0.35,
                //       child: MovieTabbedWidget(),
                //     ),
                //   ],
                // );
                case 1:
                  return FavoriteScreen();
                case 2:
                  // return SearchScreen();
                  return BuildWidgetCategory();

                case 3:
                  return ProfileScreen();

                default:
              }
            } else if (state is MovieCarouselError) {
              return AppErrorWidget(
                onPressed: () => movieCarouselCubit.loadCarousel(),
                errorType: state.errorType,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget buildTrendingPersonRow(List<Person> personList) {
    return Container(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: personList.length,
        separatorBuilder: (context, index) => VerticalDivider(
          color: Colors.transparent,
          width: 5,
        ),
        itemBuilder: (context, index) {
          Person person = personList[index];
          return Container(
            child: Column(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  elevation: 3,
                  child: ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/w200${person.profilePath}',
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      placeholder: (context, url) => Container(
                        width: 80,
                        height: 80,
                        child: Center(
                          child: Platform.isAndroid
                              ? CircularProgressIndicator()
                              : CupertinoActivityIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/pngs/img_not_found.jpg'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text(
                      person.name.toUpperCase(),
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 8,
                        fontFamily: 'muli',
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text(
                      person.knowForDepartment.toUpperCase(),
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 8,
                        fontFamily: 'muli',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
