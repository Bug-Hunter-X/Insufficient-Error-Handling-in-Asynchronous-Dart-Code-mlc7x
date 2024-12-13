```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://api.example.com/data'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // Provide more specific error messages for better debugging and user feedback
      throw Exception('API request failed with status: ${response.statusCode} and message: ${response.body}');
    }
  } on http.ClientException catch (e) {
    // Handle network errors separately
    print('Network error: $e');
    throw Exception('Network error: Could not connect to the server');
  } on FormatException catch (e) {
    // Handle JSON decoding errors
    print('JSON decoding error: $e');
    throw Exception('Invalid JSON response from the server');
  } catch (e) {
    print('An unexpected error occurred: $e');
    rethrow; //Rethrow to be handled at a higher level if needed
  }
}
```