import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/presentation/journeys/favorite/favorite_screen.dart';
import 'package:movieapp/presentation/journeys/search_movie/search_movie_card.dart';
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

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  return Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      FractionallySizedBox(
                        alignment: Alignment.topCenter,
                        heightFactor: 0.6,
                        child: MovieCarouselWidget(
                          movies: state.movies,
                          defaultIndex: state.defaultIndex,
                        ),
                      ),
                      FractionallySizedBox(
                        alignment: Alignment.bottomCenter,
                        heightFactor: 0.4,
                        child: MovieTabbedWidget(),
                      ),
                    ],
                  );
                case 1:
                  return FavoriteScreen();
                case 2:
                  return SearchScreen();

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
}
