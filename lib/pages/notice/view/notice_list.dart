import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wpims/pages/notice/model/notice_list_model.dart';
import 'package:wpims/pages/notice/view/notice_details.dart';
import 'package:wpims/services/api.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/shimmers.dart';
import 'package:wpims/utils/widgets/helper.dart';
import 'package:wpims/utils/widgets/icons.dart';
import 'package:wpims/utils/widgets/texts.dart';


class NoticeList extends StatefulWidget {
  NoticeList({Key? key}) : super(key: key);

  @override
  _NoticeListState createState() => _NoticeListState();
}

class _NoticeListState extends State<NoticeList> {
  bool isLoading = true;
  bool isEmptyData = false;
  int page=1;
  bool hasMorePage=true;
  List<NoticeModel> items = [];
  String message='No Data Found';
  Random random = Random();
  final controller=ScrollController();
  Future _refresh() {
    setState(() {
      isLoading = true;
      items=[];
      page=1;
      hasMorePage=true;
    });
    return getData();
  }

  Future getData() async {
    final response=await ApiService().get('notices?page='+page.toString());
      if(response.statusCode==200) {
        NoticeListApi noticeInstance = noticeFromJson(response.body);
          items.addAll(noticeInstance.notices);
          if(noticeInstance.meta.to==noticeInstance.meta.total){
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
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return RefreshIndicator(
      onRefresh: _refresh,
      child: Container(
        alignment: Alignment.topCenter,
        constraints:
            BoxConstraints(minHeight: size.height, minWidth: size.width),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: isEmptyData?noData():ListView.separated(
            controller: controller,
            itemCount: isLoading ? 8 : items.length+1,
            physics: const ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              {
                if (isLoading) {
                  return noticeListShimmer();
                }
                if(index==items.length){
                  if(hasMorePage){
                    return Center(
                      child: CircularProgressIndicator(color: colorPrimary),
                    );
                  }else{
                    return Center(
                      child: hintText('No more data to load'),
                    );
                  }
                }
                return Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(right: 20.0),
                      height: 150,
                      decoration: BoxDecoration(
                        color: randomColors[
                            random.nextInt(randomColors.length)],
                        borderRadius:
                            BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => NoticeDetails(id: items[index].id),));
                      },
                      child: Container(
                          height: 150,
                          margin: EdgeInsets.only(left: 12.0),
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            boxShadow: [
                              BoxShadow(
                                color: bgGrey.withOpacity(0.2),
                                spreadRadius: 2,
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
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        topHeading(items[index].title,
                                            textAlign: TextAlign.left,
                                            maxLines: 3,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24.0,
                                            lineHeight: 1.2),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              addVerticalSpace(15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  iconText(
                                      icon: Icons.calendar_month,
                                      label: items[index].date),
                                  iconText(
                                      icon: Icons.announcement_outlined,
                                      label: items[index].category),
                                  if (items[index].type != null)
                                    iconText(
                                        icon: Icons.tag,
                                        label: items[index].type ?? '')
                                ],
                              ),
                            ],
                          )),
                    ),
                  ],
                );
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              return addVerticalSpace(20);
            },
            // offAxisFraction: 1.5,
          ),
        ),
      ),
    );
  }

  Widget noticeListShimmer() {
    final size = MediaQuery.of(context).size;
    return Card(
        child: Container(
      width: size.width,
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerWidget.rectangularWithRadius(height: 25),
          addVerticalSpace(10),
          ShimmerWidget.rectangularWithRadius(height: 25),
          addVerticalSpace(10),
          ShimmerWidget.rectangularWithRadius(
            height: 25,
            width: size.width - random.nextInt(150),
          ),
          addVerticalSpace(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: ShimmerWidget.rectangular(height: 20),
              ),
              Spacer(flex: 1),
              Flexible(
                flex: 2,
                child: ShimmerWidget.rectangular(height: 20),
              ),
              Spacer(flex: 1),
              Flexible(
                flex: 2,
                child: ShimmerWidget.rectangular(height: 20),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
