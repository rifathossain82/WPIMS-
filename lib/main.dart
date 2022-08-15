import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wpims/pages/about/view/about.dart';
import 'package:wpims/pages/attendance/view/attendance.dart';
import 'package:wpims/pages/calender/view/calender.dart';
import 'package:wpims/pages/diary/view/diary.dart';
import 'package:wpims/pages/errors/view/401.dart';
import 'package:wpims/pages/errors/view/500.dart';
import 'package:wpims/pages/events/view/events.dart';
import 'package:wpims/pages/events/view/event_details.dart';
import 'package:wpims/pages/home/view/home.dart';
import 'package:wpims/pages/list.dart';
import 'package:wpims/pages/login/controller/auth_controller.dart';
import 'package:wpims/pages/login/view/login.dart';
import 'package:wpims/pages/notice/view/notice.dart';
import 'package:wpims/pages/notice/view/notice_details.dart';
import 'package:wpims/pages/notice/view/notice_list.dart';
import 'package:wpims/pages/otp/view/otp.dart';
import 'package:wpims/pages/payment/model/payment_model.dart';
import 'package:wpims/pages/payment/view/payment.dart';
import 'package:wpims/pages/payment/view/payment_history.dart';
import 'package:wpims/pages/profile/view/student_profile.dart';
import 'package:wpims/pages/profile/view/teacher_profile.dart';
import 'package:wpims/pages/result/view/marksheet.dart';
import 'package:wpims/pages/result/view/result.dart';
import 'package:wpims/pages/routine/view/routine.dart';
import 'package:wpims/pages/routine/view/routine_tabview.dart';
import 'package:wpims/pages/speech/view/chairman_speech.dart';
import 'package:wpims/pages/speech/view/principal_speech.dart';
import 'package:wpims/pages/splash/loading_splash.dart';
import 'package:wpims/pages/syllabus/view/syllabus.dart';
import 'package:wpims/pages/teachers/view/teacher_list.dart';
import 'package:wpims/utils/AppTheme.dart';
import 'package:wpims/utils/factory/faker.dart';

void main() async{
  await GetStorage.init();
  Get.put(AuthenticationManager());
  runApp(GetMaterialApp(
    home: Login(),
    // home:  Otp(userId: 'S1931',),
    theme: AppThemeData.lightTheme,
    darkTheme: AppThemeData.darkTheme,
  ));
}



