import 'package:flutter/material.dart';
import 'package:wpims/pages/attendance/view/attendance.dart';
import 'package:wpims/pages/partials/top_bar.dart';
import 'package:wpims/pages/profile/model/student_model.dart';
import 'package:wpims/pages/result/view/result.dart';
import 'package:wpims/services/api.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/shapes/appbar_shape.dart';
import 'package:wpims/utils/shimmers.dart';
import 'package:wpims/utils/widgets/helper.dart';
import 'package:wpims/utils/widgets/texts.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({Key? key}) : super(key: key);

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  late StudentProfileModel student;
  bool isLoading = true;
  bool isEmptyData = false;
  String statusMessage = 'No Data Found';
  bool imgNotFound = false;

  Future getData() async {
    final response = await ApiService().get('student-profile');
    if (response.statusCode == 200) {
      StudentProfileApi profileInstance = studentProfileFromJson(response.body);
      student = profileInstance.student;
      setState(() {
        isLoading = false;
        isEmptyData = false;
      });
    } else {
      setState(() {
        isEmptyData = true;
        isLoading = false;
      });
      // ShowWarningMsg(context: context,message:'No Data Found');
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: topBar(title: 'Student Profile', isCentered: true),
      body: isEmptyData
          ? Center(child: noData())
          : SingleChildScrollView(
              // padding: EdgeInsets.only(top: 90, left: 2, right: 2),
              physics: const ScrollPhysics(),
              child: isLoading
                  ? profileShimmer()
                  : Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          color: colorPrimary,
                          padding: EdgeInsets.only(top: 50.0),
                          child: Stack(
                            children: [profileContent(context), profileImg()],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              addVerticalSpace(8.0),
                              textContent(
                                  "Date of Birth", student.personal.dob),
                              addVerticalSpace(8.0),
                              textContent(
                                  "Blood Group", student.personal.blood),
                              addVerticalSpace(8.0),
                              textContent(
                                  "Religion", student.personal.religion),
                              addVerticalSpace(8.0),
                              textContent(
                                  "Nationality", student.personal.nationality),
                              addVerticalSpace(8.0),
                              textContent("Mobile", student.personal.mobile),
                              addVerticalSpace(8.0),
                              textContent("Email", student.personal.email),
                              addVerticalSpace(20.0),
                              textContent("Father", student.father.name),
                              addVerticalSpace(8.0),
                              textContent("Mobile", student.father.mobile),
                              addVerticalSpace(8.0),
                              textContent(
                                  "Occupation", student.father.occupation),
                              addVerticalSpace(20.0),
                              textContent("Mother", student.mother.name),
                              addVerticalSpace(8.0),
                              textContent("Mobile", student.mother.mobile),
                              addVerticalSpace(8.0),
                              textContent(
                                  "Occupation", student.mother.occupation),
                              addVerticalSpace(20.0),
                              textContent("Country", student.address.country),
                              addVerticalSpace(8.0),
                              textContent("Address", student.address.address),
                              addVerticalSpace(8.0),
                              textContent("City", student.address.city),
                              addVerticalSpace(8.0),
                              textContent(
                                  "Post Code", student.address.postcode),
                              addVerticalSpace(8.0),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
            ),
    );
  }

  Widget profileImg() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: FractionalOffset.center,
        child: student.personal.picture != null
            ? CircleAvatar(
                backgroundColor: colorPrimary,
                backgroundImage: NetworkImage(student.personal.picture!),
                onBackgroundImageError:
                    (Object exception, StackTrace? stackTrace) {
                  setState(() {
                    imgNotFound = true;
                  });
                },
                radius: 50.0,
                child: imgNotFound
                    ? Icon(Icons.warning_amber_outlined,
                        color: colorSecondary, size: 30.0)
                    : null)
            : CircleAvatar(
                backgroundColor: colorSecondary,
                backgroundImage: AssetImage('assets/images/avatar.png'),
                radius: 50.0,
              ));
  }

  Widget profileContent(context) {
    return Container(
      margin: EdgeInsets.only(top: 55.0),
      decoration: boxDecoration(bgColor: colorSecondary, showShadow: true),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            topHeading(student.personal.name),
            subHeading(student.personal.studentId,
                color: textGrey.withAlpha(150)),
            horizontalSeparator(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: _buildNav(
                        "Attendance",
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Attendance())))),
                addHorizontalSpace(2.0),
                Expanded(
                    child: _buildNav(
                        "Result",
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Result())))),
                addHorizontalSpace(2.0),
                Expanded(
                    child: _buildNav(
                        "Payments",
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Attendance())))),
              ],
            ),
            addVerticalSpace(16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    color: colorPrimary.withOpacity(0.30),
                    child: Column(
                      children: [
                        subHeading(student.personal.personalClass),
                        Wrap(
                          children: [
                            subHeading('Rank:' + student.personal.rank),
                            addHorizontalSpace(20.0),
                            subHeading('Status:' + student.personal.status)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget textLabel(String label) {
    return Row(
      children: [
        Flexible(child: rowHeading(label)),
      ],
    );
  }

  Widget textContent(String label, String text) {
    return Wrap(
      children: [
        bodyTextNormal(label + ' :', fontWeight: FontWeight.bold),
        addHorizontalSpace(8.0),
        bodyTextNormal(text)
      ],
    );
  }

  Widget _buildNav(String title, Function onTap) {
    return Container(
      color: colorPrimary,
      child: TextButton(
          onPressed: () {
            onTap();
          },
          child: subHeading(title, color: textLight)),
    );
  }

  Widget horizontalSeparator() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: addHorizontalDivider(),
    );
  }

  Widget profileShimmer() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        // addVerticalSpace(16.0),
        Container(
          margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Stack(
            children: [shimmerContent(), shimmerImg()],
          ),
        ),

        const SizedBox(height: 8),
        Container(
          margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
          decoration: const BoxDecoration(
              color: bgLight,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                  offset: const Offset(0.0, 0.0),
                )
              ]),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: ShimmerWidget.rectangular(height: 300.0),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget shimmerImg() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: FractionalOffset.center,
      child: const ShimmerWidget.circular(width: 100.0, height: 100.0),
    );
  }

  Widget shimmerContent() {
    return Container(
      margin: EdgeInsets.only(top: 55.0),
      decoration: BoxDecoration(
        color: bgLight,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 4.0,
            spreadRadius: 1.0,
            offset: const Offset(0.0, 0.0),
          )
        ],
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            addVerticalSpace(50),
            ShimmerWidget.rectangular(height: 50.0),
            addVerticalSpace(10.0),
            ShimmerWidget.rectangular(height: 30.0),
            // horizontalSeparator(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
