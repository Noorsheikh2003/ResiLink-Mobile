import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class ResidentAlertScreen extends StatefulWidget {
  const ResidentAlertScreen({super.key});

  @override
  State<ResidentAlertScreen> createState() => _ResidentAlertScreenState();
}

class _ResidentAlertScreenState extends State<ResidentAlertScreen> {

  //  SINGLE ALERT LIST (so we can delete)
  List<String> alerts = [
    "The maintenance bill of March Month is Rs. 12,500 for Apartment A-302. Due Date: March 15, 2026."
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

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: alerts.isEmpty
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
                itemCount: alerts.length,
                itemBuilder: (context, index) {

                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // 🔹 TOP ROW (ICON + TITLE + DELETE)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Row(
                              children: const [
                                Icon(Icons.notifications,
                                    color: Colors.amber),
                                SizedBox(width: 8),
                                Text(
                                  "New Notification",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),

                            // 🔥 DELETE BUTTON
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Colors.grey),
                              onPressed: () {
                                setState(() {
                                  alerts.removeAt(index);
                                });
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // 🔹 MESSAGE
                        Text(
                          alerts[index],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}