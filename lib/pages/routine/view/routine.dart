import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wpims/pages/calender/model/calender_model.dart';
import 'package:wpims/pages/diary/model/diary_model.dart';
import 'package:wpims/pages/partials/top_bar.dart';
import 'package:wpims/pages/routine/model/routine_model.dart';
import 'package:wpims/services/api.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/constants/fonts.dart';
import 'package:wpims/utils/factory/faker.dart';
import 'package:wpims/utils/shapes/appbar_shape.dart';
import 'package:wpims/utils/shimmers.dart';
import 'package:wpims/utils/widgets/helper.dart';
import 'package:wpims/utils/widgets/texts.dart';

class Routine extends StatefulWidget {
  const Routine({Key? key}) : super(key: key);

  @override
  State<Routine> createState() => _RoutineState();
}

class _RoutineState extends State<Routine> {
  TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  late List<RoutineModel> routineList;
  Random random = Random();
  bool isLoading = true;
  bool isEmptyData = false;

  Future _refresh() {
    setState(() {
      isLoading = true;
    });
    return getData();
  }

  Future getData() async {
    final response=await ApiService().get('class-routines');
    if(response.statusCode==200) {
      RoutineListApi routineListInstance = routineApiFromJson(response.body);
      routineList=routineListInstance.routine;

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
  void dispose(){
    // controller.dispose();
    super.dispose();
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
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: _refresh,
      child:Container(
              margin: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
              child: isEmptyData?noData():ListView.separated(
                  itemCount: isLoading?6:routineList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if(isLoading){
                      return _buildRoutineListShimmer();
                    }
                    return _buildCalenderMonth(routineList[index]);
                  },
                  separatorBuilder: (BuildContext context, int index){
                    return addVerticalSpace(6.0);
                  },

              ),
            ),
    );
  }

  _buildCalenderMonth(RoutineModel routine){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 4.0),
          decoration: BoxDecoration(
            color: colorPrimaryAccent,
            borderRadius: BorderRadius.circular(6.0),
          ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
              child: subHeading(routine.weekday, color: textLight),
            )
        ),
        ...routine.hours.map((item)=>Container(
          margin: EdgeInsets.symmetric(vertical: 4.0),
          child: IntrinsicHeight(
            child: item.isBreak?Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color:bgGrey.withAlpha(30),
                    ),
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: subHeading('Break',color: textPrimaryDark),
                  ),
                )
              ],
            ):Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color:colorPrimary.withOpacity(.30),
                    ),
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: subHeading(
                        item.name.toString(),
                          fontSize: fontSizeSm,
                        color: textPrimaryDark
                      )
                  ),
                ),
                addHorizontalSpace(8.0),
                Expanded(
                  flex: 3,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color:colorPrimary.withOpacity(.30),
                      ),
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          bodyTextNormal(
                            item.start.toString(),
                            fontSize: fontSizeSm,
                            color: textPrimaryDark,
                          ),
                          bodyTextNormal(
                            item.end.toString(),
                            fontSize: fontSizeSm,
                            color: textPrimaryDark,
                          ),

                        ],
                      )
                  ),
                ),
                addHorizontalSpace(8.0),
                Expanded(
                  flex: 5,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color:colorPrimary.withOpacity(.30),
                      ),
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: subHeading(
                        item.subject.toString(),
                          color: textPrimaryDark,
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







  Widget _buildRoutineListShimmer() {
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
