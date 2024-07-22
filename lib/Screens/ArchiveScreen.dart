import 'package:flutter/material.dart';
import 'package:pequod/API/ApiServices.dart';
import 'package:pequod/Widgets/ClimateCrisisTextWidget.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0.0,
        title: ClimateChangeTextWidget("Archive"),
      ),
      body: FutureBuilder<List<dynamic>?>(
        future: ApiServices.getHabitStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                "🏴‍☠️ Error",
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
              archiveData.sort((a, b) {
                int dateComparison = a['date'].compareTo(b['date']);
                if (dateComparison == 0) {
                  return a['habit_name'].compareTo(b['habit_name']);
                }
                return dateComparison;
              });

              // Group the data by date
              Map<String, List<dynamic>> groupedData = {};
              for (var item in archiveData) {
                String date = item['date'];
                if (!groupedData.containsKey(date)) {
                  groupedData[date] = [];
                }
                groupedData[date]!.add(item);
              }

              return CustomScrollView(
                slivers: groupedData.entries.map((entry) {
                  String date = entry.key;
                  List<dynamic> items = entry.value;
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              date,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }
                        var item = items[index - 1];
                        return Card(
                          child: ListTile(
                            title: Text('Habit: ${item['habit']}'),
                            subtitle: Text('Habit ID: ${item['id']}'),
                          ),
                        );
                      },
                      childCount: items.length + 1, // +1 for the date header
                    ),
                  );
                }).toList(),
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
