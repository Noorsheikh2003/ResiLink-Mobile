import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../utils/colors.dart';
import '../../models/complaint_data.dart';

class ResidentParkingReportScreen extends StatefulWidget {
  const ResidentParkingReportScreen({super.key});

  @override
  State<ResidentParkingReportScreen> createState() =>
      _ResidentParkingReportScreenState();
}

class _ResidentParkingReportScreenState
    extends State<ResidentParkingReportScreen> {

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController issueController = TextEditingController();
  String? imagePath;

  final ImagePicker _picker = ImagePicker();

  // 📷 PICK IMAGE
  Future<void> pickImage() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imagePath = image.path;
      });
    }
  }

Future<void> submitReport() async {

  if (descriptionController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please describe the issue")),
    );
    return;
  }

  // 🔥 ADD TO GLOBAL COMPLAINT LIST
  ComplaintData.complaints.insert(
    0,
    Complaint(
      category: "Parking", // 🔥 IMPORTANT
      title: "Unauthorized Parking",
      desc: descriptionController.text,
      date: DateTime.now().toString().substring(0, 16),
    ),
  );

  // 🔥 SAVE DATA
  await ComplaintData.saveComplaints();

  if (!mounted) return;

    // 🎉 POPUP
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        Future.delayed(const Duration(seconds: 2), () {
          if (!mounted) return;

          Navigator.pop(context); // close popup
          Navigator.popUntil(context, (route) => route.isFirst); 
        });

        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 250,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 10,
                  )
                ],
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle,
                      color: Colors.white, size: 50),
                  SizedBox(height: 10),
                  Text(
                    "Issue Reported",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // 🔥 REQUIRED BUILD METHOD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        centerTitle: true,
        title: const Text(
          "Report Issue",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text("Describe Issue",  style: TextStyle(fontWeight: FontWeight.bold,)),
            const SizedBox(height: 6),
           
            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Describe the parking issue...",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),

            const SizedBox(height: 16),

            const Text("Upload Evidence", style: TextStyle(fontWeight: FontWeight.bold,)),
            
            const SizedBox(height: 10),

            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: imagePath == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.upload, size: 30),
                          SizedBox(height: 5),
                          Text("Upload Screenshot"),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: kIsWeb
                            ? Image.network(imagePath!,
                                fit: BoxFit.cover)
                            : Image.file(File(imagePath!),
                                fit: BoxFit.cover),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: submitReport,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text("Report Issue"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}