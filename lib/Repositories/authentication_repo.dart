import 'dart:convert';

import 'package:cash_rocket/Model/sign_in_model.dart';
import 'package:cash_rocket/Model/user_profile_model.dart';
import 'package:cash_rocket/Provider/database_provider.dart';
import 'package:cash_rocket/Screen/Constant%20Data/config.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  Future<SignInModel> signInWithEmail(String email, String password) async {
    Uri url = Uri.parse(Config.serverUrl + Config.signInUrl);
    var response = await http.post(url, body: <String, dynamic>{'email': email, 'password': password});
    print(response.statusCode);
    if (response.statusCode == 200) {
      return SignInModel.fromJson(jsonDecode(response.body));
    } else {
      var data = jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  Future<bool> resetPasswordWithEmail(String email) async {
    Uri url = Uri.parse(Config.serverUrl + Config.forgotPasswordUrl);
    var response = await http.post(url, body: <String, dynamic>{'email': email});
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Email doesn\'t exist');
    }
  }

  Future<bool> verifyOtp(String code) async {
    Uri url = Uri.parse(Config.serverUrl + Config.verifyOtpUrl);
    var response = await http.post(url, body: <String, dynamic>{'code': code});
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Wrong OTP');
    }
  }

  Future<bool> resetPassword(String code, String password) async {
    Uri url = Uri.parse(Config.serverUrl + Config.resetPasswordUrl);
    var response = await http.post(url, body: <String, dynamic>{'code': code, 'password': password, 'password_confirmation': password});
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Password reset failed');
    }
  }

  Future<bool> updatePassword(String password) async {
    String? token = await DataBase().retrieveString('token');
    Uri url = Uri.parse(Config.serverUrl + Config.editPasswordUrl);
    var response = await http.post(url, headers: {'Authorization': 'Bearer $token'}, body: <String, dynamic>{'password': password});
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Password Update Failed');
    }
  }

  Future<bool> updateToken() async {
    bool ret = false;
    String? token = await DataBase().retrieveString('token');
    Uri url = Uri.parse(Config.serverUrl + Config.refreshTokenUrl);
    var response = await http.post(url, headers: {'Authorization': 'Bearer $token'});

    try {
      if (response.statusCode == 200) {
        DataBase().saveString(SignInModel.fromJson(jsonDecode(response.body)).data?.token ?? '', 'token');
        ret = true;
      } else {
        // throw Exception('Token Update Failed');
      }
    } catch (e) {}
    return ret;
  }

  Future<bool> dailyRewards() async {
    String? token = await DataBase().retrieveString('token');
    Uri url = Uri.parse(Config.serverUrl + Config.dailyRewardUrl);

    var response = await http.post(url, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 406) {
      throw Exception('Already Rewarded. Please Try Again Tomorrow');
    } else {
      throw Exception('Daily Reward Update Failed');
    }
  }

  Future<UserProfileModel> userProfileInfo() async {
    Uri url = Uri.parse(Config.serverUrl + Config.userProfileUrl);
    String? token = await DataBase().retrieveString('token');
    print(token);
    var response = await http.get(url, headers: {'Authorization': 'Bearer $token'});
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return UserProfileModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Authorization Failed');
    }
  }

  Future<bool> signUpWithEmail(String fullName, String mobile, String email, String refer, String password, dynamic filepath) async {
    Map<String, String> body = {
      'name': fullName,
      'email': email,
      'phone': mobile,
      'password': password,
      'refer': refer,
    };
    Uri url = Uri.parse(Config.serverUrl + Config.signUpUrl);
    http.MultipartRequest request;
    if (filepath != 'No Data') {
      request = http.MultipartRequest('POST', url);
      request.files.add(await http.MultipartFile.fromPath('image', filepath));
      request.fields.addAll(body);
    } else {
      request = http.MultipartRequest('POST', url);
      request.fields.addAll(body);
    }
    return await request.send().then((response) async {
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('User Already Exist');
      }
    });
  }

  Future<bool> editProfile(String fullName, String mobile, String email, dynamic filepath) async {
    Map<String, String> body = {
      'name': fullName,
      'email': email,
      'phone': mobile,
    };
    String? token = await DataBase().retrieveString('token');
    Map<String, String> header = {'Authorization': 'Bearer $token'};
    Uri url = Uri.parse(Config.serverUrl + Config.editProfileUrl);
    http.MultipartRequest request;
    if (filepath != 'No Data') {
      request = http.MultipartRequest('POST', url);
      request.files.add(await http.MultipartFile.fromPath('image', filepath));
      request.headers.addAll(header);
      request.fields.addAll(body);
    } else {
      request = http.MultipartRequest('POST', url);
      request.headers.addAll(header);
      request.fields.addAll(body);
    }
    return await request.send().then((response) async {
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Error While Editing Profile');
      }
    });
  }

  Future<bool> logOut() async {
    Uri url = Uri.parse(Config.serverUrl + Config.signOutUrl);
    String? token = await DataBase().retrieveString('token');
    var response = await http.get(url, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Error while logging out');
    }
  }
}
