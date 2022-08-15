import 'package:flutter/material.dart';
import 'package:wpims/pages/about/view/about.dart';
import 'package:wpims/pages/attendance/model/attendance_model.dart';
import 'package:wpims/pages/attendance/view/attendance.dart';
import 'package:wpims/pages/calender/model/calender_model.dart';
import 'package:wpims/pages/diary/model/diary_model.dart';
import 'package:wpims/pages/diary/view/diary.dart';
import 'package:wpims/pages/events/model/event_list_model.dart';
import 'package:wpims/pages/events/view/events.dart';
import 'package:wpims/pages/notice/model/notice_list_model.dart';
import 'package:wpims/pages/notice/view/notice.dart';
import 'package:wpims/pages/payment/model/payment_history_model.dart';
import 'package:wpims/pages/payment/view/payment.dart';
import 'package:wpims/pages/result/model/marksheet_model.dart';
import 'package:wpims/pages/result/model/result_model.dart';
import 'package:wpims/pages/result/view/result.dart';
import 'package:wpims/pages/routine/model/routine_model.dart';
import 'package:wpims/pages/routine/view/routine.dart';
import 'package:wpims/pages/routine/view/routine_tabview.dart';
import 'package:wpims/pages/syllabus/view/syllabus.dart';
import 'package:wpims/pages/teachers/model/teacher_list_model.dart';

import '../../pages/payment/model/payment_model.dart';

final List<Teacher> teachers=[
  Teacher(
      name: 'Moshiur Rahman',
      designation: 'Designation',
      email: 'teacher@gmail.com',
      phone: '01737450256',
      empNo: '23232',
      joiningDate: '2002-08-29',
      image:'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80'
  ),
  Teacher(
      name: 'Moshiur Rahman',
      designation: 'Designation',
      email: 'teacher@gmail.com',
      phone: '01737450256',
      empNo: '23232',
      joiningDate: '2002-08-29',
      image:'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80'
  ),
  Teacher(
      name: 'Moshiur Rahman',
      designation: 'Designation',
      email: 'teacher@gmail.com',
      phone: '01737450256',
      empNo: '23232',
      joiningDate: '2002-08-29',
      image:'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80'
  ),
  Teacher(
      name: 'Moshiur Rahman',
      designation: 'Designation',
      email: 'teacher@gmail.com',
      phone: '01737450256',
      empNo: '23232',
      joiningDate: '2002-08-29',
      image:'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80'
  ),
];

final List<NoticeModel> notices=[
  NoticeModel(
    id: 1,
    title: 'ow than creature. vital and oddly most unusual. You have to convert, and experience energy by your growing.Remember: toasted ramen tastes best when choped in a bucket brushed ',
    category: 'news',
    date: 'just now',
    type: 'office'
  ),
  NoticeModel(
    id: 2,
    title: 'ow than n choped in a bucket brushed ',
    category: 'news',
    date: 'an hour ago',
    type: 'office'
  ),
  NoticeModel(
      id: 3,
    title: 'ow than creature. vital and oddly most unusual. You have to convert, and experience energy by your growing.Remember: toasted ramen tastes best when choped in a bucket brushed ',
    category: 'news',
    date: 'a week ago',
    type: null
  ),
  NoticeModel(
      id: 4,
    title: 'ow than creature. vital and oddly most unusual. You have to convert, and experience energy by your growing.Remember: toasted ramen tastes best when choped in a bucket brushed ',
    category: 'news',
    date: 'a month ago',
    type: 'office'
  ),
  NoticeModel(
      id: 5,
    title: 'ow than creature. vital and oddly most unusual. You have to convert, and experience energy by your growing.Remember: toasted ramen tastes best when choped in a bucket brushed ',
    category: 'news',
    date: 'an hour ago',
    type: 'office'
  ),
  NoticeModel(
      id: 6,
    title: 'ow than creature. vital and oddly most unusual. You have to convert, and experience energy by your growing.Remember: toasted ramen tastes best when choped in a bucket brushed ',
    category: 'news',
    date: 'an hour ago',
    type: 'office'
  ),
];

