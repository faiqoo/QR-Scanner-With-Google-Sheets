import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:qr_scanner/network/g_sheet.dart';


class Http{

  UserData userData = UserData();
  List<UserData> dataList = [];
  Future fetchDataFromAPI() async {
    const String apiUrl = "https://api.example.com/data"; // Replace with your API URL

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {

        // If the server returns a 200 OK response, parse the JSON data
        final Map<String, dynamic> data = json.decode(response.body);

        //and handle your response here

            // dataList.add(value);

        return data;

      } else {

        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to fetch data from the API');
      }
    } catch (e) {

      // Handle any exceptions that occurred during the request
      print('Error: $e');
      throw e;
    }
  }
}

