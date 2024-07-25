import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  //animal
  static Future<List<dynamic>?> getAnimal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _userToken = prefs.getString('UserToken');
    var url = Uri.https('pequod-api-dlyou.run.goorm.site', '/api/animal/animal');

    var response = await http.get(url, headers: {'Authorization': 'Token $_userToken'});

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Error: ${response.statusCode}, ${response.body}');
    }
  }

  static void postAnimal(String animal_name, String animal_type, String animal_deadline, String dead) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _userToken = prefs.getString('UserToken');

    var url = Uri.https(
        'pequod-api-dlyou.run.goorm.site', '/api/animal/animal/');
    var response = await http.post(url, headers: {
      'Authorization': 'Token $_userToken'
    }, body: {
      'animal_name': animal_name,
      'animal_type': animal_type,
      'animal_deadline': animal_deadline,
      'dead' : dead,
    });
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('Error: ${response.statusCode}');
      print('Error body: ${response.body}');
    }
  }

  static Future<void> patchDead() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _userToken = prefs.getString('UserToken');
    var url = Uri.https('pequod-api-dlyou.run.goorm.site', '/api/animal/animal/patch_last_animal_dead/');
    var response = await http.patch(url, headers: {
      'Authorization': 'Token $_userToken'
    }, body: {
      'dead' : 'true'
    });
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('Error: ${response.statusCode}');
      print('Error body: ${response.body}');
    }
  }

  //User
  static Future<Map<String, dynamic>?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('UserToken');
    var url = Uri.https('pequod-api-dlyou.run.goorm.site', '/api/user/me/');
    var response =
        await http.get(url, headers: {'Authorization': 'Token $userToken'});

    if (response.statusCode == 200) {
      Map<String, dynamic>? responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Error: ${response.statusCode}, ${response.body}');
    }
  }

  static Future<void> eraseUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('UserToken');
    if (userToken != null) {
      var url =
          Uri.https('pequod-api-dlyou.run.goorm.site', '/api/user/delete/');
      var response = await http.delete(
        url,
        headers: {'Authorization': 'Token $userToken'},
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
    String? userToken = prefs.getString('UserToken');
    if (userToken != null) {
      var url =
          Uri.https('pequod-api-dlyou.run.goorm.site', '/api/user/logout/');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Token $userToken'},
      );
      if (response.statusCode == 200) {
        prefs.remove('UserToken');
      } else {
        throw Exception('Error: ${response.statusCode}, ${response.body}');
      }
    }
  }

  static Future<void> patchAddPoints(int pointsToAdd) async {
    Map<String, dynamic>? userData;
    try {
      userData = await getUser();
    } catch (e) {
      print('Failed to fetch user data: $e');
      return;
    }

    if (userData != null) {
      int currentPoints = userData['points'] ?? 0;
      int updatedPoints = currentPoints + pointsToAdd;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userToken = prefs.getString('UserToken');
      var url = Uri.https('pequod-api-dlyou.run.goorm.site', '/api/user/me/');

      var response = await http.patch(url, headers: {
        'Authorization': 'Token $userToken'
      }, body: {'points': updatedPoints.toString()});

      if (response.statusCode == 200) {
        print('Points updated successfully!');
        print(response.body);
      } else {
        print('Error: ${response.statusCode}');
        print('Error body: ${response.body}');
      }
    } else {
      print('User data is null, cannot update points.');
    }
  }

  //Habit
  static Future<List<Habit>> getHabit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('UserToken');
    var url =
        Uri.https('pequod-api-dlyou.run.goorm.site', '/api/habit/habits/');
    var response =
        await http.get(url, headers: {'Authorization': 'Token $userToken'});

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));
      return responseData.map((json) => Habit.fromJson(json)).toList();
    } else {
      throw Exception('Error: ${response.statusCode}, ${response.body}');
    }
  }

  static Future<dynamic>? getHabitbyId(int inputId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('UserToken');
    var url = Uri.https(
        'pequod-api-dlyou.run.goorm.site', '/api/habit/habits/$inputId/');
    var response =
        await http.get(url, headers: {'Authorization': 'Token $userToken'});

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

  static void postHabit(String _name, String _date, String _completed,
      String _receive_point, String _receive_time, String _description) async {
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
    var url = Uri.https('pequod-api-dlyou.run.goorm.site',
        '/api/habit/habits/$_inputId/complete_habit/');
    var response = await http.patch(url, headers: {
      'Authorization': 'Token $_userToken'
    }, body: {});
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('Error: ${response.statusCode}');
      print('Error body: ${response.body}');
    }
  }

  static Future<void> patchHabit(
      int _inputId, String _inputName, String _inputDescription) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _userToken = prefs.getString('UserToken');
    var url = Uri.https(
        'pequod-api-dlyou.run.goorm.site', '/api/habit/habits/$_inputId/');
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

  //Habit Status
  static void postHabitStatus(String _habit_id, String _date, String _name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _userToken = prefs.getString('UserToken');

    var url = Uri.https(
        'pequod-api-dlyou.run.goorm.site', '/api/habitstatus/habitstatus/');
    var response = await http.post(url, headers: {
      'Authorization': 'Token $_userToken'
    }, body: {
      'habit': _habit_id,
      'habit_name': _name,
      'date': _date,
    });
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('Error: ${response.statusCode}');
      print('Error body: ${response.body}');
    }
  }

  static Future<List<dynamic>?> getTodayHabitStatus(String _date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _userToken = prefs.getString('UserToken');
    var url = Uri.https(
        'pequod-api-dlyou.run.goorm.site',
        '/api/habitstatus/habitstatus/habit_status_by_date/',
        {'date': _date}
    );

    var response = await http.get(url, headers: {'Authorization': 'Token $_userToken'});

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Error: ${response.statusCode}, ${response.body}');
    }
  }

  static Future<List<dynamic>?> getMonthlyHabitStatus(String _month) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _userToken = prefs.getString('UserToken');
    var url = Uri.https(
        'pequod-api-dlyou.run.goorm.site',
        '/api/habitstatus/habitstatus/habit_status_by_month/',
        {'month': _month}
    );
    var response = await http.get(url, headers: {'Authorization': 'Token $_userToken'});

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Error: ${response.statusCode}, ${response.body}');
    }
  }

  static Future<List<dynamic>?> getHabitStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _userToken = prefs.getString('UserToken');
    var url = Uri.https(
        'pequod-api-dlyou.run.goorm.site', '/api/habitstatus/habitstatus/',
    );

    var response = await http.get(url, headers: {'Authorization': 'Token $_userToken'});

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Error: ${response.statusCode}, ${response.body}');
    }
  }


  //Shop
  static Future<List<dynamic>?>? getShop() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _userToken = prefs.getString('UserToken');
    var url = Uri.https('pequod-api-dlyou.run.goorm.site', '/api/shop/shop/');
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

  static Future<void> patchShopBuyItem(int _inputId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _userToken = prefs.getString('UserToken');
    var url = Uri.https('pequod-api-dlyou.run.goorm.site',
        '/api/shop/shop/$_inputId/buy_item/');
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
}

class Habit {
  final int id;
  final String name;
  final String description;
  final bool completed;

  Habit({
    required this.id,
    required this.name,
    required this.description,
    required this.completed,
  });

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      completed: json['completed'],
    );
  }
}
