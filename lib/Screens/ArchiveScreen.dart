import 'package:flutter/material.dart';
import 'package:pequod/API/ApiServices.dart';
import 'package:pequod/Constants/Constants.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>?>(
        future: ApiServices.getHabitStatus(
            Constants.changeDateFormat(DateTime.now())),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Error",
                style: TextStyle(
                  fontFamily: 'FjallaOne',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            List<dynamic>? archiveData = snapshot.data;
            if (archiveData != null && archiveData.isNotEmpty) {
              return CustomScrollView(
                slivers: [
                  SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 0.0,
                      crossAxisSpacing: 0.0,
                      childAspectRatio: 0.7,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        var item = archiveData[index];
                        return Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Habit ID: ${item['id']}'),
                              Text('Habit: ${item['habit']}'),
                              Text('Date: ${item['date']}'),
                            ],
                          ),
                        );
                      },
                      childCount: archiveData.length,
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text(
                  'No data available',
                  style: TextStyle(
                    fontFamily: 'FjallaOne',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              );
            }
          } else {
            return const Center(
              child: Text(
                'No data available',
                style: TextStyle(
                  fontFamily: 'FjallaOne',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
