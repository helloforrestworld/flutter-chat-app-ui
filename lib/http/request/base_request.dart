enum HttpMethod { GET, POST, DELETE }

abstract class BaseRequest {
  var pathParams;
  var useHttps = true;
  String authority() {
    return "api.devio.org";
  }

  HttpMethod httpMethod();

  String path();

  String url() {
    Uri uri;
    var pathStr = path();
    ///拼接path参数
    if (pathParams != null) {
      if (path().endsWith('/')) {
        pathStr = '${path()}$pathParams';
      } else {
        pathStr = '${path()}/$pathParams';
      }
    }
    ///http和https切换
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, pathParams);
    } else {
      uri = Uri.http(authority(), pathStr, pathParams);
    }
    print('url: ${uri.toString()}');
    return uri.toString();
  }

  bool needLogin();

  Map<String, dynamic> params = Map();

  ///添加参数
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, dynamic> header = Map();

  ///添加header
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}
