import 'package:flutter/material.dart';
import 'const/const.dart' show AppThemes;
import 'view/news/news.dart';
import 'view/tweet/tweet.dart';
import 'view/find/find.dart';
import 'view/mine/mine.dart';
import 'view/drawer/left_drawer.dart';

void main() => runApp(
      MaterialApp(
        theme: ThemeData(
          primaryColor: Color(AppThemes.PRIMARY_COLOR),
          accentColor: Color(AppThemes.ACCENT_COLOR),
          backgroundColor: Color(AppThemes.BACKGROUND_COLOR),
        ),
        title: '主页',
        home: HomePage(),
      ),
    );

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex;
  PageController _pageController;

  var _pages = [
    News(),
    Tweet(),
    Find(),
    Mine(),
  ];

  var _bottomNavItems = [
    BottomNavItem('资讯', 'assets/images/ic_nav_news_normal.png', 'assets/images/ic_nav_news_actived.png'),
    BottomNavItem('动弹', 'assets/images/ic_nav_tweet_normal.png', 'assets/images/ic_nav_tweet_actived.png'),
    BottomNavItem(
        '发现', 'assets/images/ic_nav_discover_normal.png', 'assets/images/ic_nav_discover_actived.png'),
    BottomNavItem('我的', 'assets/images/ic_nav_my_normal.png', 'assets/images/ic_nav_my_pressed.png'),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = 1;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          _bottomNavItems[_currentIndex].title,
          style: TextStyle(color: Color(AppThemes.BACKGROUND_COLOR)),
        ),
        iconTheme: IconThemeData(color: Color(AppThemes.BACKGROUND_COLOR)),
      ),
      body: PageView.builder(
          controller: _pageController,
          itemCount: _pages.length,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          onPageChanged: (index) {
            _currentIndex = index;
            setState(() {});
          },
          itemBuilder: (context, index) {
            return _pages[index];
          }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _bottomNavItems.map((nav) => nav.item).toList(growable: false),
        selectedItemColor: Color(AppThemes.PRIMARY_COLOR),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          _currentIndex = index;
          _pageController.animateToPage(index, duration: Duration(milliseconds: 1), curve: Curves.ease);
          setState(() {});
        },
      ),
      drawer: LeftDrawer(),
    );
  }
}

class BottomNavItem {
  BottomNavigationBarItem item;
  String title;

  BottomNavItem(this.title, icon, activeIcon, {color = 0x9000d2dc}) {
    item = BottomNavigationBarItem(
      title: Text(
        title,
      ),
      icon: Image.asset(
        icon,
        width: 20,
        height: 20,
      ),
      activeIcon: Image.asset(
        activeIcon,
        width: 20,
        height: 20,
      ),
//      backgroundColor: Color(color),
    );
  }
}
