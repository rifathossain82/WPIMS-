import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wpims/pages/events/model/event_model.dart';
import 'package:wpims/pages/notice/model/notice_list_model.dart';
import 'package:wpims/pages/notice/view/notice_details.dart';
import 'package:wpims/pages/partials/top_bar.dart';
import 'package:wpims/services/api.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/factory/faker.dart';
import 'package:wpims/utils/image_view.dart';
import 'package:wpims/utils/marquee.dart';
import 'package:wpims/utils/shapes/appbar_shape.dart';
import 'package:wpims/utils/shimmers.dart';
import 'package:wpims/utils/widgets/helper.dart';
import 'package:wpims/utils/widgets/icons.dart';
import 'package:wpims/utils/widgets/texts.dart';

class EventDetails extends StatefulWidget {
  final int id;
  const EventDetails({Key? key,required this.id}):super(key: key);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  bool isLoading = true;
  late EventDetailsModel eventDetails;
  bool isEmptyData = false;
  String message = 'No Data Found';
  Random random = Random();

  Future _refresh() {
    setState(() {
      this.isLoading = true;
    });
    return getData();
  }

  Future getData() async {
    final response =
    await ApiService().get('event-details?id=' + widget.id.toString());
    if (response.statusCode == 200) {
      EventDetailsApi eventDetailsInstance = eventDetailsFromJson(response.body);
      eventDetails = eventDetailsInstance.event;
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
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        appBar: topBar(title: 'Event Details'),
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
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: const BorderRadius.all(const Radius.circular(8.0)),
                    boxShadow: [
                      BoxShadow(
                        color: bgGrey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset:
                            const Offset(3, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: isEmptyData
                      ? Center(
                    child: noData(),
                  )
                      : SingleChildScrollView(
                    child: isLoading?eventDetailsShimmer():Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 200.0,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0),
                            ),
                            child:FullScreenImage(
                              child: Image.network(
                                eventDetails.image,
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
                        ),
                        addVerticalSpace(10.0),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: topHeading(eventDetails.title,
                              maxLines: 20,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              lineHeight: 1.2),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric( horizontal: 15.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: iconText(
                                  icon: Icons.calendar_month,
                                  label: eventDetails.date,
                                  size: 12,
                                ),
                              ),
                              if (eventDetails.location != null)
                                Expanded(
                                  child: iconText(
                                    icon: Icons.location_pin,
                                    label: eventDetails.location ?? '',
                                    size: 12,
                                  ),
                                ),
                            ],
                          ),
                        ),

                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                            child: bodyTextNormal(eventDetails.body,textAlign: TextAlign.justify)),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget eventDetailsShimmer() {
    final size = MediaQuery.of(context).size;
    return Card(
        child: Container(
      width: size.width,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerWidget.rectangularWithRadius(height: 150),
          addVerticalSpace(10),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ShimmerWidget.rectangularWithRadius(height: 15)),
          addVerticalSpace(10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ShimmerWidget.rectangularWithRadius(
              height: 15,
              width: size.width - random.nextInt(150),
            ),
          ),
          addVerticalSpace(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Flexible(
                flex: 2,
                child: ShimmerWidget.rectangular(height: 10),
              ),
              Spacer(
                flex: 2,
              ),
              Flexible(
                flex: 2,
                child: ShimmerWidget.rectangular(height: 10),
              ),
            ],
          ),
          addVerticalSpace(10),
          ...List.generate(5, (index) => _shimmerRows())
        ],
      ),
    ));
  }

  Widget _shimmerRows() {
    return Column(
      children: [
        ShimmerWidget.rectangularWithRadius(height: 15),
        addVerticalSpace(5),
        ShimmerWidget.rectangularWithRadius(height: 15),
        addVerticalSpace(5),
        ShimmerWidget.rectangularWithRadius(height: 15),
        addVerticalSpace(5),
        ShimmerWidget.rectangularWithRadius(height: 15),
        addVerticalSpace(5),
        ShimmerWidget.rectangularWithRadius(height: 15),
        addVerticalSpace(5),
        ShimmerWidget.rectangularWithRadius(height: 15),
        addVerticalSpace(10),
      ],
    );
  }
}
