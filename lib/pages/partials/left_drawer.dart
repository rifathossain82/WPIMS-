import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:wpims/pages/about/view/about.dart';
import 'package:wpims/pages/calender/view/calender.dart';
import 'package:wpims/pages/home/view/home.dart';
import 'package:wpims/pages/payment/view/payment_history.dart';
import 'package:wpims/pages/profile/view/student_profile.dart';
import 'package:wpims/pages/profile/view/teacher_profile.dart';
import 'package:wpims/pages/speech/view/chairman_speech.dart';
import 'package:wpims/pages/speech/view/principal_speech.dart';
import 'package:wpims/pages/teachers/view/teacher_list.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/factory/faker.dart';
import 'package:wpims/utils/shapes/left_drawer_shape.dart';
import 'package:wpims/utils/widgets/helper.dart';

Widget leftDrawer(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(right: 40.0),
    child: ClipPath(
      clipper: LDOvalRightBorderClipper(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Drawer(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 30.0),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    child: Container(
                      margin: EdgeInsets.only(right: 25),
                      child: Center(
                        child: Image.asset('assets/images/logo.png')
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.home,
                      color: colorPrimary,
                    ),
                    title: const Text(
                      'Home',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(()=>Home());
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      Icons.school,
                      color: colorPrimary,
                    ),
                    title: const Text(
                      'About School',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(()=>About());
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      Icons.format_quote_outlined,
                      color: colorPrimary,
                    ),
                    title: const Text(
                      'Chairman Message',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(()=>ChairmanSpeech());

                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      Icons.format_quote,
                      color: colorPrimary,
                    ),
                    title: const Text(
                      'Principal Message',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(()=>PrincipalSpeech());

                    },
                  ),
                  const Divider(),

                  ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: colorPrimary,
                    ),
                    title: const Text(
                      'Student\'s Profile',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(()=>StudentProfile());

                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      Icons.payments,
                      color: colorPrimary,
                    ),
                    title: const Text(
                      'Payment History',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(()=>PaymentHistory());

                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      Icons.verified_user,
                      color: colorPrimary,
                    ),
                    title: const Text(
                      'Teacher\'s List',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(()=>TeacherList());

                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      Icons.calendar_month,
                      color: colorPrimary,
                    ),
                    title: const Text(
                      'Academic Calendar',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(()=>Calendar());

                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: colorPrimary,
                    ),
                    title: const Text(
                      'Logout',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  addVerticalSpace(50),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
                left: 0,
                right: 0,
                child: Container(
              margin: const EdgeInsets.only(right: 25),
              padding: EdgeInsets.all(8.0),
              child: const Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Powered by WebPoint Ltd',
                  style: TextStyle(color: colorPrimary),
                ),
              ),
            ))
          ],
        ),
      ),
    ),
  );
}


