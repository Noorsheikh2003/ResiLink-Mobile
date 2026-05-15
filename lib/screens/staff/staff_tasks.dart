import 'package:flutter/material.dart';
import 'staff_task_detail.dart';
import 'staff_task_data.dart';
import '../../utils/colors.dart';

class StaffTasksScreen extends StatefulWidget {
  const StaffTasksScreen({super.key});

  @override
   State<StaffTasksScreen> createState() => _StaffTasksScreenState(); 
}
   class _StaffTasksScreenState extends State<StaffTasksScreen> {
   
    @override
    Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.grey[100],

      // 🔵 NAVBAR
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        centerTitle: true,
        title: const Text(
          "All Tasks",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // 🔵 BODY
body: StaffTaskData.tasks.isEmpty

    ? Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: const [

            Icon(
              Icons.assignment_turned_in_outlined,
              size: 80,
              color: Colors.grey,
            ),

            SizedBox(height: 12),

            Text(
              "No Tasks Yet",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      )

    : ListView.builder(
        padding: const EdgeInsets.all(12),

        itemCount:
            StaffTaskData.tasks.length,

        itemBuilder: (context, index) {

          return taskCard(index);
        },
      ),
    );
  }

   Widget taskCard(int index) {
  var task = StaffTaskData.tasks[index];
  String status = task["status"];

  String buttonText;
  Color color;

  if (status == "Pending") {
    buttonText = "Start Work";
    color = Colors.blue;
  } else if (status == "In Progress") {
    buttonText = "Mark Done";
    color = Colors.orangeAccent;
  } else {
    buttonText = "Finished";
    color = Colors.lightGreen;
  }

  return GestureDetector(
    onTap: () {
      // 🔥 OPEN DETAIL SCREEN
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => StaffTaskDetailScreen(
            title: task["title"],
            subtitle: task["subtitle"],
            status: task["status"],
          ),
        ),
      );
    },

    child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            task["title"],
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14),
          ),

          const SizedBox(height: 5),

          Text(
            task["subtitle"],
            style: const TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(
                status,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),

              // 🔥 BUTTON (SEPARATE TAP)
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (status == "Pending") {
                      task["status"] = "In Progress";
                    } else if (status == "In Progress") {
                      task["status"] = "Completed";
                    }
                  });
                },

                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: color),
                  ),
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
 }
}