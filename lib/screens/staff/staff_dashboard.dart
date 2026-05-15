import 'package:flutter/material.dart';
import 'staff_tasks.dart';
import 'staff_task_data.dart';
import 'staff_alert.dart';
import 'staff_details.dart';
import '../../colors.dart';

class StaffDashboard extends StatefulWidget {
  const StaffDashboard({super.key});

  @override
  State<StaffDashboard> createState() => _StaffDashboardState();
}

class _StaffDashboardState extends State<StaffDashboard> {
  String staffName = "Junaid Khan";

  @override
  Widget build(BuildContext context) {

    var tasks = StaffTaskData.tasks;

    int total = tasks.length;
    int pending = tasks.where((t) => t["status"] == "Pending").length;
    int inProgress = tasks.where((t) => t["status"] == "In Progress").length;
    int completed = tasks.where((t) => t["status"] == "Completed").length;

    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: Column(
        children: [

          // 🔷 NAVBAR
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 15, 16, 20),
            decoration: const BoxDecoration(
              color: AppColors.primaryBlue,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: const Icon(
                          Icons.person,
                          color: AppColors.primaryBlue,
                          size: 25,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                       staffName,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),

                IconButton(
                  icon: const Icon(
                    Icons.notifications,
                    color: Colors.amber,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const StaffAlertScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // 🔥 SCROLLABLE PART
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  const SizedBox(height: 20),

                  // 🔢 SUMMARY BOXES
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [

                        Row(
                          children: [
                            Expanded(child: summaryBox(total.toString(), "Total Assigned")),
                            const SizedBox(width: 10),
                            Expanded(child: summaryBox(pending.toString(), "Pending")),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(child: summaryBox(inProgress.toString(), "In Progress")),
                            const SizedBox(width: 10),
                            Expanded(child: summaryBox(completed.toString(), "Completed")),
                          ],
                        ),

                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  // 🔥 RECENT TASKS HEADER
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Recent Tasks",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const StaffTasksScreen(),
                              ),
                            ).then((_) {
                              setState(() {});
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "View All",
                              style: TextStyle(
                                  color: AppColors.primaryBlue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 🔥 TOP 3 TASKS
               StaffTaskData.tasks.isEmpty

                ? const Padding(
                    padding: EdgeInsets.only(top: 30),

                    child: Column(
                      children: [

                        Icon(
                          Icons.assignment_turned_in_outlined,
                          size: 70,
                          color: Colors.grey,
                        ),

                        SizedBox(height: 10),

                        Text(
                          "No Tasks Yet",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )

                : Column(
                    children: StaffTaskData.tasks.take(3).map((task) {

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

                      return Container(
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
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              task["subtitle"],
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,

                              children: [

                                Text(
                                  status,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () {
                                    setState(() {

                                      if (status == "Pending") {
                                        task["status"] =
                                            "In Progress";
                                      }

                                      else if (status ==
                                          "In Progress") {

                                        task["status"] =
                                            "Completed";
                                      }
                                    });
                                  },

                                  child: Container(
                                    padding:
                                        const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),

                                    decoration: BoxDecoration(
                                      color: color.withValues(
                                          alpha: 0.1),

                                      borderRadius:
                                          BorderRadius.circular(
                                              20),

                                      border:
                                          Border.all(color: color),
                                    ),

                                    child: Text(
                                      buttonText,
                                      style: TextStyle(
                                        color: color,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );

                    }).toList(),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),

      // 🔻 BOTTOM NAVBAR
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.primaryBlue,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,

        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const StaffDashboard(),
              ),
            );
          } 
          else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const StaffTasksScreen(),
              ),
            ).then((_) {
              setState(() {});
            });
          }
          else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const StaffAlertScreen(),
              ),
            );
          }
          else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => StaffDetailsScreen(currentName: "Junaid Khan"),
              ),
            ).then((updatedName) {
              if (updatedName != null) {
                setState(() {
                  staffName = updatedName;
                });
              }
            });
          }
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }

  // 📦 SUMMARY BOX
  static Widget summaryBox(String count, String title) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}