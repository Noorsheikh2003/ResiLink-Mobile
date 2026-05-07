import 'package:flutter/material.dart';
import 'colors.dart';

class StaffAlertScreen extends StatefulWidget {
  const StaffAlertScreen({super.key});

  @override
  State<StaffAlertScreen> createState() => _StaffAlertScreenState();
}

class _StaffAlertScreenState extends State<StaffAlertScreen> {

  // 🔥 ALERT DATA
  List<Map<String, String>> alerts = [
    {
      "title": "Electrical Issue",
      "flat": "Flat A-302 • Electrical",
      "description":
          "This task involves repairing and ensuring proper functionality. Please complete it carefully and report once done.",
    },
    {
      "title": "Plumbing Leakage",
      "flat": "Flat B-112 • Plumbing",
      "description":
          "This task involves repairing and ensuring proper functionality. Please complete it carefully and report once done.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // 🔵 NAVBAR
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        centerTitle: true,
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // 🔵 BODY
        body: alerts.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.notifications_off_rounded,
                        size: 60, color: Colors.grey),
                    SizedBox(height: 10),
                    Text(
                      "No Alert Yet",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: alerts.length,
              itemBuilder: (context, index) {
                final alert = alerts[index];

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

                      // 🔹 TITLE + DELETE
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              alert["title"]!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),

                          // 🗑 DELETE BUTTON
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.grey),
                            onPressed: () {
                              setState(() {
                                alerts.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 5),

                      // 🔹 FLAT
                      Text(
                        alert["flat"]!,
                        style: const TextStyle(color: Colors.black87),
                      ),

                      const SizedBox(height: 10),

                      // 🔹 DESCRIPTION
                      Text(
                        alert["description"]!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}