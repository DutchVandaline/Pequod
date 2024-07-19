import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  //User
  static Future<Map<String, dynamic>?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _userToken = prefs.getString('UserToken');
    var url = Uri.https('pequod-api-dlyou.run.goorm.site', '/api/user/me/');
    var response =
    await http.get(url, headers: {'Authorization': 'Token $_userToken'});

    if (response.statusCode == 200) {
      Map<String, dynamic>? responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Error: ${response.statusCode}, ${response.body}');
    }
  }

  static Future<void> EraseUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _userToken = prefs.getString('UserToken');
    if (_userToken != null) {
      var url = Uri.https('pequod-api-dlyou.run.goorm.site', '/api/user/delete/');
      var response = await http.delete(
        url,
        headers: {'Authorization': 'Token $_userToken'},
      );
      if (response.statusCode == 204) {
        prefs.remove('UserToken');
      } else {
        throw Exception('Error: ${response.statusCode}, ${response.body}');
      }
    }
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _userToken = prefs.getString('UserToken');
    if (_userToken != null) {
      var url = Uri.https('pequod-api-dlyou.run.goorm.site', '/api/user/logout/');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Token $_userToken'},
      );
      if (response.statusCode == 200) {
        prefs.remove('UserToken');
      } else {
        throw Exception('Error: ${response.statusCode}, ${response.body}');
      }
    }
  }

  //Habit
  static Future<List<dynamic>?>? getHabit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _userToken = prefs.getString('UserToken');
    var url =
        Uri.https('pequod-api-dlyou.run.goorm.site', '/api/habit/habits/');
    var response =
        await http.get(url, headers: {'Authorization': 'Token $_userToken'});

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      if (responseData.isNotEmpty) {
        return responseData;
      } else {
        return [];
      }
    } else {
      throw Exception('Error: ${response.statusCode}, ${response.body}');
    }
  }

  static Future<dynamic>? getHabitbyId(int inputId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _userToken = prefs.getString('UserToken');
    var url = Uri.https(
        'pequod-api-dlyou.run.goorm.site', '/api/habit/habits/$inputId/');
    var response =
        await http.get(url, headers: {'Authorization': 'Token $_userToken'});

    if (response.statusCode == 200) {
      dynamic responseData = json.decode(response.body);
      if (responseData.isNotEmpty) {
        return responseData;
      } else {
        return null;
      }
    } else {
      throw Exception('Error: ${response.statusCode}, ${response.body}');
    }
  }

  void postHabit(String _name, String _date, bool _completed, int _receive_point, String _receive_time, String _description) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _userToken = prefs.getString('UserToken');

    var url =
        Uri.https('pequod-api-dlyou.run.goorm.site', '/api/habit/habits/');
    var response = await http.post(url, headers: {
      'Authorization': 'Token $_userToken'
    }, body: {
      'name': '$_name',
      'date': _date,
      'completed': _completed,
      'receive_point': _receive_point,
      'receive_time': '$_receive_time',
      'description': '$_description',
    });
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('Error: ${response.statusCode}');
      print('Error body: ${response.body}');
    }
  }

  static Future<void> patchHabitCompleted(int _inputId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _userToken = prefs.getString('UserToken');
    var url = Uri.https('sogak-api-nraiv.run.goorm.site',
        '/api/habit/habits/$_inputId/complete_habit');
    var response = await http.patch(url, headers: {
      'Authorization': 'Token $_userToken'
    }, body: {
      "completed": 'true',
    });
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('Error: ${response.statusCode}');
      print('Error body: ${response.body}');
    }
  }

  static Future<void> patchHabit(int _inputId, String _inputName, String _inputDescription) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _userToken = prefs.getString('UserToken');
    var url = Uri.https(
        'sogak-api-nraiv.run.goorm.site', '/api/habit/habits/$_inputId/');
    var response = await http.patch(url, headers: {
      'Authorization': 'Token $_userToken'
    }, body: {
      "name": _inputName,
      "description": _inputDescription,
    });
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('Error: ${response.statusCode}');
      print('Error body: ${response.body}');
    }
  }

  static Future<void> deleteHabit(int inputId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _userToken = prefs.getString('UserToken');

    var url = Uri.https(
        'pequod-api-dlyou.run.goorm.site', '/api/habit/habits/$inputId/');
    var response =
        await http.delete(url, headers: {'Authorization': 'Token $_userToken'});
    if (response.statusCode == 200) {
      print("Data Deleted Successfully");
    } else {
      print('Error: ${response.statusCode}');
      print('Error body: ${response.body}');
    }
  }

  //Shop
  static Future<List<dynamic>?>? getShop() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _userToken = prefs.getString('UserToken');
    var url =
    Uri.https('pequod-api-dlyou.run.goorm.site', '/api/shop/shop/');
    var response =
    await http.get(url, headers: {'Authorization': 'Token $_userToken'});

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      if (responseData.isNotEmpty) {
        return responseData;
      } else {
        return [];
      }
    } else {
      throw Exception('Error: ${response.statusCode}, ${response.body}');
    }
  }

}