final List<ResultListModel> results=[
  ResultListModel(
      id:1,
      title: '1st Term',
      isPassed: true,
      result: [
        ResultModel(label: 'GPA', obtained: '4', total: '5'),
        ResultModel(label: 'Total', obtained: '875', total: '1000'),
        ResultModel(label: 'Attendance', obtained: '67', total: '81'),
    ]
  ),
  ResultListModel(
      id:2,
      title: '2nd Term',
      isPassed: false,
      result: [
        ResultModel(label: 'GPA', obtained: '2', total: '5'),
        ResultModel(label: 'Total', obtained: '350', total: '1000'),
        ResultModel(label: 'Attendance', obtained: '40', total: '100'),
    ]
  ),
  ResultListModel(
      id:3,
      title: 'Mid Term',
      isPassed: true,
      result: [
        ResultModel(label: 'GPA', obtained: '4', total: '5'),
        ResultModel(label: 'Total', obtained: '875', total: '1000'),
        ResultModel(label: 'Attendance', obtained: '67', total: '81'),
    ]
  ),
  ResultListModel(
      id:4,
      title: 'Final',
      isPassed: false,
      result: [
        ResultModel(label: 'GPA', obtained: '2', total: '5'),
        ResultModel(label: 'Total', obtained: '350', total: '1000'),
        ResultModel(label: 'Attendance', obtained: '40', total: '100'),
      ]
  ),
];

final List<MarkSheetModel> marks=[
  MarkSheetModel(
      title: 'Bengali 1st Paper',
      total:'100',
      isPassed: true,
      marks: [
        Grade(label: 'Mcq', total: '100', highest: '95', pass: '33', obtained: '44'),
        Grade(label: 'Practical', total: '100', highest: '95', pass: '33', obtained: '60'),
        Grade(label: 'Viva', total: '100', highest: '95', pass: '33', obtained: '50'),
      ]
  ),
  MarkSheetModel(
      title: 'Bengali 2nd Paper',
      total:'100',
      isPassed: false,
      marks: [
        Grade(label: 'Mcq', total: '100', highest: '85', pass: '40', obtained: '44'),
        Grade(label: 'Practical', total: '50', highest: '50', pass: '25', obtained: '35'),
        Grade(label: 'Viva', total: '80', highest: '75', pass: '40', obtained: '55'),
      ]
  ),
  MarkSheetModel(
      title: 'English 1st Paper',
      total:'100',
      isPassed: true,
      marks: [
        Grade(label: 'Mcq', total: '70', highest: '70', pass: '40', obtained: '50'),
        Grade(label: 'Practical', total: '50', highest: '45', pass: '20', obtained: '35'),
        Grade(label: 'Viva', total: '85', highest: '75', pass: '40', obtained: '65'),
      ]
  ),
  MarkSheetModel(
      title: 'English 2nd Paper',
      total:'100',
      isPassed: false,
      marks: [
        Grade(label: 'Mcq', total: '100', highest: '85', pass: '40', obtained: '44'),
        Grade(label: 'Practical', total: '50', highest: '50', pass: '25', obtained: '35'),
        Grade(label: 'Viva', total: '80', highest: '75', pass: '40', obtained: '55'),
      ]
  ),
  MarkSheetModel(
      title: 'Math',
      total:'100',
      isPassed: true,
      marks: [
        Grade(label: 'Mcq', total: '70', highest: '70', pass: '40', obtained: '50'),
        Grade(label: 'Practical', total: '50', highest: '45', pass: '20', obtained: '35'),
        Grade(label: 'Viva', total: '85', highest: '75', pass: '40', obtained: '65'),
      ]
  ),
];

