import 'package:flutter/material.dart';
import 'package:wpims/pages/partials/top_bar.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/factory/faker.dart';
import 'package:wpims/utils/image_view.dart';
import 'package:wpims/utils/shapes/appbar_shape.dart';
import 'package:wpims/utils/widgets/buttons.dart';
import 'package:wpims/utils/widgets/helper.dart';
import 'package:wpims/utils/widgets/icons.dart';
import 'package:wpims/utils/widgets/texts.dart';

class Syllabus extends StatelessWidget {
  const Syllabus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: topBar(title: 'Syllabus'),
      body: Stack(
        children: [
          Container(
            height: size.height,
            color: colorPrimary,
          ),
          curvedBodyContainer(size.height),
          SingleChildScrollView(
            child: Container(
              width: size.width,
              margin: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  addVerticalSpace(15.0),
                  Container(
                    constraints: BoxConstraints(
                      minHeight: size.height*.60
                    ),
                    child: FullScreenImage(
                      child: Image.network(
                          'https://i.ibb.co/KqSqPtW/1595580085047-routine.jpg',
                        alignment: Alignment.center,
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
                  elevatedButton(
                    onPressed: (){

                    },
                    label: 'Download Attachment',
                    padding: 15,
                    width: size.width-100,
                  ),
                  addVerticalSpace(10.0),
                  elevatedButton(
                    onPressed: (){

                    },
                    label: 'ScreenShot',
                    padding: 15,
                    width: size.width-100,
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


}
