import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pequod/API/ApiServices.dart';
import 'package:pequod/Widgets/ClimateCrisisTextWidget.dart';

String inputDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

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
        scrolledUnderElevation: 0.0,
        title: ClimateChangeTextWidget("Archive"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              DateFormat("MMMM yyyy").format(DateTime.now()),
              style: const TextStyle(fontSize: 24.0, fontFamily: 'FjallaOne'),
            ),
          ),
          FutureBuilder<List<dynamic>?>(
            future: ApiServices.getMonthlyHabitStatus("2024-07"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                print(snapshot.error);
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
                  Map<int, int> dayCounts = {};
                  for (var entry in archiveData) {
                    String dateStr = entry['date'];
                    int count = entry['count'];
                    DateTime date = DateTime.parse(dateStr);
                    dayCounts[date.day] = count;
                  }

                  String dateStr = archiveData.last['date'];
                  DateTime date = DateTime.parse(dateStr);
                  String dateForParse = DateFormat("yyyy-MM").format(date);
                  int daysInMonth = DateTime(date.year, date.month + 1, 0).day;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 7),
                          itemBuilder: (context, index) {
                            int day = index + 1;
                            int count = dayCounts[day] ?? 0;

                            double opacity;
                            count == 0
                                ? opacity = 0.0
                                : opacity = (count / 8).clamp(0.0, 1.0);
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    inputDate =
                                        "$dateForParse-${day.toString().padLeft(2, '0')}";
                                    print(inputDate);
                                  });
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1 / 1,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height * 0.4,
                                        decoration: BoxDecoration(
                                            color: Colors.teal
                                                .withOpacity(opacity),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColorLight
                                                    .withOpacity(0.2))),
                                        child: Text(
                                          "$day",
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              fontFamily: 'FjallaOne'),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      count == 0 ? "" : "$count",
                                      style: const TextStyle(fontSize: 20.0),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: daysInMonth),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      '📡 Nothing to fetch...',
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
                    '📡 Nothing to fetch...',
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
          Text(inputDate),
          FutureBuilder<List<dynamic>?>(
            future: ApiServices.getTodayHabitStatus(inputDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                print(snapshot.error);
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
                List<dynamic>? archiveDailyData = snapshot.data;
                if (archiveDailyData != null && archiveDailyData.isNotEmpty) {
                  return Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: Theme.of(context).primaryColorLight)
                                ),
                                child: Center(
                                  child: Text(
                                    archiveDailyData[index]['habit_name'],
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        fontFamily: 'FjallaOne'),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: archiveDailyData.length),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      '📡 No Habits are Recorded...',
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
                    '📡 No Habits are Recorded...',
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
        ],
      ),
    );
  }
}

//Fetch all and sort daily
//FutureBuilder<List<dynamic>?>(
//         future: ApiServices.getMonthlyHabitStatus("2024-07"),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             print(snapshot.error);
//             return const Center(
//               child: Text(
//                 "🏴‍☠️ Error",
//                 style: TextStyle(
//                   fontFamily: 'FjallaOne',
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20.0,
//                 ),
//               ),
//             );
//           } else if (snapshot.hasData) {
//             List<dynamic>? archiveData = snapshot.data;
//             if (archiveData != null && archiveData.isNotEmpty) {
//               archiveData.sort((a, b) {
//                 int dateComparison = a['date'].compareTo(b['date']);
//                 if (dateComparison == 0) {
//                   return a['habit_name'].compareTo(b['habit_name']);
//                 }
//                 return dateComparison;
//               });
//
//               // Group the data by date
//               Map<String, List<dynamic>> groupedData = {};
//               for (var item in archiveData) {
//                 String date = item['date'];
//                 if (!groupedData.containsKey(date)) {
//                   groupedData[date] = [];
//                 }
//                 groupedData[date]!.add(item);
//               }
//
//               return CustomScrollView(
//                 slivers: groupedData.entries.map((entry) {
//                   String date = entry.key;
//                   List<dynamic> items = entry.value;
//                   return SliverList(
//                     delegate: SliverChildBuilderDelegate(
//                           (context, index) {
//                         if (index == 0) {
//                           return Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               date,
//                               style: const TextStyle(
//                                 fontSize: 20.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           );
//                         }
//                         var item = items[index - 1];
//                         return Card(
//                           child: ListTile(
//                             title: Text('Habit: ${item['habit']}'),
//                             subtitle: Text('Habit ID: ${item['id']}'),
//                           ),
//                         );
//                       },
//                       childCount: items.length + 1, // +1 for the date header
//                     ),
//                   );
//                 }).toList(),
//               );
//             } else {
//               return const Center(
//                 child: Text(
//                   'No data available',
//                   style: TextStyle(
//                     fontFamily: 'FjallaOne',
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20.0,
//                   ),
//                 ),
//               );
//             }
//           } else {
//             return const Center(
//               child: Text(
//                 'No data available',
//                 style: TextStyle(
//                   fontFamily: 'FjallaOne',
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20.0,
//                 ),
//               ),
//             );
//           }
//         },
//       ),
