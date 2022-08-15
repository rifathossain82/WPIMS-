import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/marquee.dart';
import 'package:wpims/utils/shimmers.dart';
import 'package:wpims/utils/widgets/helper.dart';
import 'package:wpims/utils/widgets/texts.dart';

class NoticeListExpandable extends StatefulWidget {
  NoticeListExpandable({Key? key}) : super(key: key);

  @override
  _NoticeListExpandableState createState() => _NoticeListExpandableState();
}

class _NoticeListExpandableState extends State<NoticeListExpandable> {
  bool isLoading = true;
  bool _tileExpanded = false;
  List<Map<dynamic, dynamic>> items = [
    {
      'title':'Nunquam amor abactor Flatten a dozen escargots',
      'body':'Nunquam amor abactor Flatten a dozen escargots, lentils, and thyme in a large ice blender over medium heat, roast for four minutes and flavor with some marshmellow..',
      'date': 'just now',
    },
    {
      'title':'Dozen four minutes and a dozen escargots',
      'body':'Nunquam amor abactor Flatten a dozen escargots, lentils, and thyme in a large ice blender over medium heat, roast for four minutes and a dozen escargots, lentils, and thyme in a large ice blender over medium heat, roast for four minutes and flavor with some marshmellow..',
      'date': '3 hours ago',
    },
    {
      'title':'Abactor Flatten a dozen escargots 1',
      'body':'Nunquam amor abactor Flatten a dozen escargots,  Flatten a dozen escargots,  Flatten a dozen escargots, lentils, and thyme in a large ice blender over medium heat, roast for four minutes and flavor with some marshmellow..',
      'date': '2 weak ago',
    },
    {
      'title':'Abactor Flatten a dozen escargots 2',
      'body':'Nunquam amor abactor Flatten a dozen escargots, lentils, and thyme in a large ice blender over medium heat, roast for fourhmellow..',
      'date': '25th january 2022',
    },
    {
      'title':'four minutes and flavor with some marshmellow',
      'body':'Nunquam amor abactor Flatten a and thyme in a large ice blender over medium heat, roast for four minutes and flavor with some marshmellow..',
      'date': 'a weak ago',
    },
    {
      'title': 'Dozen escargots, lentils, and thyme 1',
      'body': 'roast for four minutes and flavor with some marshmellow..',
      'date': 'just now',
    },
    {
      'title': 'dozen escargots, lentils, and thyme 1',
      'body':'Nunquam amor abactor Flatten a dozen escargots, lentils, and thyme in a large ice blender over medium heat, roast for four minutes and flavor with some marshmellow..',
      'date': 'a weak ago',
    },
    {
      'title':'Dozen escargots, lentils, and thyme 1',
      'body':'Nunquam amor abactor Flatten a dozen escargots, lentils, and thyme in a large ice blender over medium heat, roast for four minutes and flavor with some marshmellow..',
      'date': '25th january 2022',
    },
  ];

  Future _refresh() {
    setState(() {
      this.isLoading = true;
    });
    return getData();
  }

  Future getData() async {
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.separated(
            itemCount: isLoading ? 8 : items.length,
            physics: ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              {
                if (isLoading) {
                  return NoticeListExpandableShimmer();
                }
                return Container(
                    decoration: BoxDecoration(
                      color: backgroundColor.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10)),
                    child: ExpansionTile(
                      expandedAlignment: Alignment.topCenter,
                      expandedCrossAxisAlignment: CrossAxisAlignment.center,
                      title: subHeading(items[index]['title'],textAlign: TextAlign.left),
                      subtitle: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 5.0
                          ),
                          child: hintText(items[index]['date'])),
                      onExpansionChanged: (bool expanded) {
                        setState(() => _tileExpanded = expanded);
                      },
                      childrenPadding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10
                      ),
                      iconColor: colorPrimary,
                      children: [
                        bodyTextNormal(items[index]['body'],textAlign: TextAlign.justify)
                      ],
                    ));
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
            // offAxisFraction: 1.5,
          ),
        ),
      ),
    );
  }

  Widget NoticeListExpandableShimmer() {
    return ListTile(
      leading: ShimmerWidget.rectangularWithRadius(width: 50, height: 50),
      title: const Align(
          alignment: Alignment.centerLeft,
          child: ShimmerWidget.rectangular(
            height: 10,
            width: 100,
          )),
      subtitle: ShimmerWidget.rectangular(height: 10),
    );
  }
}
