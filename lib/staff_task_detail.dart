import 'package:flutter/material.dart';
import 'colors.dart';

class StaffTaskDetailScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String status;

  const StaffTaskDetailScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // 🔵 NAVBAR
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        centerTitle: true,
        title: const Text(
          "Task Detail",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // 🔵 BODY
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(14),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Text(
                subtitle,
                style: const TextStyle(color: Colors.black87),
              ),

              const SizedBox(height: 20),

              const Text(
                "Description",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),

              const SizedBox(height: 8),

              const Text(
                "This task involves repairing and ensuring proper functionality. Please complete it carefully and report once done.",
                style: TextStyle(fontSize: 14),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  const Text(
                    "Status: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    status,
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}