import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wpims/pages/errors/view/404.dart';
import 'package:wpims/pages/login/view/login.dart';
import 'package:wpims/pages/profile/model/student_model.dart';
import 'package:wpims/utils/snackbars.dart';
import '../pages/login/controller/auth_controller.dart';
class ApiService {
  static String base_url='https://demo.webpointbd.com/api/';
  final AuthenticationManager authCtrl = Get.find<AuthenticationManager>();

  static var client = http.Client();
  Future get(String path) async {
    var url = Uri.parse(base_url+path);
    var headers={
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept':'application/json',
      'Authorization': 'Bearer '+authCtrl.auth_token.value,
    };

    try{
      final response = await http.get(url,headers: headers);
      if (response.statusCode == 200 || response.statusCode==204) {
        return response;
      }
      else if(response.statusCode==401){
        authCtrl.logOut();
        return Get.off(()=>Login());
      }
      else {
        return Get.to(()=>const Error404());
      }
    }catch(e){
      print(e);
    }
  }


  Future post(String path,Map data) async {
    var url = Uri.parse(base_url+path);
    var headers={
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept':'application/json',
      'Authorization': 'Bearer '+authCtrl.auth_token.value,
    };

    try{
      final response = await http.post(url,headers: headers,body: jsonEncode(data));
      if (response.statusCode == 200 || response.statusCode==422) {
        return response;
      }
      else if(response.statusCode==401){
        authCtrl.logOut();
        return Get.off(()=>Login());
      }
      else {
        Get.to(()=>const Error404());
      }
    }catch(e){
      print(e);
    }
  }


  static Future<StudentProfileApi> fetchStudentProfile() async {
    var response = await ApiService().get('student-profile');
      StudentProfileApi profileInstance = studentProfileFromJson(response.body);
      return profileInstance;
  }

}