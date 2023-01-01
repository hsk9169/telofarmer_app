class HttpParser {
  String getAccessToken(Map<String, String> headers) {
    final String keyString = 'access-token=';
    final String cookie = headers['set-cookie']!;
    final accessToken = cookie.split(';')[0].substring(keyString.length);
    return accessToken;
  }
}
