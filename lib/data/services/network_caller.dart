import 'package:http/http.dart' as http;
import '../../secret/api_key.dart';

class NetworkCaller {
  static Future<http.Response> getRequest({required String url}) async {
    final http.Response response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": apiKey},
    );
    return response;
  }
}
