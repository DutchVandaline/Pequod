import 'package:flutter/material.dart';
import 'package:pequod/Widgets/ClimateCrisisTextWidget.dart';
import 'package:pequod/Widgets/ShopScreenWidget.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: false,
          snap: false,
          floating: true,
          centerTitle: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          scrolledUnderElevation: 0.0,
          title: ClimateChangeTextWidget("Shop"),
          expandedHeight: 90.0,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(
                "🪙 120",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            )
          ],
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 50,
            child: Center(
              child: Text(
                'Buying things can affect others.\nThink about the effects before you buy.',
                style: TextStyle(fontFamily: 'Pretendard',fontSize: 18.0,),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ShopScreenWidget(inputTitle: "food", inputWidget: "hello",);
            },
            childCount: 3,
          ),
        ),
      ],
    ));
  }
}

