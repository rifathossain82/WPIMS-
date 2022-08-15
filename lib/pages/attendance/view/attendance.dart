import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wpims/pages/attendance/model/attendance_model.dart';
import 'package:wpims/pages/partials/top_bar.dart';
import 'package:wpims/pages/result/model/marksheet_model.dart';
import 'package:wpims/pages/result/model/result_model.dart';
import 'package:wpims/services/api.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/constants/fonts.dart';
import 'package:wpims/utils/factory/faker.dart';
import 'package:wpims/utils/methods.dart';
import 'package:wpims/utils/shapes/appbar_shape.dart';
import 'package:wpims/utils/shimmers.dart';
import 'package:wpims/utils/widgets/helper.dart';
import 'package:wpims/utils/widgets/icons.dart';
import 'package:wpims/utils/widgets/texts.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  bool isLoading = true;
  Random random = Random();
  final List<MarkSheetModel> marksList = marks;
  late List<AttendanceModel> attnList;
  late Today today;
  final List<Map> attnHints = attendanceHints;
  bool isEmptyData = false;
  DateTime? selectedDateFrom;
  DateTime? selectedDateTo;
  late String dateFrom;
  late String dateTo;
  late String shiftInTime;
  late String shiftOutTime;
  String query='attendance';
  Future getData() async {
    setState(() {
      isLoading=true;
    });

    if(selectedDateFrom!=null && selectedDateTo!=null){
      query='attendance?dateFrom=${DateFormat('dd-MM-yyyy').format(selectedDateFrom!).toString()}&dateTo=${DateFormat('dd-MM-yyyy').format(selectedDateTo!).toString()}';
    }
    final response=await ApiService().get(query);
    if(response.statusCode==200) {
      AttendanceListApi attendanceListInstance = attendanceListFromJson(response.body);
      attnList = attendanceListInstance.attendances;
      dateFrom=attendanceListInstance.dateFrom;
      dateTo=attendanceListInstance.dateTo;
      today=attendanceListInstance.today;

      shiftInTime='09 AM';
      shiftOutTime='02:00 PM';
      setState(() {
        isLoading=false;
        isEmptyData = false;
      });

    }else {
      setState(() {
        isEmptyData = true;
        isLoading=false;
      });
      // ShowWarningMsg(context: context,message:'No Data Found');
    }
  }

  Future<void> _refresh() async{
      selectedDateTo=null;
      selectedDateFrom=null;
      startDateController.clear();
      endDateController.clear();
      query='attendance';
      getData();
  }

  void getDateWiseAttendance(){
    if(selectedDateFrom!=null && selectedDateTo!=null){
      getData();
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
    getData();
    super.initState();
  }

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        appBar: topBar(title: 'Attendance'),
        body: Stack(
          children: [
            Container(
              height: size.height,
              color: colorPrimary,
            ),
            curvedBodyContainer(size.height),
            isEmptyData?Center(child: noData()):SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: isLoading?AttendanceShimmer():Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildSummaryToday(),
                    addVerticalSpace(15.0),
                    _buildDatePicker(),
                    addVerticalSpace(10.0),
                    subHeading('${dateFrom} To ${dateTo}'),
                    addVerticalSpace(10.0),
                    Table(
                      // defaultVerticalAlignment: TableCellVerticalAlignment.middle,

                      border: TableBorder.all(color: textGrey),
                      children: [
                        _buildHeadingRow(),
                        ...attnList.map((item) => _buildBodyRow(item)),

                        // _buildMarksRow(),
                      ],
                    ),
                    addVerticalSpace(10.0),
                    subHeading('Shift Time: ${shiftInTime} - ${shiftOutTime}', color: darkBlue),
                    addVerticalSpace(10.0),
                    _buildHintsRow(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryToday() {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.indigoAccent.withAlpha(120),
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(child: subHeading('Today')),
                ],
              ),
              addVerticalSpace(8.0),
              Container(
                margin: EdgeInsets.only(right: 60),
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceAround,
                  children: [
                    iconText(
                        icon: Icons.calendar_month,
                        label: today.date,
                        color: textColorPrimary),
                    addHorizontalSpace(8.0),
                    iconText(
                        icon: Icons.input,
                        label: today.inTime??'--:--',
                        color: textColorPrimary),
                    addHorizontalSpace(8.0),
                    iconText(
                        icon: Icons.output,
                        label: today.outTime??'--:--',
                        color: textColorPrimary),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                margin: EdgeInsets.all(6.0),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: darkBlue,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Text(today.status,
                    style: TextStyle(
                        color: textLight,
                        fontSize: fontSizeMd,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          )
        ],
      ),
    );
  }

  TableRow _buildHeadingRow() {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: tableTextHeading('DATE'),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: tableTextHeading('IN TIME'),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: tableTextHeading('OUT TIME'),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: tableTextHeading('STATUS'),
        ),
      ],
    );
  }

  TableRow _buildBodyRow(AttendanceModel attendance) {
    return TableRow(children: [
      tableTextBody(attendance.date,
          verticalPadding: 4.0,
          color: attendanceStatusColors[attendance.status]),
      tableTextBody(attendance.inTime??'--:--',
          verticalPadding: 4.0,
          color: attendanceStatusColors[attendance.status]),
      tableTextBody(attendance.outTime??'--:--',
          verticalPadding: 4.0,
          color: attendanceStatusColors[attendance.status]),
      tableTextBody(attendance.status,
          verticalPadding: 4.0,
          color: attendanceStatusColors[attendance.status]),
    ]);
  }

  Widget AttendanceShimmer() {
    final size = MediaQuery.of(context).size;
    return Card(
        child: Container(
      width: size.width,
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerWidget.rectangularWithRadius(height: 70),
          addVerticalSpace(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: ShimmerWidget.rectangularWithRadius(height: 40),
              ),
              addHorizontalSpace(10),
              Flexible(
                child: ShimmerWidget.rectangularWithRadius(height: 40),
              ),
            ]
          ),
          addVerticalSpace(15),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 5,
                  child: ShimmerWidget.rectangularWithRadius(height: 20),
                ),
                addHorizontalSpace(10),
                Flexible(
                  flex: 2,
                  child: ShimmerWidget.rectangularWithRadius(height: 20),
                ),
                addHorizontalSpace(10),
                Flexible(
                  flex: 5,
                  child: ShimmerWidget.rectangularWithRadius(height: 20),
                ),
              ]
          ),
          addVerticalSpace(15),
          ...List.generate(10, (index) => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: ShimmerWidget.rectangular(height: 20),
                  ),
                  addHorizontalSpace(10),
                  Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangular(height: 20),
                  ),
                  addHorizontalSpace(10),
                  Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangular(height: 20),
                  ),
                  addHorizontalSpace(10),
                  Flexible(
                    flex: 1,
                    child: ShimmerWidget.rectangular(height: 20),
                  ),
                ],
              ),
              addVerticalSpace(10),
            ],
          ),
          ),

          addVerticalSpace(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                  child: ShimmerWidget.rectangularWithRadius(
                      height: 25, width: size.width * 0.7)),
            ],
          ),
          addVerticalSpace(15),
          ShimmerWidget.rectangularWithRadius(height: 80),
          addVerticalSpace(15),
        ],
      ),
    ));
  }

  Widget _buildHintsRow() {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: bgGrey.withOpacity(0.1),
        border: Border.all(color: bgGrey),
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: GridView.builder(
        itemCount: attnHints.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 4.0,
          mainAxisExtent: 20.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return subHeading(
              attnHints[index]['key'] + '-' + attnHints[index]['text'],
              color: attendanceStatusColors[attnHints[index]['key']],
              textAlign: TextAlign.left,
              fontWeight: FontWeight.bold,
              fontSize: fontSizeSm);
        },
      ),
    );
  }

  Widget _buildDatePicker() {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: TextFormField(
              controller: startDateController,
              readOnly: true,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(8.0),
                suffixIcon: Icon(Icons.date_range, color: textDark),
                hintText: "YYYY-MM-DD",
                hintMaxLines: 1,
                hintStyle: TextStyle(fontSize: 15.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: bgGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: bgGrey),
                ),
              ),
              onTap: () async {
                final pickedDate = await selectDate(
                    context: context,
                    initialDate: selectedDateFrom??DateTime.now(),
                    allowedDays: _allowedDays);
                if (pickedDate != null && pickedDate != selectedDateFrom) {
                  setState(() {
                    selectedDateFrom = pickedDate;
                    startDateController.text =
                        DateFormat('yyyy-MM-dd').format(selectedDateFrom??DateTime.now());
                  });
                  getDateWiseAttendance();
                  // FocusScope.of(context).requestFocus(FocusNode());
                }
              }),
        ),
        addHorizontalSpace(8.0),
        Flexible(
          flex: 1,
          child: TextFormField(
            controller: endDateController,
            readOnly: true,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(8.0),
              suffixIcon: Icon(Icons.date_range, color: textDark),
              hintText: "YYYY-MM-DD",
              hintMaxLines: 1,
              hintStyle: TextStyle(fontSize: 15.0),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: bgGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: bgGrey),
              ),
            ),
            onTap: () async {
              final pickedDate = await selectDate(
                  context: context,
                  initialDate: selectedDateTo??DateTime.now(),
                  allowedDays: _allowedDays);
              if (pickedDate != null && pickedDate != selectedDateTo) {
                setState(() {
                  selectedDateTo = pickedDate;
                  endDateController.text =
                      DateFormat('yyyy-MM-dd').format(selectedDateTo??DateTime.now());
                });
                getDateWiseAttendance();
              }
              // FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
        ),
      ],
    );
  }

  bool _allowedDays(DateTime day) {
    if ((day.isBefore(DateTime.now()))) {
      return true;
    }
    return false;
  }


}
