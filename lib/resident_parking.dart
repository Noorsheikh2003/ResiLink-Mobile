import 'package:flutter/material.dart';
import 'resident_parking_report.dart';
import 'profile_data.dart';
import 'parking_data.dart';
import 'colors.dart';

class ResidentParkingScreen extends StatelessWidget {
  const ResidentParkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final boxColor = Colors.grey[200];

    return Scaffold(
      backgroundColor: Colors.grey[100],

      // 🔵 NAVBAR
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        centerTitle: true,
        title: const Text(
          "Parking",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [           
            // 🚗 ASSIGNED SLOT (UPDATED BIG CARD)
           Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // 🔥 TOP ROW (NAME + SLOT)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // 🔹 LEFT SIDE (NAME + FLAT)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ProfileData.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "Flat  ${ProfileData.flatNo}",
                          style: const TextStyle(color: Colors.black, 
                          fontWeight: FontWeight.bold,
                          fontSize: 16,),
                        ),
                      ],
                    ),

                    // 🔹 RIGHT SIDE (SLOT)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [

                        Text(
                          "ASSIGNED SLOT",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),

                        SizedBox(height: 6),

                        Text(
                          ParkingData.assignedSlot,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                const Divider(),

                const SizedBox(height: 12),

                // 🚗 CAR DETAILS (UNCHANGED)
                Row(
                  children: const [
                    Icon(Icons.directions_car, size: 22),
                    SizedBox(width: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "BKL-255",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          "Car • Private Parking",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
            const SizedBox(height: 20),

            // 📋 PARKING GUIDELINES
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: boxColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "PARKING GUIDELINES",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),

                  Row(
                    children: [
                      Icon(Icons.check_circle, color: AppColors.primaryBlue, size: 18),
                      SizedBox(width: 6),
                      Text("Park only in your assigned slot"),
                    ],
                  ),

                  SizedBox(height: 6),

                  Row(
                    children: [
                      Icon(Icons.check_circle, color: AppColors.primaryBlue, size: 18),
                      SizedBox(width: 6),
                      Text("No blocking other vehicles"),
                    ],
                  ),

                  SizedBox(height: 6),

                  Row(
                    children: [
                      Icon(Icons.check_circle, color: AppColors.primaryBlue, size: 18),
                      SizedBox(width: 6),
                      Text("Follow speed limits"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🚨 REPORT ISSUE CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: boxColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [

                  const Icon(Icons.report, size: 28),
                  const SizedBox(width: 10),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Parking Issue?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 3),
                        Text("Report blocking or misuse"),
                      ],
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ResidentParkingReportScreen(),
                        ),
                      );
                     },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                    ),
                    child: const Text("Report"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}