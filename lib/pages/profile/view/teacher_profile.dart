import 'package:flutter/material.dart';
import 'package:wpims/pages/partials/top_bar.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/constants/fonts.dart';
import 'package:wpims/utils/shapes/appbar_shape.dart';
import 'package:wpims/utils/widgets/helper.dart';
import 'package:wpims/utils/widgets/texts.dart';

class TeacherProfile extends StatelessWidget {
  final String name;
  final String designation;
  final String empNo;
  final String joining;
  final String gender;
  final String blood;
  final String mobile;
  final String? email;
  final String? picture;

  const TeacherProfile({
    Key? key,
    required this.name,
    required this.designation,
    required this.empNo,
    required this.joining,
    required this.gender,
    required this.blood,
    required this.mobile,
    this.email,
    this.picture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar(title: 'Teacher Profile', isCentered: true),
      body: SingleChildScrollView(
        // padding: EdgeInsets.only(top: 90, left: 2, right: 2),
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipPath(
              clipper: AppBarShapeOval(),
              // this is my own class which extendsCustomClipper
              child: Container(
                height: 50,
                color: colorPrimary,
              ),
            ),
            // addVerticalSpace(16.0),
            Container(
              margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Stack(
                children: [profileContent(), profileImg()],
              ),
            ),
            addVerticalSpace(8.0),
            Container(
              margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
              decoration: BoxDecoration(
                color: bgGrey.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    addVerticalSpace(8.0),
                    textLabel('Personal'),
                    addVerticalSpace(16.0),
                    textContent('Joining Date', joining),
                    textContent('Gender',gender),
                    textContent('Blood Group',blood),
                    // textContent('web point ltd, bahaddarhat,web point ltd, bahaddarhat, chittagong'),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
              decoration: BoxDecoration(
                color: bgGrey.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    addVerticalSpace(8.0),
                    textLabel('Contacts'),
                    addVerticalSpace(16.0),
                    textContent('Mobile',mobile),
                    addVerticalSpace(8.0),
                    textContent('Email',email!),
                    addVerticalSpace(8.0),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget profileImg() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: FractionalOffset.center,
      child: picture != null? CircleAvatar(
        backgroundImage: NetworkImage(
            picture!
        ),
        radius: 50,
      ):CircleAvatar(
        backgroundImage: AssetImage('assets/images/avatar.png'),
        radius: 50,
      ),
    );
  }

  Widget profileContent() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 55.0),
      decoration: boxDecoration(
          bgColor: colorSecondary.withOpacity(.40),
          radius: 10,
          showShadow: true),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            topHeading(name,color: colorPrimary),
            subHeading(designation),
            subHeading(empNo),
          ],
        ),
      ),
    );
  }

  Widget textLabel(String label) {
    return Row(
      children: [
        Flexible(child: rowHeading(label,color: colorPrimary, fontSize: fontSizeLg)),
      ],
    );
  }

  Widget textContent(String label, String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        children: [
          bodyTextNormal(label + ' :', fontWeight: FontWeight.bold),
          addHorizontalSpace(8.0),
          bodyTextNormal(text)
        ],
      ),
    );
  }

  Widget counter(String counter, String counterName) {
    return Column(
      children: [
        subHeading(counter, color: colorPrimary),
        bodyTextNormal(counterName),
      ],
    );
  }

  Widget horizontalSeparator() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: addHorizontalDivider(),
    );
  }
}
