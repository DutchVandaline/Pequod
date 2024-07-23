import 'package:flutter/material.dart';
import 'package:pequod/API/ApiServices.dart';
import 'package:pequod/Widgets/ClimateCrisisTextWidget.dart';
import 'SplashScreen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ClimateChangeTextWidget("Account"),
        centerTitle: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leadingWidth: 40.0,
        elevation: 0.0,
        shadowColor: Colors.transparent,
      ),
      body: FutureBuilder(
        future: ApiServices.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Please try later.",
                textAlign: TextAlign.center,
              ),
            );
          } else {
            if (snapshot.data == null) {
              return const SizedBox.shrink();
            }
            Map<String, dynamic>? UserData =
                snapshot.data as Map<String, dynamic>;
            return Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Text("User info"),
                    ),
                    ProfileWidget(
                      inputData: UserData,
                      requireQuery: 'name',
                      inputText: "Name",
                    ),
                    ProfileWidget(
                      inputData: UserData,
                      requireQuery: 'email',
                      inputText: "Email",
                    ),
                    ProfileWidget(
                      inputData: UserData,
                      requireQuery: 'points',
                      inputText: "Points",
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Text(
                        "Danger Zone",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDeleteDialog(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50.0,
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .canvasColor
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15.0)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Icon(Icons.phonelink_erase),
                                    ),
                                    SizedBox(width: 20.0),
                                    Text("Delete Account"),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20.0),
                                  child: Icon(Icons.arrow_forward_ios),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                )
              ],
            );
          }
        },
      ),
    );
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Account Delete'),
          backgroundColor: Theme.of(context).primaryColor,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: const Text(
              'Do you really want to delete your account?\n Every data will be removed permanently.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Theme.of(context).primaryColorLight),
              ),
            ),
            TextButton(
              onPressed: () async {
                await ApiServices.eraseUser().then((value) =>
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SplashScreen()),
                        (route) => false));
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Theme.of(context).primaryColorLight),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ProfileWidget extends StatefulWidget {
  const ProfileWidget(
      {Key? key,
      required this.inputData,
      required this.requireQuery,
      required this.inputText})
      : super(key: key);

  final dynamic inputData;
  final String inputText;
  final String requireQuery;

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 60.0,
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  widget.inputText,
                  style: const TextStyle(overflow: TextOverflow.fade),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Text(widget.inputData[widget.requireQuery].toString()),
              )
            ],
          ),
        ));
  }
}