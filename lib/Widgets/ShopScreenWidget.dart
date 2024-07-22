import 'package:flutter/material.dart';
import 'package:pequod/API/ApiServices.dart';

class ShopScreenWidget extends StatefulWidget {
  final String inputImage;
  final String inputPoint;
  final String inputName;
  final String inputDetail;
  final int inputId;
  final VoidCallback onBuy;

  ShopScreenWidget({
    super.key,
    required this.inputPoint,
    required this.inputName,
    required this.inputImage,
    required this.inputDetail,
    required this.inputId,
    required this.onBuy,
  });

  @override
  State<ShopScreenWidget> createState() => _ShopScreenWidgetState();
}

class _ShopScreenWidgetState extends State<ShopScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: GestureDetector(
        onTap: () {
          showBuyDialog(
              context,
              widget.inputId,
              widget.onBuy,
              widget.inputImage,
              widget.inputName,
              widget.inputDetail); // Pass the callback
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage(widget.inputImage),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      widget.inputPoint,
                      style: TextStyle(
                          fontFamily: 'FjallaOne',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Theme.of(context).primaryColorLight),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      widget.inputName,
                      style: TextStyle(
                          fontFamily: 'FjallaOne',
                          fontSize: 16.0,
                          color: Theme.of(context).primaryColorLight),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      widget.inputDetail,
                      style: TextStyle(
                          fontFamily: 'FjallaOne',
                          fontSize: 15.0,
                          color: Theme.of(context).primaryColorLight),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

void showBuyDialog(BuildContext context, int inputId, VoidCallback onBuy,
    String itemPath, String itemName, String itemDetail) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Buy Item',
          style: TextStyle(
              fontFamily: 'ClimateCrisis', fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Do you really want to buy this item?',
              style: TextStyle(fontSize: 17.0),
              textAlign: TextAlign.center,
            ),
            Image.asset(itemPath),
            Text(itemName,
                style: TextStyle(fontSize: 27.0, fontFamily: 'FjallaOne')),
            Text(
              "You can get additional\n${itemDetail} for your animal",
              style: TextStyle(fontSize: 20.0, fontFamily: 'FjallaOne'),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        actions: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Theme.of(context).primaryColorLight),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: TextButton(
                  onPressed: () async {
                    await ApiServices.patchShopBuyItem(inputId);
                    Navigator.pop(context);
                    onBuy();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 50.0,
                    decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Center(
                      child: Text(
                        'Buy',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontFamily: 'FjallaOne',
                            fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

        ],
      );
    },
  );
}
