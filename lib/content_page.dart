import 'package:flutter/material.dart';
import 'configurations.dart';
import 'attendance_model.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: const Text("Content"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      body: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: Configurations.attendanceNotifier,
          builder: (context, value, child) {

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),

              itemCount: value.length,

              itemBuilder: (context, index) {

                Attendance record = value[index];

                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {

                        return AlertDialog(
                          title: Text("Update Attendance"),
                          content: Text("Select attendance status for ${record.getDate()}"),

                          actions: [

                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel"),
                            ),

                            TextButton(
                              onPressed: () {

                                record.setStatus(1);

                                Configurations.attendanceNotifier.value =
                                    List.from(Configurations.attendance);

                                Navigator.pop(context);
                              },
                              child: Text("Present"),
                            ),

                            TextButton(
                              onPressed: () {

                                record.setStatus(0);

                                Configurations.attendanceNotifier.value =
                                    List.from(Configurations.attendance);

                                Navigator.pop(context);
                              },
                              child: Text("Absent"),
                            ),

                          ],
                        );

                      },
                    );

                  },

                  child: Container(
                    margin: const EdgeInsets.all(10),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                      children: [

                        Text(
                          record.getDate(),
                          style: const TextStyle(fontSize: 20),
                        ),

                        CircleAvatar(
                          backgroundColor:
                              record.getStatus() == 1 ? Colors.green : Colors.red,

                          child: Text(
                            record.getStatus() == 1 ? "P" : "A",
                            style: record.getStatus() == 1
                                ? null
                                : const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        )
      ),
    );
  }
}