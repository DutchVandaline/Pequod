import 'package:flutter/material.dart';
import 'package:pequod/API/ApiServices.dart';
import 'package:pequod/Widgets/ClimateCrisisTextWidget.dart';
import 'package:pequod/Widgets/ShopScreenWidget.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final List<Map<String, String>> gridItems = [
    {
      'name': 'Plastic Med-Kit',
      'point': '150 P',
      'image': 'assets/images/items/PlasticMedKit.png',
      'detail': '+ 20 min'
    },
    {
      'name': 'Metal Med-Kit',
      'point': '300 P',
      'image': 'assets/images/items/MetalMedKit.png',
      'detail': '+ 50 min'
    },
    {
      'name': 'Single-use Cup',
      'point': '100 P',
      'image': 'assets/images/items/PlasticWaterBottle.png',
      'detail': '+ 40 min'
    },
    {
      'name': 'Reusable Water Bottle',
      'point': '500 P',
      'image': 'assets/images/items/MetalTumbler.png',
      'detail': '+ 60 min'
    },
    {
      'name': 'Plastic Bag',
      'point': '200 P',
      'image': 'assets/images/items/PlasticBag.png',
      'detail': '+ 10 min'
    },
    {
      'name': 'Eco-friendly Bag',
      'point': '400 P',
      'image': 'assets/images/items/RecycleBag.png',
      'detail': '+ 50 min'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          snap: false,
          floating: true,
          centerTitle: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          scrolledUnderElevation: 0.0,
          title: ClimateChangeTextWidget("Shop"),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
            minHeight: 60.0,
            maxHeight: 60.0,
            child: Container(
              height: 60,
              decoration:
                  BoxDecoration(color: Theme.of(context).primaryColorLight),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'My Point',
                      style: TextStyle(
                          fontFamily: 'FjallaOne',
                          fontSize: 18.0,
                          color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: FutureBuilder(
                        future: ApiServices.getUser(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Text(
                                '0 P',
                                style: TextStyle(
                                    fontFamily: 'FjallaOne',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text(
                                '',
                                style: TextStyle(
                                  fontFamily: 'FjallaOne',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            );
                          } else {
                            Map<String, dynamic>? myPoint =
                                snapshot.data as Map<String, dynamic>;
                            return Text(
                              "${myPoint['points'].toString()} P",
                              style: TextStyle(
                                  fontFamily: 'FjallaOne',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                            );
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 0.0,
            childAspectRatio: 0.7,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return FutureBuilder(
                  future: ApiServices.getShop(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColorLight,
                      ));
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          "🏴‍☠️\nError Occurred",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0, fontFamily: 'FjallaOne'),
                        ),
                      );
                    } else {
                      List<dynamic> shopData = snapshot.data as List<dynamic>;
                      return ShopScreenWidget(
                        inputPoint:
                            "${shopData[index]['cost_point'].toString()} P",
                        inputName: shopData[index]['name'],
                        inputImage: shopData[index]['description'],
                        inputDetail:
                            "+ ${shopData[index]['receive_time'].toString()}",
                        //gridItems[index]['detail']!
                      );
                    }
                  });
            },
            childCount: gridItems.length,
          ),
        ),
      ],
    ));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
