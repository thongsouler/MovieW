import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/presentation/journeys/drawer/navigation_expanded_list_item.dart';
import 'package:movieapp/presentation/journeys/drawer/navigation_list_item.dart';
import 'package:movieapp/presentation/widgets/separator.dart';
import '../blocs/theme/theme_cubit.dart';
import '../themes/theme_color.dart';
import 'package:wiredash/wiredash.dart';
import '../../common/constants/languages.dart';
import '../../common/constants/route_constants.dart';
import '../../common/constants/size_constants.dart';
import '../../common/constants/translation_constants.dart';
import '../../common/extensions/size_extensions.dart';
import '../../common/extensions/string_extensions.dart';
import '../blocs/language/language_cubit.dart';
import '../blocs/login/login_cubit.dart';
import '../widgets/app_dialog.dart';
import '../widgets/logo.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  final colorizeTextStyle = TextStyle(
    fontSize: 20.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: Sizes.dimen_8.h,
                        bottom: Sizes.dimen_8.h,
                        left: Sizes.dimen_8.w,
                        right: Sizes.dimen_8.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/pngs/menu-logo.png',
                            height: Sizes.dimen_20.h,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Logo(
                            height: Sizes.dimen_10.h,
                          ),
                        ],
                      ),
                    ),
                    customText(),
                    SizedBox(
                      height: 20,
                    ),
                    divider(),
                    NavigationListItem(
                      title: TranslationConstants.favoriteMovies.t(context),
                      onPressed: () {
                        Navigator.of(context).pushNamed(RouteList.favorite);
                      },
                    ),
                    NavigationExpandedListItem(
                      title: TranslationConstants.language.t(context),
                      children:
                          Languages.languages.map((e) => e.value).toList(),
                      onPressed: (index) => _onLanguageSelected(index, context),
                    ),
                    NavigationListItem(
                      title: TranslationConstants.feedback.t(context),
                      onPressed: () {
                        // Navigator.of(context).pop();
                        Wiredash.of(context)?.show();
                      },
                    ),
                    NavigationListItem(
                      title: TranslationConstants.about.t(context),
                      onPressed: () {
                        // Navigator.of(context).pop();
                        _showDialog(context);
                      },
                    ),
                    BlocBuilder<ThemeCubit, Themes>(builder: (context, theme) {
                      return Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: NavigationListItem(
                              title:
                                  TranslationConstants.changetheme.t(context),
                              onPressed: () {},
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: IconButton(
                                onPressed: () =>
                                    context.read<ThemeCubit>().toggleTheme(),
                                icon: Icon(
                                  theme == Themes.dark
                                      ? Icons.brightness_4_sharp
                                      : Icons.brightness_7_sharp,
                                  color: context.read<ThemeCubit>().state ==
                                          Themes.dark
                                      ? Colors.white
                                      : AppColor.vulcan,
                                  size: Sizes.dimen_32.w,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    BlocListener<LoginCubit, LoginState>(
                      listenWhen: (previous, current) =>
                          current is LogoutSuccess,
                      listener: (context, state) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            RouteList.initial, (route) => false);
                      },
                      child: NavigationListItem(
                        title: TranslationConstants.logout.t(context),
                        onPressed: () {
                          BlocProvider.of<LoginCubit>(context).logout();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onLanguageSelected(int index, BuildContext context) {
    BlocProvider.of<LanguageCubit>(context).toggleLanguage(
      Languages.languages[index],
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AppDialog(
        title: TranslationConstants.about,
        description: TranslationConstants.aboutDescription,
        buttonText: TranslationConstants.okay,
        image: Image.asset(
          'assets/pngs/tmdb_logo.png',
          height: Sizes.dimen_32.h,
        ),
      ),
    );
  }

  Widget customText() {
    return Container(
      alignment: Alignment.center,
      child: AnimatedTextKit(
        animatedTexts: [
          ColorizeAnimatedText(
            'Hello, have a good day !',
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          ),
        ],
        isRepeatingAnimation: true,
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        height: Sizes.dimen_1.h,
        width: double.infinity,
        padding: EdgeInsets.only(
          top: Sizes.dimen_2.h,
          bottom: Sizes.dimen_6.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_1.h)),
          gradient: LinearGradient(
            colors: [
              AppColor.violet,
              AppColor.royalBlue,
            ],
          ),
        ),
      ),
    );
  }
}
