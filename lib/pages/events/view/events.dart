import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wpims/pages/events/model/event_list_model.dart';
import 'package:wpims/pages/events/view/event_details.dart';
import 'package:wpims/pages/partials/top_bar.dart';
import 'package:wpims/services/api.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/factory/faker.dart';
import 'package:wpims/utils/image_view.dart';
import 'package:wpims/utils/shapes/appbar_shape.dart';
import 'package:wpims/utils/shimmers.dart';
import 'package:wpims/utils/widgets/helper.dart';
import 'package:wpims/utils/widgets/icons.dart';
import 'package:wpims/utils/widgets/texts.dart';

class Events extends StatefulWidget {
  Events({Key? key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  bool isLoading = true;
  bool isEmptyData = false;
  int page=1;
  bool hasMorePage=true;
  String message='No Data Found';
  List<EventModel> items = [];
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
    final response=await ApiService().get('events?page='+page.toString());
    if(response.statusCode==200) {
      EventListApi newsInstance = eventsFromJson(response.body);
      items.addAll(newsInstance.events);
      if(newsInstance.meta.to==newsInstance.meta.total){
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
  void dispose(){
    controller.dispose();
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
        appBar: topBar(title: 'Events'),
        body: Container(
          alignment: Alignment.topCenter,
          constraints:
          BoxConstraints(minHeight: size.height, minWidth: size.width),
          child: Stack(
            children: [
              Container(
                height: size.height,
                color: colorPrimary,
              ),
              curvedBodyContainer(size.height),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                child: ListView.separated(
                  itemCount: isLoading ? 8 : items.length,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    {
                      if (isLoading) {
                        return EventsShimmer();
                      }

                      if(index==0){
                        return Column(
                          children: [
                            Container(
                              width:double.infinity,
                              decoration: BoxDecoration(
                                  color: darkBlue,
                                  borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: TextButton(
                                onPressed: (){},
                                child: subHeading('Browse All Events', color: textLight),
                              ),
                            ),
                            addVerticalSpace(20),
                            _buildEventCard(index)
                          ],
                        );
                      }

                      return _buildEventCard(index);
                    }
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return addVerticalSpace(20);
                  },
                  // offAxisFraction: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildEventCard(int index){
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                EventDetails(id: items[index].id),
          ),
        );
      },
      child: Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius:
            BorderRadius.all(Radius.circular(8.0)),
            boxShadow: [
              BoxShadow(
                color: bgGrey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(3, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 150.0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Image.network(
                    items[index].image,
                    fit: BoxFit.fill,
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
                ),
              addVerticalSpace(10.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: topHeading(items[index].title,
                    maxLines: 3,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    lineHeight: 1.2),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: iconText(
                        icon: Icons.calendar_month,
                        label: items[index].date,
                        size: 12,
                      ),
                    ),

                    // if (items[index].location != null)
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: iconText(
                          icon: Icons.location_pin,
                          label: items[index].location,
                          size: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget EventsShimmer() {
    final size = MediaQuery.of(context).size;
    return Card(
        child: Container(
          width: size.width,
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerWidget.rectangularWithRadius(height: 150),
              addVerticalSpace(10),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                  child: ShimmerWidget.rectangularWithRadius(height: 15)
              ),
              addVerticalSpace(10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                child: ShimmerWidget.rectangularWithRadius(
                  height: 15,
                  width: size.width - random.nextInt(150),
                ),
              ),
              addVerticalSpace(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: ShimmerWidget.rectangular(height: 10),
                  ),
                  Spacer(flex: 2,),
                  Flexible(
                    flex: 2,
                    child: ShimmerWidget.rectangular(height: 10),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
