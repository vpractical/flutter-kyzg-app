import 'package:flutter/material.dart';
import '../../const/const.dart' show AppThemes;
import '../../login.dart';
import '../../event/event.dart';

class Mine extends StatefulWidget {
  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<Mine> {
  List menuTitles = [
    null,
    '我的消息',
    '阅读记录',
    '我的博客',
    '我的问答',
    '我的活动',
    '我的团队',
    '邀请好友',
  ];
  List menuIcons = [
    null,
    Icons.message,
    Icons.print,
    Icons.error,
    Icons.phone,
    Icons.send,
    Icons.people,
    Icons.person,
  ];

  String userAvatar;
  String userName;

  @override
  void initState() {
    super.initState();
    _showUserInfo();
  }

  _showUserInfo() {}

  _login() async {
    final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
    if (result != null && result == 'refresh') {
      //登录成功
      eventBus.fire(LoginEvent());
    }
  }

  _menuSelect(context, index) {
    //...
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildHeader();
          }
          return GestureDetector(
            onTap: () {
              _menuSelect(context, index);
            },
            child: Container(
              height: 55,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Row(
                children: [
                  Icon(
                    menuIcons[index],
                    color: Colors.black54,
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      child: Text(
                        menuTitles[index],
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Icon(Icons.navigate_next, color: Colors.black54),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: index == 0 ? 0 : 1,
          );
        },
        itemCount: menuTitles.length);
  }

  _buildHeader() {
    return Container(
      height: 180,
      color: Color(AppThemes.PRIMARY_COLOR),
      child: GestureDetector(
        onTap: () {
          _login();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              image: AssetImage('assets/images/ic_avatar_default.png'),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '点击头像登陆',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
