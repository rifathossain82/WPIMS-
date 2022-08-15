import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wpims/pages/home/controller/home_controller.dart';
import 'package:wpims/pages/partials/left_drawer.dart';
import 'package:wpims/pages/partials/top_bar.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/factory/faker.dart';
import 'package:wpims/utils/shapes/appbar_shape.dart';
import 'package:wpims/utils/shimmers.dart';
import 'package:wpims/utils/snackbars.dart';
import 'package:wpims/utils/widgets/helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  List<Map> categoryList = categories;
  List sliderImages = [];
  final controller = CarouselController();
  int activeIndex = 0;
  final homeCtrl = Get.find<HomeController>();
  // final HomeController homeCtrl = Get.put(HomeController());

  void animateToSlide(int index) {
    controller.animateToPage(index);
  }

  @override
  void initState() {
    sliderImages = homeCtrl.sliders;

    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    cacheCategoryImages(categoryList);
    super.didChangeDependencies();
  }

  void cacheCategoryImages(List categories) {
    for (var category in categories) {
      precacheImage(category['icon'].image, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: topBar(isCentered: true),
      drawer: leftDrawer(context),
      body: Container(
        height: size.height,
        child: Stack(children: [
          Container(
            width: size.width,
            color: colorPrimary,
          ),
          curvedBodyContainer(size.height),
          ListView(
            physics: const ScrollPhysics(),
            children: [
              Column(
                children: [
                  _topImageSlider(),
                  _buildSliderIndicator(),
                  addVerticalSpace(30),
                  Container(
                    width: size.width,
                    // color: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),

                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: categoryList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return categoryBuilder(categoryList[index]);
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ]),
      ),
    );
  }

  Widget categoryBuilder(Map category) {
    final size = MediaQuery.of(context).size;
    return isLoading
        ? _categoryShimmer()
        : Wrap(
            children: [
              Center(
                child: InkWell(
                  splashColor: colorPrimary.withOpacity(0.8),
                  onTap: () {
                    if (category['page'] != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => category['page']));
                    } else {
                      ShowWarningMsg(
                          context: context,
                          message: 'Coming Soon...',
                          duration: 2);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    width: size.width / 3.5,
                    height: size.width / 3.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: bgLight.withOpacity(0.8),
                      boxShadow: [
                        BoxShadow(
                          color: bgGrey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(3, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: category['icon'],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            category['title'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  Widget _topImageSlider() {
    final size = MediaQuery.of(context).size;
    return isLoading
        ? _sliderShimmer()
        : Container(
            width: size.width,
            margin: const EdgeInsets.all(10),
            child: CarouselSlider.builder(
              carouselController: controller,
              itemCount: sliderImages.length,
              options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  reverse: false,
                  viewportFraction: 1.0,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  onPageChanged: (index, reason) {
                    setState(() => activeIndex = index);
                  }),
              itemBuilder: (context, index, realIndex) {
                final image = CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: sliderImages[index].image,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                            color: colorPrimary,
                          ),
                        ),
                      ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                );
                return _buildSliderImage(image, index);
              },
            ),
          );
  }

  Widget _buildSliderImage(CachedNetworkImage sliderImage, int index) {
    return SizedBox(
      // margin: EdgeInsets.symmetric(horizontal: 10.0),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: sliderImage,
        ),
      ),
    );
  }

  Widget _buildSliderIndicator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: isLoading
          ? _indicatorShimmer()
          : AnimatedSmoothIndicator(
              onDotClicked: animateToSlide,
              activeIndex: activeIndex,
              count: sliderImages.length,
              effect: const JumpingDotEffect(
                  dotWidth: 10,
                  dotHeight: 10,
                  activeDotColor: colorPrimary,
                  dotColor: bgDark),
            ),
    );
  }

  Widget _sliderShimmer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
      child: ShimmerWidget.rectangularWithRadius(height: 180, radius: 25.0),
    );
  }

  Widget _categoryShimmer() {
    final size = MediaQuery.of(context).size;
    print(size.width);
    return Container(
      width: size.width / 3.5,
      height: size.width / 3.5,
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  ShimmerWidget.rectangularWithRadius(height: (size.width / 6)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ShimmerWidget.rectangularWithRadius(height: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _indicatorShimmer() {
    return Wrap(children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: const ShimmerWidget.circular(height: 10, width: 10),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: const ShimmerWidget.circular(height: 10, width: 10),
      ),
    ]);
  }
}
