import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pequod/Screens/MainScreen.dart';
import 'package:pequod/Screens/ShopScreen.dart';
import 'package:pequod/Services/ApiServices.dart';
import 'package:pequod/Widgets/CountdownWidget.dart';

int animal_id = 0;

class ShopScreenWidget extends StatefulWidget {
  final String inputImage;
  final String inputPoint;
  final String inputName;
  final String inputDetail;
  final int inputId;
  final VoidCallback onBuy;
  final int userPoint;

  const ShopScreenWidget(
      {super.key,
      required this.inputPoint,
      required this.inputName,
      required this.inputImage,
      required this.inputDetail,
      required this.inputId,
      required this.onBuy,
      required this.userPoint});

  @override
  State<ShopScreenWidget> createState() => _ShopScreenWidgetState();
}

class _ShopScreenWidgetState extends State<ShopScreenWidget> {
  @override
  Widget build(BuildContext context) {
    print(userPoint);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: GestureDetector(
        onTap: () {
          showBuyDialog(context, widget.inputId, widget.inputImage,
              widget.inputName, widget.inputDetail);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).canvasColor,
                  image: DecorationImage(
                    image: AssetImage(widget.inputImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0),
              child: Text(
                "${widget.inputPoint} P",
                style: TextStyle(
                  fontFamily: 'FjallaOne',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                widget.inputName,
                style: TextStyle(
                  fontFamily: 'FjallaOne',
                  fontSize: 16.0,
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 4.0),
              child: Text(
                widget.inputDetail,
                style: TextStyle(
                  fontFamily: 'FjallaOne',
                  fontSize: 15.0,
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showBuyDialog(BuildContext context, int inputId, String itemPath,
      String itemName, String itemDetail) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Buy Item',
              style: TextStyle(
                  fontFamily: 'ClimateCrisis', fontWeight: FontWeight.w600)),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                const Text('Do you really want to buy this item?',
                    style: TextStyle(fontSize: 17.0),
                    textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Image.asset(itemPath),
                ),
                Text(
                  itemName,
                  style:
                      const TextStyle(fontSize: 27.0, fontFamily: 'FjallaOne'),
                  textAlign: TextAlign.center,
                ),
                Text("You can get additional $itemDetail for your animal",
                    style: const TextStyle(
                        fontSize: 20.0, fontFamily: 'FjallaOne'),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: TextButton(
                    onPressed: () async {
                      Navigator.of(dialogContext).pop();
                      bool success =
                          (int.parse(widget.inputPoint) < widget.userPoint);
                      if (success) {
                        showWhomDialog(context, inputId);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Failed to buy item. Not enough points.',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'FjallaOne',
                                    fontSize: 20.0)),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
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

  void showWhomDialog(BuildContext context, int inputId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Select Animal',
              style: TextStyle(
                  fontFamily: 'ClimateCrisis', fontWeight: FontWeight.w600)),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                const Text('Which animal do you want to use this item with?',
                    style: TextStyle(fontSize: 17.0),
                    textAlign: TextAlign.center),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.27,
                  child: FutureBuilder(
                    future: ApiServices.getAnimal(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData &&
                          snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var animal = snapshot.data![index];
                            return GestureDetector(
                              onTap: () async {
                                setState(() {
                                  animal_id = animal['id'];
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0, vertical: 2.0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  decoration: BoxDecoration(
                                    color: animal_id == animal['id'] ? Colors.teal : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: Theme.of(context)
                                                .primaryColorLight,
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${animal['animal_name']}',
                                          style: const TextStyle(
                                              fontFamily: 'FjallaOne',
                                              fontSize: 22.0),
                                        ),
                                        Theme(
                                          data: Theme.of(context).copyWith(
                                            textTheme: Theme.of(context).textTheme.apply(
                                              fontSizeFactor: 0.5
                                            ),
                                          ),
                                          child: CountDownWidget(
                                            deadline: DateTime.parse(
                                                animal['animal_deadline']),
                                            dead: animal['dead'],
                                            inputTextStyle: TextStyle(
                                                fontFamily: 'FjallaOne',
                                                fontSize: 15.0,
                                                color: Theme.of(context).primaryColorLight),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ), // Assuming the data has 'id'
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Text('No animals available');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: TextButton(
                    onPressed: () async {
                      if(animal_id == 0){
                        print("select One");
                      } else {
                        bool success = await ApiServices.patchShopBuyItem(
                            inputId, animal_id);
                        if (success) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Purchase Successful!',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'FjallaOne',
                                    fontSize: 20.0)),
                            backgroundColor: Colors.teal,
                            duration: Duration(seconds: 2),
                          ));
                          Navigator.pushAndRemoveUntil(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, a1, a2) =>
                                const MainScreen(
                                  initialIndex: 0,
                                ),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                                  (route) => false);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Failed to buy item. Not enough points.',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'FjallaOne',
                                      fontSize: 20.0)),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      }

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
                              color: Theme.of(context).primaryColor,
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
}
