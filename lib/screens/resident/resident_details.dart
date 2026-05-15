import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/colors.dart';
import '../../models/profile_data.dart';

class ResidentDetailsScreen extends StatefulWidget {
  final String currentName;

  const ResidentDetailsScreen({super.key, required this.currentName});

  @override
  State<ResidentDetailsScreen> createState() => _ResidentDetailsScreenState();
}

class _ResidentDetailsScreenState extends State<ResidentDetailsScreen> {
  bool isEditing = false;

  late TextEditingController nameController;
  late String updatedName;

  final TextEditingController cnicController =
      TextEditingController(text: "4210112345671");
  final TextEditingController phoneController =
      TextEditingController(text: "03001234567");
  final TextEditingController emailController =
      TextEditingController(text: "example@email.com");
  final TextEditingController flatController =
      TextEditingController(text: "A-302");
  final TextEditingController buildingController =
      TextEditingController(text: "Al-Noor Residency");

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.currentName);
    updatedName = widget.currentName;
  }

  // 📸 PICK IMAGE
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        ProfileData.imagePath = picked.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pop(context, updatedName);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],

        appBar: AppBar(
          backgroundColor: AppColors.primaryBlue,
          centerTitle: true,
          title: const Text(
            "Personal Details",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              // 👤 PROFILE IMAGE
              GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.grey[300],
                  child: ClipOval(
                  child: ProfileData.imagePath != null
                      ? Image.file(File(ProfileData.imagePath!),
                     width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                      : const Icon(Icons.camera_alt, size: 40, color:AppColors.primaryBlue)
                      
                ),
              ),
            ),

              const SizedBox(height: 10),

              const Text(
                "Tap to upload Image",
                style: TextStyle(color: Colors.black),
              ),

              const SizedBox(height: 20),

              // ✏️ FIELDS
              inputField(Icons.person, "Name", nameController),
              inputField(Icons.credit_card, "CNIC", cnicController, maxLength: 13),
              inputField(Icons.phone, "Phone", phoneController, maxLength: 11),
              inputField(Icons.email, "Email Address", emailController),
              inputField(Icons.home, "Flat No", flatController),
              inputField(Icons.apartment, "Building Name", buildingController),

              const SizedBox(height: 20),

              // 🔘 ACTION BUTTONS
              Row(
                children: [

                  // 💾 SAVE
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          isEditing = false;
                          updatedName = nameController.text;
                          ProfileData.name = nameController.text;
                          ProfileData.flatNo = flatController.text;
                        });
                      },
                      icon: const Icon(Icons.save),
                      label: const FittedBox(child: Text("Save")),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: AppColors.primaryBlue,
                        padding: const EdgeInsets.all(14),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // 🚪 LOGOUT
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      icon: const Icon(Icons.logout),
                      label: const FittedBox(child: Text("Logout")),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: AppColors.primaryBlue,
                        padding: const EdgeInsets.all(14),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  //  DELETE
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                      label: const FittedBox(child: Text("Delete")),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: AppColors.primaryBlue,
                        padding: const EdgeInsets.all(14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 INPUT FIELD
  Widget inputField(
      IconData icon, String title, TextEditingController controller,
      {int? maxLength}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isEditing = true;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primaryBlue),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: controller,
                enabled: isEditing,
                keyboardType:
                    maxLength != null ? TextInputType.number : TextInputType.text,
                inputFormatters: maxLength != null
                    ? [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(maxLength),
                      ]
                    : null,
                decoration: InputDecoration(
                  labelText: title,
                  border: InputBorder.none,
                  counterText: "",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}