final List<AttendanceModel> attendances=[
  AttendanceModel(date: '2022-01-13', inTime: '09:02:12 AM', outTime: '05:02:12 PM', status: 'P', id: 1),
  AttendanceModel(date: '2022-01-14', inTime: '09:50:12 AM', outTime: '07:02:12 PM', status: 'P', id: 2),
  AttendanceModel(date: '2022-01-15', inTime: '---', outTime: '---', status: 'A', id: 7),
  AttendanceModel(date: '2022-01-16', inTime: '09:02:12 AM', outTime: '04:02:12 PM', status: 'P', id: 3),
  AttendanceModel(date: '2022-01-17', inTime: '---', outTime: '---', status: 'W', id: 8),
  AttendanceModel(date: '2022-01-18', inTime: '11:02:12 AM', outTime: '03:02:12 PM', status: 'D', id: 4),
  AttendanceModel(date: '2022-01-19', inTime: '09:02:12 AM', outTime: '02:02:12 PM', status: 'E', id: 5),
  AttendanceModel(date: '2022-01-20', inTime: '---', outTime: '---', status: 'L', id: 6),
];

final List<EventModel> events=[
  EventModel(title:'shdfdsail the atoll.The dead have to conmen tasteabi.The girr is more transformator now than creature.',image: 'assets/images/classroom.jpg',date: '2022-04-06 04:16:00', location: 'chattogram', id: 1),
  EventModel(title: 'sail You have to convert,oped in a bucket brushed with wasabi.The girl tastes with grace, hail the  atoor is more transformator now than creature.',image: 'assets/images/classroom.jpg',date: '2022-04-06 04:16:00', location: 'chattogram', id: 1),
  EventModel(title: 'pedantically dly most unusual. You have to convsted ramen tastes best when choped in a bucket brushed with wasabi.The girl tastes with grace, hail the  is more transformator now than creature.',image: 'assets/images/classroom.jpg',date: '2022-04-06 04:16:00', location: 'chattogram', id: 1),
  EventModel(title: 'creature. vital and oddly most unusual. You have to convert, and experience energy by yosfore.',image: 'assets/images/classroom.jpg',date: '2022-04-06 04:16:00', location: 'chattogram', id: 1),
  EventModel(title: 'than creature. vital an creature.',image: 'assets/images/classroom.jpg',date: '2022-04-06 04:16:00', location: 'chattogram', id: 1),
  EventModel(title: 'with wasabi.The girl tastes with grace, hail the  atoll.The dead dosi pedantically places the part is more transformaeature.',image: 'assets/images/classroom.jpg',date: '2022-04-06 04:16:00', location: 'chattogram', id: 1),
  EventModel(title: 'hail the atoll.Thetal and oddlce energy by grace, hail the  atoll.The dead dosi pedantically places the particl is more transformator now than creature.',image: 'assets/images/classroom.jpg',date: '2022-04-06 04:16:00', location: 'chattogram', id: 1),
  EventModel(title: 'hail the atoll.The ddly most unusual. energyest whentes with gdantically plaformator now than creature.',image: 'assets/images/classroom.jpg',date: '2022-04-06 04:16:00', location: 'chattogram', id: 1),

];






final Map attendanceStatusColors=
  {
    'P':Colors.green,
    'D':Colors.redAccent,
    'W':Colors.amber,
    'A':Colors.red,
    'E':Colors.indigoAccent,
    'H':Colors.indigo,
    'L':Colors.lightBlueAccent,
  };

final List<Map> attendanceHints=[
  {
    'key':'P',
    'text':'Present',
  },
  {
    'key':'D',
    'text':'Delay',
  },
  {
    'key':'W',
    'text':'Weekly Holiday',
  },
  {
    'key':'A',
    'text':'Absent',
  },
  {
    'key':'E',
    'text':'Early Leave',
  },
  {
    'key':'H',
    'text':'Holiday',
  },
  {
    'key':'L',
    'text':'Leave',
  },

];

