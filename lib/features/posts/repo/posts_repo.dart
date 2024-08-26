import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../model/Post_Model.dart';

class PostsRepo {
  static Future<List<PostModel>> fetchPosts() async {
    var client = http.Client();

    try {
      var response = await client.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );

      //Parses the String Array and returns the resulting list of Json objects
      final List<dynamic> jsonArray = jsonDecode(response.body);

      // Replaced this:
      // for (int i = 0; i < dataList.length ; i++)
      //   {
      //     fetched_posts.add(PostModel.fromJson(dataList[i]));
      //   }

      return jsonArray.map((jsonItem) => PostModel.fromJson(jsonItem)).toList();
    } catch (e) {
      log(e.toString()); //logging error
      return [];
    } finally {
      client.close();
    }
  }

  static Future<bool> addPosts() async {
    var client = http.Client();

    try {
      var response = await client.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
// Hardcoding values:
        body: {
          "title": 'Associate Developer Maarij ',
          "body": 'Maarij is a Goof Flutter Developer',
          "userId": "1101",
        },
        // headers: {
        //   'Content-type': 'application/json; charset=UTF-8',
        // },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString()); //logging error
      return false;
    } finally {
      client.close();
    }
  }
}
