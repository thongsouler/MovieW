import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/data/models/person.dart';
import 'package:movieapp/presentation/blocs/personbloc/person_bloc.dart';
import 'package:movieapp/presentation/blocs/personbloc/person_event.dart';
import 'package:movieapp/presentation/blocs/personbloc/person_state.dart';
import 'package:movieapp/presentation/journeys/favorite/favorite_screen.dart';
import 'package:movieapp/presentation/main-menu/category_screen.dart';
import 'package:movieapp/presentation/main-menu/profile_screen.dart';
import 'package:movieapp/presentation/widgets/separator.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../di/get_it.dart';
import '../blocs/movie_backdrop/movie_backdrop_cubit.dart';
import '../blocs/movie_carousel/movie_carousel_cubit.dart';
import '../blocs/movie_tabbed/movie_tabbed_cubit.dart';
import '../blocs/search_movie/search_movie_cubit.dart';
import '../widgets/app_error_widget.dart';
import '../journeys/drawer/navigation_drawer.dart';
import '../journeys/home/movie_carousel/movie_carousel_widget.dart';
import '../journeys/home/movie_tabbed/movie_tabbed_widget.dart';
import '../../common/extensions/size_extensions.dart';
import '../../common/extensions/string_extensions.dart';
import '../themes/theme_text.dart';

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
                          constraints:
                              BoxConstraints(minHeight: constraints.maxHeight),
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
                                  padding: EdgeInsets.zero,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 12,
                                      ),
                                      // BuildWidgetCategory(),
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          TranslationConstants.topperson
                                              .t(context)
                                              .toUpperCase(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .royalBlueSubtitle1,
                                        ),
                                      ),
                                      Center(child: Separator()),
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
                // return CheckOutPage();
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
      height: 170,
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
                    borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
                  ),
                  elevation: 3,
                  child: ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl: person.profilePath != ''
                          ? 'https://image.tmdb.org/t/p/w200${person.profilePath}'
                          : 'https://cdn-icons-png.flaticon.com/128/2748/2748583.png',
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          width: 100,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Sizes.dimen_16.w),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      placeholder: (context, url) => Container(
                        width: 100,
                        height: 120,
                        child: Center(
                          child: Platform.isAndroid
                              ? CircularProgressIndicator()
                              : CupertinoActivityIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 100,
                        height: 120,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/pngs/no-pictures.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text(
                      person.name.intelliTrim(),
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text(
                      person.knowForDepartment.toUpperCase(),
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 10,
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
