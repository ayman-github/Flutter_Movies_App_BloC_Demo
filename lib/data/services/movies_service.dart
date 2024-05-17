import 'package:http/http.dart' as http;
import '../../env/strings.dart';

class MoviesService {
  final String url = baseUrl + apiKey;

  Future<dynamic> fetchMovies() async {
    try {
      final response = await http.get(Uri.parse(url));

      return response;
    } catch (e) {
      print('Failed to load Movies' + e.toString());
    }
  }
}