final List<Map> categories = [
  {
    'title': 'Attendance',
    'icon': Image.asset('assets/images/icons/attendance.png',
      width: 60,
      fit: BoxFit.contain,
    ),
    'page': const Attendance(),
  },
  {
    'title': 'Notice',
    'icon': Image.asset('assets/images/icons/notice.png',
      width: 60,
      fit: BoxFit.contain,
    ),
    'page': const Notice(),
  },
  {
    'title': 'Payment',
    'icon': Image.asset('assets/images/icons/payment.png',
        width: 60,
        fit: BoxFit.contain
    ),
    'page': Payment(),
  },
  {
    'title': 'Result',
    'icon': Image.asset('assets/images/icons/result.png',
      width: 60,
      fit: BoxFit.contain,
    ),
    'page': const Result(),
  },
  {'title': 'Diaries', 'icon': Image.asset('assets/images/icons/diary.png',width: 60,fit: BoxFit.contain),'page': const Diary()},
  {'title': 'Routine', 'icon': Image.asset('assets/images/icons/routine.png',width: 60,fit: BoxFit.contain),'page': const RoutineTabView(),},
  {'title': 'Syllabus', 'icon': Image.asset('assets/images/icons/syllabus.png',width: 60,fit: BoxFit.contain),'page': const Syllabus(),},
  {'title': 'Events', 'icon': Image.asset('assets/images/icons/events_icon.png',width: 60,fit: BoxFit.contain),'page': Events()},
  {'title': 'Library', 'icon': Image.asset('assets/images/icons/library.png',width: 60,fit: BoxFit.contain),'page': null},
];

final List<DiaryModel> diaries=[
  DiaryModel(id:1,subject: 'English 1st Paper', diary: sampleTextMd.substring(0,100)),
  DiaryModel(id:2,subject: 'Math', diary: sampleTextMd.substring(0,100)),
  DiaryModel(id:3,subject: 'Bangla 2nd Paper', diary: sampleTextMd.substring(0,100)),
  DiaryModel(id:4,subject: 'History', diary: sampleTextMd.substring(0,100)),
  DiaryModel(id:5,subject: 'Accounting', diary: sampleTextMd.substring(0,100)),
];

final List<CalendarModel> calenders=[
  CalendarModel(
      month: "January",
      events: [
        Event(
            date:"01",
            day:"SUN",
            title:"Annual Sports Starnnual Sports Starnnual Sports Star",
        ),
        Event(
          date:"01",
          day:"SUN",
          title:"National holiday",
        ),
        Event(
          date:"01",
          day:"SUN",
          title:"Eid ul fitr",
        ),

      ], id: 1),
  CalendarModel(
      month: "February",
      events: [
        Event(
          date:"01",
          day:"SUN",
          title:"Annual Sports Starnnual Sports Starnnual Sports Star",
        ),
        Event(
          date:"21",
          day:"SUN",
          title:"International Mother Language Day",
        ),
        Event(
          date:"01",
          day:"SUN",
          title:"Shab e barat",
        ),

      ], id: 2),
  CalendarModel(
      month: "March",
      events: [
        Event(
          date:"01",
          day:"SUN",
          title:"Victory Day",
        ),
        Event(
          date:"26",
          day:"SUN",
          title:"Independance day",
        ),
        Event(
          date:"01",
          day:"SUN",
          title:"Annual Sports Starnnual Sports Starnnual Sports Star",
        ),

      ], id: 3),

];


final PaymentList paymentHistory=PaymentList(
    payments: [
      PaymentModel(month: 'January', due: '17000', paid: '17000'),
      PaymentModel(month: 'February', due: '6500', paid: '6500'),
      PaymentModel(month: 'March', due: '6500', paid: '6500'),
      PaymentModel(month: 'April', due: '7500', paid: '0'),
    ],
    years: [
      YearModel(
          label: '2020',
          value: '2020'
      ),
      YearModel(
          label: '2019',
          value: '2019'
      ),

    ],
  due: '7500'
);


