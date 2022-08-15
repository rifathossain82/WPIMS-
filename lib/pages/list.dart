import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';
import 'package:wpims/pages/partials/top_bar.dart';
import 'package:wpims/utils/constants/colors.dart';
import 'package:wpims/utils/shimmers.dart';
import 'package:wpims/utils/widgets/helper.dart';

class DummyList extends StatefulWidget {
  DummyList({Key? key}) : super(key: key);

  @override
  _DummyListState createState() => _DummyListState();
}

class _DummyListState extends State<DummyList> {
  bool isLoading=true;
  List<Map<dynamic,dynamic>> items = [
    {
      'name':'customer name',
      'phone':'01737450256',
      'weight': 10.5,
      'amount':1200,
      'added':'two minitues ago',
      'status':'pending',
    },
    {
      'name':'customer name2',
      'phone':'01737450256',
      'weight': 10.5,
      'amount':1200,
      'added':'two minitues ago',
      'status':'pending',
    },
    {
      'name':'customer name3',
      'phone':'01737450256',
      'weight': 10.5,
      'amount':1200,
      'added':'two minitues ago',
      'status':'pending',
    },
    {
      'name':'customer name4',
      'phone':'01737450256',
      'weight': 10.5,
      'amount':1200,
      'added':'two minitues ago',
      'status':'pending',
    },
    {
      'name':'customer name5',
      'phone':'01737450256',
      'weight': 10.5,
      'amount':1200,
      'added':'two minitues ago',
      'status':'pending',
    },
{
      'name':'customer name5',
      'phone':'01737450256',
      'weight': 10.5,
      'amount':1200,
      'added':'two minitues ago',
      'status':'pending',
    },
{
      'name':'customer name5',
      'phone':'01737450256',
      'weight': 10.5,
      'amount':1200,
      'added':'two minitues ago',
      'status':'pending',
    },
{
      'name':'customer name5',
      'phone':'01737450256',
      'weight': 10.5,
      'amount':1200,
      'added':'two minitues ago',
      'status':'pending',
    },
{
      'name':'customer name5',
      'phone':'01737450256',
      'weight': 10.5,
      'amount':1200,
      'added':'two minitues ago',
      'status':'pending',
    },
{
      'name':'customer name5',
      'phone':'01737450256',
      'weight': 10.5,
      'amount':1200,
      'added':'two minitues ago',
      'status':'pending',
    },

  ];

  Future _refresh() {
    setState(() {
      this.isLoading=true;
    });
    return getData();
  }

  Future getData() async{
   await Future.delayed(
     Duration(seconds: 1),(){
       setState(() {
         isLoading=false;
       });
     }
   );
  }
  @override
  void initState(){
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        appBar: topBar(title: 'List View'),
        body: Container(
          alignment: Alignment.topCenter,
          constraints: BoxConstraints(minHeight: size.height, minWidth: size.width),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.separated(
              itemCount: isLoading?8:items.length,
              physics: ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  {
                    if(isLoading){
                      return DummyListShimmer();
                    }
                    if(index==0) {
                      return Column(
                        children: [
                          //Summary view
                          Container(
                            width: size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: SummaryCard(
                                      title: 'Paid',
                                      amount: '100',
                                      color: successColor
                                  ),
                                ),
                                Flexible(
                                  child: SummaryCard(
                                      title: 'Pending',
                                      amount: '100',
                                      color: warningColor
                                  ),
                                ),
                                Flexible(
                                  child: SummaryCard(
                                      title: 'Cancelled',
                                      amount: '100',
                                      color: dangerColor
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          //first slideable with index 0
                          Container(
                            decoration: BoxDecoration(
                                color: backgroundColor.withOpacity(.1),
                                borderRadius: BorderRadius.circular(10)
                            ),

                            child: ListTile(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //
                                // );
                              },
                              leading: Image.asset(
                                'assets/images/logo.png',
                                width: 50,
                                height: 50,
                              ),
                              title: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                children: [
                                  Text(items[index]['name']),
                                  Text("\$ ${items[index]['amount'].toString()}"),
                                ],
                              ),
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(items[index]['phone']),
                                  Text(items[index]['status']),
                                  Text("${items[index]['weight'].toString()} kg"),
                                ],
                              ),

                            ),

                          ),
                        ],
                      );

                    }
                    return Container(
                      decoration: BoxDecoration(
                        color: backgroundColor.withOpacity(.1),
                        borderRadius: BorderRadius.circular(10)
                      ),

                      child: ListTile(
                        onTap: (){
                          // Navigator.push(
                          //     context,
                          //     PageScaleTransiton(
                          //         child: PaymentView(item:items[index])
                          //     )
                          // );
                        },
                        leading: Image.asset(
                          'assets/images/logo.png',
                          width: 50,
                          height: 50,
                        ),
                        title: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            Text(items[index]['name']),
                            Text("\$ ${items[index]['amount'].toString()}"),
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(items[index]['phone']),
                            Text(items[index]['status']),
                            Text("${items[index]['weight'].toString()} kg"),
                          ],
                        ),

                      ),
                    );
                  }
                },
                separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                },
              // offAxisFraction: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget DummyListShimmer(){
    return ListTile(
      leading: ShimmerWidget.rectangularWithRadius(width: 50, height: 50),
      title: Align(alignment:Alignment.centerLeft,
          child: ShimmerWidget.rectangular(height: 10,width: 100,)),
      subtitle: ShimmerWidget.rectangular(height: 10),
    );
  }

  Widget SummaryCard({required String title,required String amount, required Color color }){
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
            color: backgroundColor
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            amount,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color
            ),
          ),
          addVerticalSpace(5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }

}


