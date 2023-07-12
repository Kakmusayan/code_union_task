// main.dart

import 'package:code_union_task/lenta_page.dart';
import 'package:code_union_task/map_page.dart';
import 'package:code_union_task/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'favorites_page.dart';
import 'login_page.dart';
import 'login_view_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Code Union Task',
      theme: const CupertinoThemeData(
        primaryColor: Color(0XFF4631D2),
      ),
      initialRoute: LoginPage.routeName,
      routes: {
        LoginPage.routeName: (ctx) => const LoginPage(),
        ProfilePage.routeName: (ctx) => AppScreen(selectedIndex: 3),
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
  int selectedIndex;

  AppScreen({required this.selectedIndex, Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  List<String> pageTitles = ["Лента", "Карта", "Избранные", "Профиль"];

  final List<Widget> _pageList = const [
    LentaPage(),
    MapPage(),
    FavoritesPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
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
