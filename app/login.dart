import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'const/const.dart' show AppConfig, AppUrls;
import 'utils/net_utils.dart';
import 'utils/data_utils.dart';
import 'package:flutter/cupertino.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FlutterWebviewPlugin _webViewPlugin = FlutterWebviewPlugin();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _webViewPlugin.onUrlChanged.listen(
      (url) {
        print('url访问');
        if (mounted) {
          loading = false;
          setState(() {});
        }
        if (url != null && url.length > 0 && url.contains('?code=')) {
          //登录成功了
          //提取授权码code
          String code = url.split('?')[1].split('&')[0].split('=')[1];
          Map<String, dynamic> params = Map<String, dynamic>();
          params['client_id'] = AppConfig.APP_ID;
          params['client_secret'] = AppConfig.APP_SECRET;
          params['grant_type'] = 'authorization_code';
          params['redirect_uri'] = AppConfig.REDIRECT_URI;
          params['code'] = '$code';
          params['dataType'] = 'json';
          NetUtils.get(AppUrls.OAUTH2_TOKEN, params).then((data) {
            print('$data');
            if (data != null) {
              Map<String, dynamic> map = json.decode(data);
              if (map != null && map.isNotEmpty) {
                //保存token等信息
                DataUtils.saveLoginInfo(map);
                //弹出当前路由，并返回refresh通知我的界面刷新数据
                Navigator.pop(context, 'refresh');
              }
            }
          });
        }
      }, /*onError: () {
      print('url访问错误');
    }, onDone: () {
      print('url访问完毕');
    }*/
    );
  }

  @override
  void dispose() {
    super.dispose();
    _webViewPlugin.close();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _appBarWidgets = [
      Text(
        '登录',
        style: TextStyle(color: Colors.white),
      ),
    ];

    if (loading) {
      _appBarWidgets.add(SizedBox(
        width: 10.0,
      ));
      _appBarWidgets.add(CupertinoActivityIndicator());
    }

    return WebviewScaffold(
      url: AppUrls.OAUTH2_AUTHORIZE +
          '?response_type=code&client_id=' +
          AppConfig.APP_ID +
          '&redirect_uri=' +
          AppConfig.REDIRECT_URI,
      appBar: AppBar(
        title: Row(
          children: _appBarWidgets,
        ),
      ),
      withJavascript: true,
      //允许执行js
      withLocalStorage: true,
      //允许本地存储
      withZoom: true, //允许网页缩放
    );
  }
}
