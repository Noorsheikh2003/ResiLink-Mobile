import 'package:flutter/material.dart';
import 'package:my_resilink/screens/resident/resident_all_complaints.dart';
import 'package:my_resilink/screens/resident/resident_details.dart';
import 'package:my_resilink/screens/resident/resident_pay_bill.dart';
import 'package:my_resilink/screens/resident/resident_new_complaint.dart';
import 'package:my_resilink/screens/resident/resident_parking.dart';
import 'package:my_resilink/screens/resident/resident_notices.dart';
import 'package:my_resilink/screens/resident/resident_history.dart';
import 'package:my_resilink/screens/resident/resident_alert.dart';
import '../../complaint_data.dart';
import '../../colors.dart';
import 'dart:io';
import '../../profile_data.dart';

class ResidentDashboard extends StatefulWidget {
  const ResidentDashboard({super.key});

  @override
  State<ResidentDashboard> createState() => _ResidentDashboardState();
}

class _ResidentDashboardState extends State<ResidentDashboard> {
  String residentName = "Noor Sheikh";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // 🔵 NAVBAR
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: AppBar(
          backgroundColor: AppColors.primaryBlue,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
               CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: ProfileData.imagePath != null
                      ? Image.file(
                          File(ProfileData.imagePath!),
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.person, color: AppColors.primaryBlue),
                ),
              ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      residentName,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),

                 IconButton(
                  icon: const Icon(
                    Icons.notifications,
                    color: Colors.amber,
                    size: 32,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ResidentAlertScreen(),
                      ),
                    );
                  },
                ),
                ],
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: bottomNavBar(),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              quickActions(),
              recentComplaints(), //  UPDATED
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 QUICK ACTIONS
  Widget quickActions() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Quick Actions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1,
            children: [
              actionItem(Icons.payment, "Pay Bill", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ResidentPayBillScreen()),
                );
              }),
              actionItem(Icons.history, "Pay History", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ResidentHistoryScreen()),
                );
              }),
              actionItem(Icons.add_box, "New Complaint", () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ResidentNewComplaintScreen()),
                );
                setState(() {}); //  refresh dashboard
              }),
              actionItem(Icons.list_alt, "All Complaints", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ResidentAllComplaintsScreen()),
                );
              }),
              actionItem(Icons.local_parking, "Parking", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ResidentParkingScreen()),
                );
              }),
              actionItem(Icons.campaign, "Notices", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ResidentNoticesScreen()),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  // 🔹 ACTION BUTTON
  Widget actionItem(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: Icon(icon, color: AppColors.primaryBlue, size: 24),
          ),
          const SizedBox(height: 6),
          Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  //  UPDATED RECENT COMPLAINTS
  Widget recentComplaints() {
    List<Complaint> recent = ComplaintData.complaints
    .where((c) => c.category != "Parking") //  remove parking
    .take(3)
    .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Recent Complaints",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),

              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                             ResidentAllComplaintsScreen()),
                  );
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

          const SizedBox(height: 20),

          // 🔥 DYNAMIC LIST
          if (recent.isEmpty)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Icon(
                    Icons.assignment_turned_in_outlined,
                    size: 50,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "No recent complaints",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

          ...recent.map((c) {
            return complaintCard(
              c.title,
              c.date,
              c.status,
            );
          })
        ],
      ),
    );
  }

  // 🔹 COMPLAINT CARD
  Widget complaintCard(String title, String time, String status) {
    Color statusColor = status == "Completed"
        ? Colors.green
        : status == "Pending"
            ? Colors.orange
            : Colors.blue;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(time, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),

          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(color: statusColor, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }

// 🔹 NAVBAR
Widget bottomNavBar() {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppColors.primaryBlue,
    unselectedItemColor: AppColors.primaryBlue,
    showSelectedLabels: false,
    showUnselectedLabels: false,

    onTap: (index) async {

      //  HOME → reload dashboard
      if (index == 0) {
        setState(() {});
      }

      //  PAY BILL
      else if (index == 1) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ResidentPayBillScreen(),
          ),
        );
        setState(() {});
      }

      //  NEW COMPLAINT
      else if (index == 2) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ResidentNewComplaintScreen(),
          ),
        );
        setState(() {});
      }

      //  NOTICES
      else if (index == 3) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ResidentNoticesScreen(),
          ),
        );
      }

      //  PROFILE 
     else if (index == 4) {
   final updatedName = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResidentDetailsScreen(currentName: residentName),
      ),
    );

    if (!context.mounted) return;

    setState(() {
      if (updatedName != null) {
        residentName = updatedName;
      }
    });
   }
  },
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
      BottomNavigationBarItem(icon: Icon(Icons.payment), label: ""),
      BottomNavigationBarItem(icon: Icon(Icons.add_box), label: ""),
      BottomNavigationBarItem(icon: Icon(Icons.campaign), label: ""),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
    ],
  );
}
}