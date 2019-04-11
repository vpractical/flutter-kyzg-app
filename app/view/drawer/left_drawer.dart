import 'package:flutter/material.dart';
import '../tweet/pub.dart';
import '../tweet/black_list.dart';
import '../mine/about.dart';
import '../mine/setting.dart';

class LeftDrawer extends StatefulWidget {
  @override
  _LeftDrawerState createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  var _headBackground = 'assets/images/cover_img.jpg';
  var _icons = [null, Icons.send, Icons.home, Icons.error, Icons.settings];
  var _titles = [null, '发布动弹', '动弹小黑屋', '关于', '设置'];

  @override
  Widget build(BuildContext context) {
    return Drawer(
        elevation: 0,
        child: ListView.separated(
          padding: const EdgeInsets.all(0.0), //解决状态栏问题
          itemBuilder: (context, index) {
            if (index == 0) {
              return Image.asset(
                _headBackground,
                fit: BoxFit.cover,
              );
            }
            return ListTile(
              leading: Icon(_icons[index]),
              title: Text(_titles[index]),
              trailing: Icon(Icons.navigate_next),
              onTap: () {
                _menuSelected(context, index);
              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: index == 0 ? 0 : 1,
            );
          },
          itemCount: _icons.length,
        ));
  }

  _menuSelected(BuildContext context, int index) {
    switch (index) {
      case 1:
        _navPush(context, Pub());
        break;
      case 2:
        _navPush(context, BlackList());
        break;
      case 3:
        _navPush(context, About());
        break;
      case 4:
        _navPush(context, Setting());
        break;
    }
  }

  _navPush(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }
}
