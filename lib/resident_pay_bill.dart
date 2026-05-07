import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'payment_data.dart';
import 'colors.dart';

class ResidentPayBillScreen extends StatefulWidget {
  const ResidentPayBillScreen({super.key});

  @override
  State<ResidentPayBillScreen> createState() => _ResidentPayBillScreenState();
}

class _ResidentPayBillScreenState extends State<ResidentPayBillScreen> {
  int selectedMethod = 0;
  String? imagePath;
  String paymentStatus = "Unpaid"; 

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imagePath = image.path;
      });
    }
  }

  // 🔥 SUBMIT WITH VALIDATION
  void submitPayment() {
    if (imagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please upload payment receipt"),
        ),
      );
      return;
    }

  PaymentData.payments.insert(
   0,
    Payment(
      title: "Maintenance Bill",
      amount: "Rs. 12,500",
      date: DateTime.now().toString().substring(0, 16),
      method: selectedMethod == 0 ? "Bank Transfer" : "EasyPaisa",
    ),
  );
  
      setState(() {
       paymentStatus = "Paid";
       imagePath = null;
      });
    showPaymentSuccessPopup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        elevation: 0,
        centerTitle: true,
        title: const Text("Pay Bill",
            style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [             
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [

                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    const Text(
                      "MAINTENANCE BILL",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: paymentStatus == "Paid"
                            ? Colors.green.withValues(alpha: 0.1)
                            : Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        paymentStatus,
                        style: TextStyle(
                          color: paymentStatus == "Paid"
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                    const Divider(),

                    infoRow("Flat Number", "A-302"),
                    infoRow("Billing Month", "March 2026"),
                    infoRow("Due Date", "March 15, 2026"),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Total Amount"),
                        Text("Rs. 12,500",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Text("PAYMENT METHOD",
                  style: TextStyle(fontWeight: FontWeight.bold)),

              const SizedBox(height: 10),

              Row(
                children: [
                  methodCard(0, "Bank Transfer",
                      Icons.account_balance),
                  const SizedBox(width: 10),
                  methodCard(1, "EasyPaisa",
                      Icons.account_balance_wallet),
                ],
              ),

              const SizedBox(height: 20),

              accountDetails(),

              const SizedBox(height: 20),

              // 🔥 RECEIPT
              const Text("UPLOAD PAYMENT RECEIPT",
                  style: TextStyle(fontWeight: FontWeight.bold)),

              const SizedBox(height: 10),

              GestureDetector(
                onTap: pickImage,
                child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: imagePath == null
                      ? const Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Icon(Icons.upload, size: 30),
                            SizedBox(height: 5),
                            Text("Upload Screenshot"),
                          ],
                        )
                      : (kIsWeb
                          ? Image.network(imagePath!,
                              fit: BoxFit.cover)
                          : Image.file(File(imagePath!),
                              fit: BoxFit.cover)),
                ),
              ),

              const SizedBox(height: 20),

              // 🔥 SUBMIT BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: paymentStatus == "Paid" ? null : submitPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: paymentStatus == "Paid"
                    ? Colors.grey   
                    : AppColors.primaryBlue, 
                disabledBackgroundColor: Colors.grey, 
                foregroundColor: paymentStatus == "Paid"
                    ? Colors.black   
                    : Colors.white,  
                disabledForegroundColor: Colors.black,               
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
                  child: Text(
                    paymentStatus == "Paid"
                        ? "No Payment Required"
                        : "Submit Payment",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 METHOD CARD
  Widget methodCard(int index, String title, IconData icon) {
    bool isSelected = selectedMethod == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedMethod = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            border: Border.all(
                color: isSelected
                    ? AppColors.primaryBlue
                    : Colors.grey),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Icon(icon,
                  color: isSelected
                      ? AppColors.primaryBlue
                      : Colors.grey),
              const SizedBox(height: 5),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }

  // 🔥 POPUP
  void showPaymentSuccessPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        Future.delayed(const Duration(seconds: 2), () {
          if (!mounted) return;

          Navigator.pop(context); // popup
      //  Navigator.pop(context); // back to dashboard (Off Just to check Paid / Unpaid)
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
                    color:
                        Colors.black.withValues(alpha: 0.2),
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
                    "Payment Successful",
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

  // 🔹 ACCOUNT DETAILS
  Widget accountDetails() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          infoRow("Account Title",
              "Apartment Association Fund"),
          infoRow(
              "Account Number",
              selectedMethod == 0
                  ? "0921-12345678-01"
                  : "0300-1234567"),
          infoRow(
              "Bank / Provider",
              selectedMethod == 0
                  ? "Meezan Bank Ltd."
                  : "JazzCash / EasyPaisa"),
        ],
      ),
    );
  }

  // 🔹 INFO ROW
  Widget infoRow(String title, String value) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}