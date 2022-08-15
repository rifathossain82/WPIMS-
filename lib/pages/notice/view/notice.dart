import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wpims/pages/list.dart';
import 'package:wpims/pages/news/view/news_list.dart';
import 'package:wpims/pages/notice/view/notice_list.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/shapes/appbar_shape.dart';
import 'package:wpims/utils/widgets/helper.dart';
import 'package:wpims/utils/widgets/texts.dart';

class Notice extends StatefulWidget {
  const Notice({Key? key}) : super(key: key);

  @override
  _NoticeState createState() => _NoticeState();
}

class _NoticeState extends State<Notice> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  void _handleTabSelection() {
    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'News & Notice',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
        backgroundColor: colorPrimary,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: size.height,
            color: colorPrimary,
          ),
          curvedBodyContainer(size.height),
          Column(
            children: [
              addVerticalSpace(10),
              TabBar(
                controller: _tabController,
                enableFeedback: true,
                indicatorSize: TabBarIndicatorSize.tab,
                // indicatorColor: colorPrimary,
                // indicatorWeight: 2.0,


                padding: EdgeInsets.symmetric(horizontal: 5.0),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  // borderRadius: BorderRadius.only(
                  //     bottomLeft: Radius.circular(10),
                  //     bottomRight: Radius.circular(10)),
                    color: colorPrimary.withOpacity(.1)
                ),

                tabs: [
                  Tab(child: subHeading('Notice',color: _tabController.index==1?colorPrimary:textDark)),
                  Tab(child: subHeading('News',color: _tabController.index==0?colorPrimary:textDark)),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    NoticeList(),
                    NewsList(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
