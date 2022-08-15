import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wpims/pages/calender/model/calender_model.dart';
import 'package:wpims/pages/diary/model/diary_model.dart';
import 'package:wpims/pages/partials/top_bar.dart';
import 'package:wpims/services/api.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/constants/fonts.dart';
import 'package:wpims/utils/factory/faker.dart';
import 'package:wpims/utils/shapes/appbar_shape.dart';
import 'package:wpims/utils/shimmers.dart';
import 'package:wpims/utils/widgets/helper.dart';
import 'package:wpims/utils/widgets/texts.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  late List<CalendarModel> calenderList;
  bool isLoading = true;
  bool isEmptyData = false;
  Random random = Random();

  Future _refresh() {
    setState(() {
      isLoading = true;
    });
    return getData();
  }

  Future getData() async {
    final response=await ApiService().get('calendar');
    if(response.statusCode==200) {
      CalendarApi calendarInstance = calenderFromJson(response.body);
      calenderList = calendarInstance.calendar;

      setState(() {
        isEmptyData = false;
        isLoading = false;
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
  void initState() {
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        appBar: topBar(title: 'Calendar'),
        body: Stack(
          children: [
            Container(
              height: size.height,
              color: colorPrimary,
            ),
            curvedBodyContainer(size.height),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
              child: isEmptyData?Center(child: noData()):ListView.separated(
                  itemCount: isLoading?6:calenderList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if(isLoading){
                      return _buildcalenderListShimmer();
                    }
                    return _buildCalenderMonth(calenderList[index]);
                  },
                  separatorBuilder: (BuildContext context, int index){
                    return addVerticalSpace(6.0);
                  },

              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildCalenderMonth(CalendarModel calender){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: greyColor.withAlpha(80),
            borderRadius: BorderRadius.circular(6.0),
          ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),
              child: subHeading(calender.month, color: calenderColors[calender.month.toLowerCase()]),
            )
        ),
        ...calender.events.map((item)=>Container(
          margin: EdgeInsets.symmetric(vertical: 2.0),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color:calenderColors[calender.month.toLowerCase()],
                    ),
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: subHeading(
                        item.date.toString(),
                          fontSize: fontSizeSm,
                        color: textLight
                      )
                  ),
                ),
                addHorizontalSpace(4.0),
                Expanded(
                  flex: 2,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color:calenderColors[calender.month.toLowerCase()],
                      ),
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: subHeading(
                        item.day.toString(),
                        fontSize: fontSizeSm,
                          color: textLight,
                      )
                  ),
                ),
                addHorizontalSpace(4.0),
                Expanded(
                  flex: 5,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color:calenderColors[calender.month.toLowerCase()],
                      ),
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: subHeading(
                        item.title.toString(),
                          color: textLight,
                          maxLines: 2,
                        fontSize: fontSizeSm
                      )
                  ),
                ),
              ],
            ),
          ),
        )).toList(),

      ],
    );
  }







  Widget _buildcalenderListShimmer() {
    final size=MediaQuery.of(context).size;
    return Card(
        child: Container(
          width: size.width,
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerWidget.rectangularWithRadius(height: 50.0),
              addVerticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangularWithRadius(height: 40,radius: 10,),
                  ),
                  addHorizontalSpace(10),
                  Flexible(
                    flex: 2,
                    child: ShimmerWidget.rectangularWithRadius(height: 40,radius: 10,),
                  ),
                  addHorizontalSpace(10),
                  Flexible(
                    flex: 5,
                    child: ShimmerWidget.rectangularWithRadius(height: 40,radius: 10,),
                  ),


                ],
              ),
              addVerticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangularWithRadius(height: 40,radius: 10,),
                  ),
                  addHorizontalSpace(10),
                  Flexible(
                    flex: 2,
                    child: ShimmerWidget.rectangularWithRadius(height: 40,radius: 10,),
                  ),
                  addHorizontalSpace(10),
                  Flexible(
                    flex: 5,
                    child: ShimmerWidget.rectangularWithRadius(height: 40,radius: 10,),
                  ),


                ],
              ),
              addVerticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangularWithRadius(height: 40,radius: 10,),
                  ),
                  addHorizontalSpace(10),
                  Flexible(
                    flex: 2,
                    child: ShimmerWidget.rectangularWithRadius(height: 40,radius: 10,),
                  ),
                  addHorizontalSpace(10),
                  Flexible(
                    flex: 5,
                    child: ShimmerWidget.rectangularWithRadius(height: 40,radius: 10,),
                  ),


                ],
              ),
            ],
          ),
        )
    );
  }
}
