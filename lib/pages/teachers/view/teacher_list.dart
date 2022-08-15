import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';
import 'package:wpims/pages/partials/top_bar.dart';
import 'package:wpims/pages/profile/view/student_profile.dart';
import 'package:wpims/pages/profile/view/teacher_profile.dart';
import 'package:wpims/services/api.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/constants/fonts.dart';
import 'package:wpims/utils/factory/faker.dart';
import 'package:wpims/utils/image_view.dart';
import 'package:wpims/utils/shimmers.dart';
import 'package:wpims/utils/widgets/helper.dart';
import 'package:wpims/utils/widgets/texts.dart';

import '../model/teacher_list_model.dart';

class TeacherList extends StatefulWidget {
  TeacherList({Key? key}) : super(key: key);

  @override
  _TeacherListState createState() => _TeacherListState();
}

class _TeacherListState extends State<TeacherList> {
  final List<Teacher> items=[];
  bool isLoading = true;
  bool isEmptyData = false;
  int page=1;
  bool hasMorePage=true;
  String message='No Data Found';
  final controller=ScrollController();
  List borderColors = [
    Colors.red,
    Colors.green,
    Colors.lightGreen,
    Colors.blueAccent,
    Colors.indigo,
    Colors.lightBlueAccent
  ];

  Random random = new Random();

  Future _refresh() {
    setState(() {
      this.isLoading = true;
    });
    return getData();
  }

  Future getData() async {
    final response=await ApiService().get('teachers?page='+page.toString());
    if(response.statusCode==200) {
      TeacherListApi teacherInstance = teacherListFromJson(response.body);
      items.addAll(teacherInstance.teachers);
      if(teacherInstance.meta.to==teacherInstance.meta.total){
        setState(() {
          hasMorePage=false;
        });
      }
      setState(() {
        isEmptyData = false;
        isLoading = false;
        page+=1;
      });
    }else{
      setState(() {
        isLoading=false;
        isEmptyData = true;
      });
      // ShowWarningMsg(context: context,message:'No Data Found');
    }
  }
  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if(controller.position.maxScrollExtent==controller.offset && hasMorePage && !isLoading){
        getData();
      }
    });
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        appBar: topBar(title: 'Teacher List'),
        body: Container(
          alignment: Alignment.topCenter,
          constraints:
            BoxConstraints(minHeight: size.height, minWidth: size.width),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.separated(
              controller: controller,
              itemCount: isLoading ? 8 : items.length,
              physics: ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                {
                  if (isLoading) {
                    return TeacherListShimmer();
                  }
                  return InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(
                          builder: (BuildContext context)=>TeacherProfile(
                            name: items[index].name,
                            designation: items[index].designation,
                            empNo: items[index].empNo,
                            joining: items[index].joiningDate,
                            gender: items[index].gender??'',
                            blood: items[index].bloodGroup??'',
                            mobile: items[index].phone,
                            email: items[index].email,
                            picture: items[index].image,
                          ))
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(right: 20.0),
                          height: 230,
                          decoration: BoxDecoration(
                            color: borderColors[random.nextInt(borderColors.length)],
                            borderRadius:BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                        Container(
                            height: 230,
                            margin: EdgeInsets.only(left: 12.0),
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10
                            ),
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius:BorderRadius.all(Radius.circular(8.0)),
                              boxShadow: [
                                BoxShadow(
                                  color: bgGrey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      3, 6), // changes position of shadow
                                ),

                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    // CachedNetworkImage(
                                    //   imageUrl: items[index].image??'',
                                    //   placeholder: (context, url) => CircularProgressIndicator(),
                                    //   errorWidget: (context, url, error) => Icon(Icons.error),
                                    // ),
                                    // Image.network(
                                    //   'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
                                    //   fit: BoxFit.cover,
                                    //   width: 90,
                                    // ),
                                    if(items[index].image != null)
                                      ClipRRect(
                                        child: FullScreenImage(
                                          child: Image.network(
                                            items[index].image!,
                                            fit: BoxFit.cover,
                                            width: 90,
                                            loadingBuilder: (BuildContext context, Widget child,
                                                ImageChunkEvent? loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Center(
                                                child: CircularProgressIndicator(
                                                  color: colorPrimary,
                                                  value: loadingProgress.expectedTotalBytes != null
                                                      ? loadingProgress.cumulativeBytesLoaded /
                                                      loadingProgress.expectedTotalBytes!
                                                      : null,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      )
                                    else
                                    ClipRRect(
                                      child: Image.asset(
                                        'assets/images/user.jpeg',
                                        fit: BoxFit.cover,
                                        width: 90,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            topHeading(items[index].name,
                                                textAlign: TextAlign.left,
                                                maxLines: 2,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24.0),
                                            subHeading(items[index].designation,
                                                color: textGrey),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          addVerticalSpace(8.0),
                                          if(items[index].joiningDate !=null)
                                            bodyTextNormal(
                                              'Joining Date: ' +
                                                  items[index].joiningDate,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          bodyTextNormal(
                                              'Index No: ' +
                                                  items[index].empNo.toString(),
                                              fontWeight: FontWeight.bold),
                                          bodyTextNormal(
                                              'Phone: ' + items[index].phone,
                                              fontWeight: FontWeight.bold),
                                          if(items[index].email !=null)
                                          bodyTextNormal(
                                              'Email: ' + items[index].email!,
                                              fontWeight: FontWeight.bold),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                  );
                }
              },
              separatorBuilder: (BuildContext context, int index){
                return addVerticalSpace(20);
              },
              // offAxisFraction: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget TeacherListShimmer() {
    final size=MediaQuery.of(context).size;
    return Card(
      child: Container(
        width: size.width,
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                ShimmerWidget.rectangularWithRadius(height: 80,width: 80,),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        ShimmerWidget.rectangular(height: 40),
                        addVerticalSpace(10),
                        ShimmerWidget.rectangular(height: 20, width: size.width/2.8,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      addVerticalSpace(8.0),
                      ShimmerWidget.rectangular(height: 20, width: size.width/2),
                      addVerticalSpace(8.0),
                      ShimmerWidget.rectangular(height: 20,width: size.width/1.7),
                      addVerticalSpace(8.0),
                      ShimmerWidget.rectangular(height: 20,width: size.width/1.8),
                      addVerticalSpace(8.0),
                      ShimmerWidget.rectangular(height: 20,width: size.width/1.5),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      )
    );
  }


}
