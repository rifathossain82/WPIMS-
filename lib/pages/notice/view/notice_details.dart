import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:wpims/pages/notice/model/notice_model.dart';
import 'package:wpims/pages/partials/top_bar.dart';
import 'package:wpims/services/api.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/file_system.dart';
import 'package:wpims/utils/image_view.dart';
import 'package:wpims/utils/shapes/appbar_shape.dart';
import 'package:wpims/utils/shimmers.dart';
import 'package:wpims/utils/snackbars.dart';
import 'package:wpims/utils/widgets/buttons.dart';
import 'package:wpims/utils/widgets/helper.dart';
import 'package:wpims/utils/widgets/icons.dart';
import 'package:wpims/utils/widgets/texts.dart';
import 'package:share_plus/share_plus.dart';

class NoticeDetails extends StatefulWidget {
  final int id;

  const NoticeDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<NoticeDetails> createState() => _NoticeDetailsState();
}

class _NoticeDetailsState extends State<NoticeDetails> {
  bool isLoading = true;
  bool isEmptyData = false;
  late NoticeDetailsModel notice;
  String message = 'No Data Found';
  bool isDownloading = false;
  double progress = 0;
  final ScreenshotController _screenshotController = ScreenshotController();

  Future getData() async {
    final response =
        await ApiService().get('notice-details?id=' + widget.id.toString());
    if (response.statusCode == 200) {
      NoticeDetailsApi noticeInstance = noticeDetailsFromJson(response.body);
      notice = noticeInstance.notice;
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
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: topBar(title: 'Notice Details'),
      body: Stack(
        children: [
          Container(
            height: size.height,
            color: colorPrimary,
          ),
          curvedBodyContainer(size.height),
          isEmptyData
              ? Center(
                  child: noData(),
                )
              : SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(15.0),
                    child: isLoading
                        ? noticeShimmer()
                        : Column(
                            children: [
                              Screenshot(
                                controller: _screenshotController,
                                child: Container(
                                  color: colorSecondary,
                                  child: Column(
                                    children: [
                                      topHeading(notice.title,
                                          maxLines: 10,
                                          fontWeight: FontWeight.bold,
                                          textAlign: TextAlign.left),
                                      addVerticalSpace(5.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          iconText(
                                              icon: Icons.calendar_month,
                                              label: notice.date),
                                          if (notice.type != null)
                                            iconText(
                                                icon:
                                                    Icons.announcement_outlined,
                                                label: notice.type!),
                                          iconText(
                                              icon: Icons.tag,
                                              label: notice.category)
                                        ],
                                      ),
                                      addVerticalSpace(15),
                                      bodyTextNormal(notice.body,
                                          textAlign: TextAlign.justify),
                                      if (notice.image != null)
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10.0),
                                          constraints: const BoxConstraints(
                                            minHeight: 150,
                                          ),
                                          child: FullScreenImage(
                                            child: Image.network(
                                              notice.image!,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: colorPrimary,
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              addVerticalSpace(30.0),
                              if (notice.image != null)
                                elevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        isDownloading = true;
                                      });
                                      downloadFile(
                                          url: notice.image!,
                                          onComplete: () {
                                            setState(() {
                                              isDownloading = false;
                                            });
                                            ShowSuccessMsg(
                                                context: context,
                                                message:
                                                    'File downloaded successfully');
                                          });
                                    },
                                    label: 'Download Attachment',
                                    padding: 15,
                                    width: size.width - 100,
                                    btnLoading: isDownloading),
                              addVerticalSpace(10.0),
                              elevatedButton(
                                onPressed: () {
                                  captureAndSave(
                                      controller: _screenshotController,
                                      onComplete: () {
                                        ShowSuccessMsg(
                                            context: context,
                                            message:
                                                'Screenshot Saved to Gallery!');
                                      });
                                },
                                label: 'ScreenShot',
                                padding: 15,
                                width: size.width - 100,
                              ),
                            ],
                          ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget noticeShimmer() {
    final size = MediaQuery.of(context).size;
    return Card(
        child: Container(
      width: size.width,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerWidget.rectangularWithRadius(height: 35),
          addVerticalSpace(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
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
          ),
          addVerticalSpace(10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
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
              Spacer(flex: 20)
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
