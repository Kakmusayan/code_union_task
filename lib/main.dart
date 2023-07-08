import 'package:code_union_task/favorites_page.dart';
import 'package:code_union_task/lenta_page.dart';
import 'package:code_union_task/map_page.dart';
import 'package:code_union_task/profile_page.dart';
import 'package:flutter/cupertino.dart';

import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Code Union Task',
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.systemPurple,
      ),
      initialRoute: LoginPage.routeName,
      routes: {
        LoginPage.routeName: (ctx) => const LoginPage(),
        ProfilePage.routeName: (ctx) => AppScreen(selectedIndex: 3),
      },
      onGenerateRoute: (settings) {
        if (settings.name == LoginPage.routeName) {
          return CupertinoPageRoute(
            builder: (context) => const LoginPage(),
          );
        }
        if (settings.name == ProfilePage.routeName) {
          return CupertinoPageRoute(
            builder: (context) => AppScreen(
              selectedIndex: 3,
            ),
          );
        }
        return null;
      },
      onUnknownRoute: (settings) {
        return CupertinoPageRoute(
          builder: (context) => const LoginPage(),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class AppScreen extends StatefulWidget {
  static const routeNameHomePage = '/home';
  int selectedIndex = 0;

  AppScreen({required this.selectedIndex, super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  String? currentPage;
  int? currentIndex;
  List<String> pageTitles = ["Лента", "Карта", "Избранные", "Профиль"];

  final List<Widget> _pageList = <Widget>[
    const LentaPage(),
    const MapPage(),
    const FavoritesPage(),
    const ProfilePage(),
  ];
  void _onItemTapped(int index) {
    return setState(() {
      widget.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: const Color(0XFF4631D2),
        onTap: _onItemTapped,
        currentIndex: widget.selectedIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset("assets/image/FirstTabElement.png"),
            label: 'Лента',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/image/SecondTabElement.png"),
            label: 'Карта',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/image/ThirdTabElement.png"),
            label: 'Избранные',
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset("assets/image/FourthTabElement.png"),
            icon: const Icon(CupertinoIcons.profile_circled),
            label: 'Профиль',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return CupertinoPageScaffold(
              backgroundColor: const Color(0XFFF3F4F6),
              navigationBar: CupertinoNavigationBar(
                backgroundColor: CupertinoTheme.of(context).barBackgroundColor,
                middle: FittedBox(
                  child: Text(
                    pageTitles[index],
                    style: const TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              child: _pageList[widget.selectedIndex],
            );
          },
        );
      },
    );
  }
}
