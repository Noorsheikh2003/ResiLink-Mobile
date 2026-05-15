import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class ResidentNoticesScreen extends StatefulWidget {
  const ResidentNoticesScreen({super.key});

  @override
  State<ResidentNoticesScreen> createState() => _ResidentNoticesScreenState();
}

class _ResidentNoticesScreenState extends State<ResidentNoticesScreen> {
  String selectedFilter = "All";

  List<Map<String, String>> notices = [
    {
      "category": "Water",
      "title": "Emergency Water Maintenance",
      "desc":
          "Scheduled water maintenance for Blocks A and B to repair a burst main pipe. Water supply will be limited.",
      "date": "15 Mar 2026",
      "time": "09:30 AM",
    },
    {
      "category": "Electricity",
      "title": "Scheduled Power Outage",
      "desc":
          "The electrical grid will undergo routine inspection this weekend. Power will be out for 2 hours.",
      "date": "16 Mar 2026",
      "time": "10:00 PM",
    },
    {
      "category": "Maintenance",
      "title": "Elevator Service Update",
      "desc":
          "Elevator #3 in Block C is back in service following the replacement of the control module.",
      "date": "14 Mar 2026",
      "time": "02:15 PM",
    },
    {
      "category": "General",
      "title": "Annual General Meeting",
      "desc":
          "All residents are invited to the AGM scheduled for next month at the community clubhouse.",
      "date": "20 Mar 2026",
      "time": "06:00 PM",
    },
  ];

  // 🔍 FILTER LOGIC
  List<Map<String, String>> get filteredNotices {
    if (selectedFilter == "All") return notices;
    return notices
        .where((n) => n["category"] == selectedFilter)
        .toList();
  }

  // 🔥 POPUP
  void showNoticePopup(Map<String, String> notice) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    notice["title"]!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(notice["desc"]!),
                  const SizedBox(height: 15),                  
                  Text(
                    "${notice["date"]} • ${notice["time"]}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // 🗑 DELETE FUNCTION
  void deleteNotice(int index) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Delete Notice"),
          content: const Text("Are you sure you want to delete this notice?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", 
                  style: TextStyle(color:Colors.black )),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  notices.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: const Text("Delete",
                  style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  // 🔘 FILTER BUTTON
  Widget filterButton(String title) {
    final isSelected = selectedFilter == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = title;
        });
      },
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryBlue.withValues(alpha: 0.1)
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color:
                isSelected ? AppColors.primaryBlue : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // 📦 NOTICE CARD (UPDATED)
  Widget noticeCard(Map<String, String> n, int index) {
    return GestureDetector(
      onTap: () => showNoticePopup(n),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔹 TOP ROW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(n["category"]!),
                ),

                // 🗑 DELETE ICON
                IconButton(
                  onPressed: () => deleteNotice(index),
                  icon: const Icon(Icons.delete, color: Colors.grey),
                )
              ],
            ),

            const SizedBox(height: 10),

            Text(
              n["title"]!,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
            ),

            const SizedBox(height: 6),

            Text(
              n["desc"]!,
              style: const TextStyle(color: Colors.black87),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: 5),
                Text(
                  "${n["date"]} • ${n["time"]}",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // 🔵 NAVBAR
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        centerTitle: true,
        title: const Text(
          "Notices",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 🔹 FILTERS
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  filterButton("All"),
                  const SizedBox(width: 8),
                  filterButton("Water"),
                  const SizedBox(width: 8),
                  filterButton("Electricity"),
                  const SizedBox(width: 8),
                  filterButton("Maintenance"),
                ],
              ),
            ),

            const SizedBox(height: 16),

Expanded(
  child: filteredNotices.isEmpty
      ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.notifications_off_rounded,
                  size: 60, color: Colors.grey),
              SizedBox(height: 10),
              Text(
                "No Notices Yet",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        )
      : ListView(
          children: filteredNotices
              .asMap()
              .entries
              .map((entry) => noticeCard(entry.value, entry.key))
              .toList(),
        ),
       )
          ],
        ),
      ),
    );
  }
}