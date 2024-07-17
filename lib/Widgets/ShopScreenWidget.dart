import 'package:flutter/material.dart';

class ShopScreenWidget extends StatefulWidget {
  String inputImage;
  String inputPoint;
  String inputName;
  String inputDetail;


  ShopScreenWidget(
      {super.key,
      required this.inputPoint,
      required this.inputName,
      required this.inputImage,
      required this.inputDetail});

  @override
  State<ShopScreenWidget> createState() => _ShopScreenWidgetState();
}

class _ShopScreenWidgetState extends State<ShopScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: GestureDetector(
        onTap: (){
          print(widget.inputName);
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
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
