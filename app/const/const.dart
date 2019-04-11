class AppThemes {
  static const int PRIMARY_COLOR = 0xff63ca6c;
  static const int ACCENT_COLOR = 0xFF888888;
  static const int BACKGROUND_COLOR = 0xFFFFFFEF;
}

class AppConfig {
  static const String APP_ID = '6i4Yu6IUqXnR64em0rsJ'; //应用id
  static const String APP_SECRET = 'Pb9t3prZqBYDeB9DjTvmCzGLu7EFJyt9'; //应用密钥
  static const String REDIRECT_URI = 'https://www.dongnaoedu.com/'; //回调地址
}

class AppUrls {
  static const String HOST = 'https://www.oschina.net';
  //授权登录
  static const String OAUTH2_AUTHORIZE = HOST + '/action/oauth2/authorize';
  //获取token
  static const String OAUTH2_TOKEN = HOST + '/action/openapi/token';
}
