import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../utils/colors.dart';
import '../../models/complaint_data.dart';

class ResidentNewComplaintScreen extends StatefulWidget {
  const ResidentNewComplaintScreen({super.key});

  @override
  State<ResidentNewComplaintScreen> createState() =>
      _ResidentNewComplaintScreenState();
}

class _ResidentNewComplaintScreenState
    extends State<ResidentNewComplaintScreen> {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedCategory;
  String? imagePath;

  final ImagePicker _picker = ImagePicker();

  final List<String> categories = [
    "Plumbing",
    "Electrical",
    "Maintenance",
    "Others"
  ];

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

  // 🚀 SUBMIT FUNCTION (FIXED)
  Future<void> submitComplaint() async {

    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        selectedCategory == null) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    // 🔥 ADD TO GLOBAL DATA
    ComplaintData.complaints.insert(
      0,
      Complaint(
        category: selectedCategory!,
        title: titleController.text,
        desc: descriptionController.text,
        date: DateTime.now().toString().substring(0, 16),
      ),
    );

    // 🔥 SAVE LOCALLY
    await ComplaintData.saveComplaints();

    if (!mounted) return; // 🔥 IMPORTANT FIX

    // 🧹 CLEAR FIELDS
    titleController.clear();
    descriptionController.clear();
    selectedCategory = null;
    imagePath = null;

    setState(() {});

    // 🎉 SUCCESS POPUP
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        Future.delayed(const Duration(seconds: 2), () {
          if (!mounted) return;

          Navigator.pop(context); // close popup
          Navigator.pop(context); // go back
        });

        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 260,
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
                    "Complaint Submitted",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
          "New Complaint",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔹 TITLE
            const Text("Complaint Title",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),

            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "e.g. Water Leakage",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),

            const SizedBox(height: 16),

            // 🔹 CATEGORY
            const Text("Category",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCategory,
                  hint: const Text("Select Category"),
                  isExpanded: true,
                  items: categories.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 🔹 DESCRIPTION
            const Text("Description",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),

            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Describe the issue...",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),

            const SizedBox(height: 16),

            // 📷 IMAGE
            const Text("Upload Evidence",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 130,
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
                          Text("Upload Image"),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: kIsWeb
                            ? Image.network(imagePath!, fit: BoxFit.cover)
                            : Image.file(File(imagePath!), fit: BoxFit.cover),
                      ),
              ),
            ),

            const SizedBox(height: 24),

            // 🔹 BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: submitComplaint,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Submit Complaint"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}