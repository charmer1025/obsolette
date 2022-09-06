import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_session/flutter_session.dart';

class Service {
  String apiUrl = 'https://obsolette.com/api';
  Future<Map<String, dynamic>> getKeywords(language) async {
    try {
      Map<String, dynamic> result = {};
      String uri = "$apiUrl/index.php?language=" + (language + 1).toString();
      var response = await http.get(
        Uri.parse(uri),
        headers: {
          "accept": "application/json",
          "cache-control": "no-cache",
          "content-type": "application/json"
        },
      );
      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        result = body;
      }
      return result;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getSearch(language) async {
    try {
      Map<String, dynamic> result = {};
      String uri = "$apiUrl/search.php?language=" + (language + 1).toString();
      var response = await http.get(
        Uri.parse(uri),
        headers: {
          "accept": "application/json",
          "cache-control": "no-cache",
          "content-type": "application/json"
        },
      );
      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        result = body;
      }
      return result;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getExperience(language) async {
    try {
      Map<String, dynamic> result = {};
      String uri =
          "$apiUrl/experience.php?language=" + (language + 1).toString();
      var response = await http.get(
        Uri.parse(uri),
        headers: {
          "accept": "application/json",
          "cache-control": "no-cache",
          "content-type": "application/json"
        },
      );
      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        result = body;
      }
      return result;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getStory(keyword, language) async {
    try {
      Map<String, dynamic> result = {};
      String uri = "$apiUrl/thesaurus.php?language=" +
          (language + 1).toString() +
          "&&thema=" +
          keyword;
      var response = await http.get(
        Uri.parse(uri),
        headers: {
          "accept": "application/json",
          "cache-control": "no-cache",
          "content-type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        result = body;
      }
      return result;
    } catch (err) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getFavourites() async {
    try {
      Map<String, dynamic> result = {};
      String email = await FlutterSession().get("email");
      // ignore: unnecessary_null_comparison
      if (email == null) email = "";
      String uri = "$apiUrl/get_favourites.php?email=" + email;
      var response = await http.get(
        Uri.parse(uri),
        headers: {
          "accept": "application/json",
          "cache-control": "no-cache",
          "content-type": "application/json"
        },
      );
      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        result = body;
      }
      return result;
    } catch (err) {
      rethrow;
    }
  }

  Future<String> setFavourite(storyNo) async {
    try {
      String result = "";
      String email = await FlutterSession().get("email");
      String uri = "$apiUrl/favourite.php?storyNo=" +
          storyNo.toString() +
          "&&email=" +
          email;
      var response = await http.get(
        Uri.parse(uri),
        headers: {
          "accept": "application/json",
          "cache-control": "no-cache",
          "content-type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        result = body["id"];
      }
      return result;
    } catch (err) {
      rethrow;
    }
  }

  Future<String> login(email, password) async {
    try {
      String result = "";
      await FlutterSession().set("email", email);
      String uri = "$apiUrl/login.php?email=" +
          email.toString() +
          "&&password=" +
          password;
      var response = await http.get(
        Uri.parse(uri),
        headers: {
          "accept": "application/json",
          "cache-control": "no-cache",
          "content-type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        result = body["result"];
        if (result == "success") {
          await FlutterSession().set("email", email);
        }
      }
      return result;
    } catch (err) {
      rethrow;
    }
  }

  Future<String> register(email, password) async {
    try {
      String result = "";
      await FlutterSession().set("email", email);
      String uri = "$apiUrl/register.php?email=" +
          email.toString() +
          "&&password=" +
          password;
      var response = await http.get(
        Uri.parse(uri),
        headers: {
          "accept": "application/json",
          "cache-control": "no-cache",
          "content-type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        result = body["result"];
      }
      return result;
    } catch (err) {
      rethrow;
    }
  }

  Future<String> removeFavourite(favouriteId) async {
    try {
      String result = "";
      String uri =
          "$apiUrl/remove_favourite.php?favouriteId=" + favouriteId.toString();
      var response = await http.get(
        Uri.parse(uri),
        headers: {
          "accept": "application/json",
          "cache-control": "no-cache",
          "content-type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        result = body["status"];
      }
      return result;
    } catch (err) {
      rethrow;
    }
  }

  Future<String> addComment(storyNo, comment, language) async {
    try {
      String email = await FlutterSession().get("email");
      String result = "";
      String uri = "$apiUrl/add_comment.php?storyNo=" +
          storyNo.toString() +
          "&comment=" +
          comment +
          "&email=" +
          email +
          "&language=" +
          (language + 1).toString();
      var response = await http.get(
        Uri.parse(uri),
        headers: {
          "accept": "application/json",
          "cache-control": "no-cache",
          "content-type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        result = body["status"];
      }
      return result;
    } catch (err) {
      rethrow;
    }
  }

  Future<String> closeAccount() async {
    try {
      String email = await FlutterSession().get("email");
      String result = "";
      String uri = "$apiUrl/close_account.php?email=" + email;
      var response = await http.get(
        Uri.parse(uri),
        headers: {
          "accept": "application/json",
          "cache-control": "no-cache",
          "content-type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        result = body["status"];
      }
      return result;
    } catch (err) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getDialog(storyNo, language) async {
    try {
      String email = await FlutterSession().get("email");
      Map<String, dynamic> result = {};
      String uri = "$apiUrl/dialog.php?language=" +
          (language + 1).toString() +
          "&&story=" +
          storyNo;
      // ignore: unnecessary_null_comparison
      if (email != null) {
        uri = uri + "&&email=" + email;
      }
      var response = await http.get(
        Uri.parse(uri),
        headers: {
          "accept": "application/json",
          "cache-control": "no-cache",
          "content-type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        result = body;
      }
      return result;
    } catch (err) {
      rethrow;
    }
  }
}