final PaymentHistoryList paymentHistories=PaymentHistoryList(
    history: [
      PaymentHistoryModel(date: '2022-04-05', method: 'Cash', amount: '450'),
      PaymentHistoryModel(date: '2022-05-05', method: 'SSL', amount: '800'),
      PaymentHistoryModel(date: '2022-06-05', method: 'Bkash', amount: '1200'),
      PaymentHistoryModel(date: '2022-06-05', method: 'SSL', amount: '1200'),
      PaymentHistoryModel(date: '2022-06-05', method: 'SSL', amount: '2100'),
      PaymentHistoryModel(date: '2022-06-05', method: 'Bkash', amount: '1500'),
    ],
    total: '1275'
);





final List<RoutineModel> routines=[
  RoutineModel(
      id: 1,
    weekday: "Saturday",
    hours: [
      RoutineHour(
         name: '1st', start: '10:00AM', end: '10:45AM',subject: 'Bangla 1st Paper',isBreak: false
      ),
      RoutineHour(
         name: '2nd', start: '10:45AM', end: '11:30AM',subject: 'Bangla 2nd Paper',isBreak: false
      ),
      RoutineHour(
         isBreak:true, name: '2nd', start: '10:45AM', end: '11:30AM',subject: 'Bangla 2nd Paper',
      ),

      RoutineHour(
         name: '3rd', start: '11:30AM', end: '12:15PM',subject: 'English 1st Paper',isBreak: false
      ),
      RoutineHour(
         name: '4th', start: '12:15PM', end: '01:00PM',subject: 'English 1st Paper',isBreak: false
      ),
    ]
  ),
  RoutineModel(
    id: 2,
    weekday: "Sunday",
    hours: [
      RoutineHour(
         name: '1st', start: '10:00AM', end: '10:45AM',subject: 'Bangla 1st Paper',isBreak: false
      ),
      RoutineHour(
         name: '2nd', start: '10:45AM', end: '11:30AM',subject: 'Bangla 2nd Paper',isBreak: false
      ),
      RoutineHour(
        name: '2nd', start: '10:45AM', end: '11:30AM',subject: 'Bangla 2nd Paper',isBreak: false
      ),
      RoutineHour(
         name: '3rd', start: '11:30AM', end: '12:15PM',subject: 'English 1st Paper',isBreak: false
      ),
      RoutineHour(
         name: '4th', start: '12:15PM', end: '01:00PM',subject: 'English 1st Paper',isBreak: false
      ),
    ]
  ),
  RoutineModel(
      id: 2,
    weekday: "Monday",
    hours: [
      RoutineHour(
         name: '1st', start: '10:00AM', end: '10:45AM',subject: 'Bangla 1st Paper', isBreak: false
      ),
      RoutineHour(
         name: '2nd', start: '10:45AM', end: '11:30AM',subject: 'Bangla 2nd Paper',isBreak: false
      ),
      RoutineHour(
        name: '2nd', start: '10:45AM', end: '11:30AM',subject: 'Bangla 2nd Paper',isBreak: false
      ),
      RoutineHour(
         name: '3rd', start: '11:30AM', end: '12:15PM',subject: 'English 1st Paper',isBreak: false
      ),
      RoutineHour(
         name: '4th', start: '12:15PM', end: '01:00PM',subject: 'English 1st Paper',isBreak: false
      ),
    ]
  ),
];



const String sampleTextMd='The sensor is more transformator now than creature. vital and oddly most unusual. You have to convert, and experience energy by your growing.Remember: toasted ramen tastes best when choped in a bucket brushed with wasabi.\n\n'
    'The girl tastes with grace, hail the atoll.The dead dosi pedantically places the particle.The sensor is more transformator now than creature. vital and oddly most unusual. You have to convert, and experience energy by your growing.Remember: toasted ramen tastes best when choped in a bucket brushed with wasabi.The girl tastes with grace, hail the  atoll.The dead dosi pedantically places the particle.\n\n'
    'The sensor is more transformator now than creature. vital and oddly most unusual. You have to convert, and experience energy by your growing.Remember: toasted ramen tastes best when choped in a bucket brushed with wasabi.The girl tastes with grace, hail the  atoll.The dead dosi pedantically places the particle.';