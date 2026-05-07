import 'package:flutter/material.dart';
import 'colors.dart';
import 'complaint_data.dart';

class ResidentAllComplaintsScreen extends StatefulWidget {
  const ResidentAllComplaintsScreen({super.key});

  @override
  State<ResidentAllComplaintsScreen> createState() =>
      _ResidentAllComplaintsScreenState();
}

class _ResidentAllComplaintsScreenState
    extends State<ResidentAllComplaintsScreen> {
  String selectedFilter = "All";

  List<Complaint> get complaints => ComplaintData.complaints;

  // 🔍 FILTER
  List<Complaint> get filteredComplaints {
    if (selectedFilter == "All") return complaints;
    return complaints
        .where((c) => c.status == selectedFilter)
        .toList();
  }

  // 🎨 STATUS BACKGROUND
  Color statusBg(String status) {
    if (status == "Pending") {
      return const Color.fromARGB(255, 242, 222, 189);
    } else if (status == "In Progress") {
      return const Color.fromARGB(255, 214, 235, 250);
    } else {
      return const Color.fromARGB(255, 215, 245, 218);
    }
  }

  // 🎨 STATUS TEXT
  Color statusText(String status) {
    if (status == "Pending") {
      return Colors.deepOrange;
    } else if (status == "In Progress") {
      return Colors.blue.shade700;
    } else {
      return Colors.green.shade700;
    }
  }

  // 🔥 POPUP (UPDATED)
  void showComplaintPopup(Complaint c) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 320,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    c.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    c.desc,
                    style: const TextStyle(color: Colors.black87),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    c.date,
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
              ? AppColors.primaryBlue.withValues(alpha: 0.15)
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

  // 📦 CARD (UPDATED)
  Widget complaintCard(Complaint c) {
    return GestureDetector(
      onTap: () => showComplaintPopup(c),
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

            // TOP ROW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                // CATEGORY
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(c.category),
                ),

                // STATUS
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: statusBg(c.status),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    c.status,
                    style: TextStyle(
                      color: statusText(c.status),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // TITLE
            Text(
              c.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 6),

            // DESCRIPTION
            Text(
              c.desc,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 10),

            // DATE
            Row(
              children: [
                const Icon(Icons.calendar_month, size: 16),
                const SizedBox(width: 5),
                Text(
                  c.date,
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

      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        centerTitle: true,
        title: const Text(
          "All Complaints",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // FILTERS
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  filterButton("All"),
                  const SizedBox(width: 8),
                  filterButton("Pending"),
                  const SizedBox(width: 8),
                  filterButton("In Progress"),
                  const SizedBox(width: 8),
                  filterButton("Completed"),
                ],
              ),
            ),

            const SizedBox(height: 16),

 Expanded(
    child: filteredComplaints.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.assignment_turned_in_outlined,
                    size: 60, color: Colors.grey),
                SizedBox(height: 10),
                Text(
                  "No complaints yet",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        : ListView(
            children: filteredComplaints
                .map((c) => complaintCard(c))
                .toList(),
          ),
       )
          ],
        ),
      ),
    );
  }
}