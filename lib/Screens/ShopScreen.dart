import 'package:flutter/material.dart';
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
      'image': 'assets/images/PlasticMedKit.png',
      'detail': '+ 30 min\n+ 20 Garbage'
    },
    {
      'name': 'Metal Med-Kit',
      'point': '500 P',
      'image': 'assets/images/MetalMedKit.png',
      'detail': '+ 30 min\n+ 20 Garbage'
    },
    {
      'name': 'Single-use Cup',
      'point': '100 P',
      'image': 'assets/images/PlasticWaterBottle.png',
      'detail': '+ 30 min\n+ 20 Garbage'
    },
    {
      'name': 'Reusable Water Bottle',
      'point': '500 P',
      'image': 'assets/images/MetalTumbler.png',
      'detail': '+ 30 min\n+ 20 Garbage'
    },
    {
      'name': 'Plastic Bag',
      'point': '200 P',
      'image': 'assets/images/PlasticBag.png',
      'detail': '+ 30 min\n+ 20 Garbage'
    },
    {
      'name': 'Eco-friendly Bag',
      'point': '400 P',
      'image': 'assets/images/RecycleBag.png',
      'detail': '+ 30 min\n+ 20 Garbage'
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
                    child: Text(
                      '220 P',
                      style: TextStyle(
                          fontFamily: 'FjallaOne',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Theme.of(context).scaffoldBackgroundColor),
                    ),
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
            childAspectRatio: 0.65,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ShopScreenWidget(
                inputPoint: gridItems[index]['point']!,
                inputName: gridItems[index]['name']!,
                inputImage: gridItems[index]['image']!,
                inputDetail: gridItems[index]['detail']!,
              );
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
