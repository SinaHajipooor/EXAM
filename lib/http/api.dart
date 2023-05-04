class Api {
  static const _baseUrl = 'http://192.168.1.109/api/otp';

  static const _loginEndpoint = '/login';
  static const _confirmEndpoint = '/confirm';

  static final Api _instance = Api._();
  static Api get instance => _instance;

  String get baseUrl => _baseUrl;
  String get loginUrl => '$_baseUrl$_loginEndpoint';
  String get confirmUrl => '$_baseUrl$_confirmEndpoint';
  Api._();
}
