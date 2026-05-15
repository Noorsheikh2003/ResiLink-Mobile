import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController cnicController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController otpController =
      TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  String errorMessage = "";

  // ✅ EMAIL VALIDATION
  bool isValidEmail(String email) {

    String pattern =
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

    RegExp regex = RegExp(pattern);

    return regex.hasMatch(email);
  }

  // ✅ CNIC VALIDATION
  bool isValidCnic(String cnic) {

    String pattern =
        r'^\d{5}-\d{7}-\d{1}$';

    RegExp regex = RegExp(pattern);

    return regex.hasMatch(cnic);
  }

  // ✅ PHONE VALIDATION
  bool isValidPhone(String phone) {

    String pattern =
        r'^03\d{2}-\d{7}$';

    RegExp regex = RegExp(pattern);

    return regex.hasMatch(phone);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(

        backgroundColor: AppColors.primaryBlue,

        elevation: 0,

        centerTitle: true,

        title: const Text(

          "Create Account",

          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.symmetric(
              horizontal: 24, vertical: 10),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 60),

              // 👤 NAME
              textField(

                controller: nameController,

                hint: "Full Name",

                label: "Full Name",

                icon: Icons.person,
              ),

              const SizedBox(height: 18),

              // 🪪 CNIC
              textField(

                controller: cnicController,

                hint: "xxxxx-xxxxxxx-x",

                label: "CNIC",

                icon: Icons.credit_card,

                keyboard: TextInputType.number,

                inputFormatters: [

                  FilteringTextInputFormatter.digitsOnly,
                  
                  CnicInputFormatter(),
                ],
              ),

              const SizedBox(height: 18),

              // 📱 PHONE
              textField(

                controller: phoneController,

                hint: "03xx-xxxxxxx",

                label: "Phone Number",

                icon: Icons.phone,

                keyboard: TextInputType.number,

                inputFormatters: [

                  FilteringTextInputFormatter.digitsOnly,

                   PhoneInputFormatter(),
                ],
              ),

              const SizedBox(height: 18),

              // 📧 EMAIL
              textField(

                controller: emailController,

                hint: "example@gmail.com",

                label: "Email",

                icon: Icons.email,

                keyboard:
                    TextInputType.emailAddress,
              ),

              const SizedBox(height: 18),

              // 🔒 PASSWORD
              passwordField(

                controller: passwordController,

                hint: "Password",

                label: "Password",

                obscure: obscurePassword,

                onToggle: () {

                  setState(() {
                    obscurePassword =
                        !obscurePassword;
                  });
                },
              ),

              const SizedBox(height: 18),

              // 🔒 CONFIRM PASSWORD
              passwordField(

                controller:
                    confirmPasswordController,

                hint: "Confirm Password",

                label: "Confirm Password",

                obscure: obscureConfirmPassword,

                onToggle: () {

                  setState(() {

                    obscureConfirmPassword =
                        !obscureConfirmPassword;
                  });
                },
              ),

              const SizedBox(height: 30),

              // 🔵 CREATE ACCOUNT BUTTON
              SizedBox(

                width: double.infinity,

                child: ElevatedButton(

                  onPressed: () {

                    // 🔥 EMPTY FIELD CHECK
                    if (

                        nameController.text
                            .trim()
                            .isEmpty ||

                        cnicController.text
                            .trim()
                            .isEmpty ||

                        phoneController.text
                            .trim()
                            .isEmpty ||

                        emailController.text
                            .trim()
                            .isEmpty ||

                        passwordController.text
                            .trim()
                            .isEmpty ||

                        confirmPasswordController
                            .text
                            .trim()
                            .isEmpty

                    ) {

                      setState(() {

                        errorMessage =
                            "Please fill all required fields";
                      });

                      return;
                    }

                    // 🔥 EMAIL CHECK
                    if (!isValidEmail(
                        emailController.text
                            .trim())) {

                      setState(() {

                        errorMessage =
                            "Please enter a valid email";
                      });

                      return;
                    }

                    // 🔥 CNIC CHECK
                    if (!isValidCnic(
                        cnicController.text
                            .trim())) {

                      setState(() {

                        errorMessage =
                            "Invalid CNIC format";
                      });

                      return;
                    }

                    // 🔥 PHONE CHECK
                    if (!isValidPhone(
                        phoneController.text
                            .trim())) {

                      setState(() {

                        errorMessage =
                            "Invalid phone number";
                      });

                      return;
                    }

                    // 🔥 PASSWORD CHECK
                    if (passwordController.text !=
                        confirmPasswordController
                            .text) {

                      setState(() {

                        errorMessage =
                            "Passwords do not match";
                      });

                      return;
                    }

                    // ✅ CLEAR ERROR
                    setState(() {
                      errorMessage = "";
                    });

                    showOtpPopup();
                  },

                  style: ElevatedButton.styleFrom(

                    backgroundColor:
                        AppColors.primaryBlue,

                    foregroundColor: Colors.white,

                    padding:
                        const EdgeInsets.symmetric(
                            vertical: 16),

                    shape: RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                  ),

                  child: const Text(

                    "Create Account",

                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // ❌ ERROR MESSAGE
              if (errorMessage.isNotEmpty)

                Center(
                  child: Text(

                    errorMessage,

                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight:
                          FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔷 TEXT FIELD
  Widget textField({

    required TextEditingController controller,

    required String hint,

    required String label,

    required IconData icon,

    TextInputType keyboard =
        TextInputType.text,

    List<TextInputFormatter>?
        inputFormatters,
  }) {

    return TextField(

      controller: controller,

      keyboardType: keyboard,

      inputFormatters: inputFormatters,

      onTap: () {

        if (errorMessage.isNotEmpty) {

          setState(() {
            errorMessage = "";
          });
        }
      },

      decoration: InputDecoration(

        labelText: label,
        
        hintText: hint,

        prefixIcon: Icon(icon),

        filled: true,

        fillColor: Colors.grey.shade100,

        border: OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(14),

          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // 🔷 PASSWORD FIELD
  Widget passwordField({

    required TextEditingController controller,

    required String hint,

    required String label,

    required bool obscure,

    required VoidCallback onToggle,
  }) {

    return TextField(

      controller: controller,

      obscureText: obscure,

      onTap: () {

        if (errorMessage.isNotEmpty) {

          setState(() {
            errorMessage = "";
          });
        }
      },

      decoration: InputDecoration(

        labelText: label,

        hintText: hint,

        prefixIcon:
            const Icon(Icons.lock),

        suffixIcon: IconButton(

          icon: Icon(

            obscure
                ? Icons.visibility_off
                : Icons.visibility,
          ),

          onPressed: onToggle,
        ),

        filled: true,

        fillColor: Colors.grey.shade100,

        border: OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(14),

          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // 🔷 OTP POPUP
  void showOtpPopup() {

    List<TextEditingController>
        otpControllers = List.generate(
      4,
      (_) => TextEditingController(),
    );

    List<FocusNode> focusNodes =
        List.generate(
      4,
      (_) => FocusNode(),
    );

    showDialog(

      context: context,

      barrierDismissible: false,

      builder: (_) {

        return Dialog(

          shape: RoundedRectangleBorder(

            borderRadius:
                BorderRadius.circular(18),
          ),

          child: Container(

            width: 340,

            padding:
                const EdgeInsets.all(20),

            child: Column(

              mainAxisSize: MainAxisSize.min,

              children: [

                // ❌ CLOSE BUTTON
              Align(

                alignment: Alignment.topRight,

                child: GestureDetector(

                  onTap: () {
                    Navigator.pop(context);
                  },

                  child: Container(

                    padding: const EdgeInsets.all(6),

                    decoration: BoxDecoration(

                      shape: BoxShape.circle,

                      border: Border.all(
                        color: AppColors.primaryBlue,
                        width: 1,
                      ),
                    ),

                    child: const Icon(

                      Icons.close,

                      size: 20,

                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
              ),

                // 🔷 TITLE
                const Text(

                  "Verification OTP",

                  style: TextStyle(
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(

                  "Enter 4-digit OTP",

                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 25),

                // 🔥 OTP BOXES
                Row(

                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: List.generate(
                    4,
                    (index) {

                      return Container(

                        width: 50,

                        height: 60,

                        margin:
                            const EdgeInsets.symmetric(
                                horizontal: 5),

                        child: TextFormField(

                          controller:
                              otpControllers[index],

                          focusNode:
                              focusNodes[index],

                          keyboardType:
                              TextInputType.number,

                          textAlign:
                              TextAlign.center,

                          style: const TextStyle(

                            fontSize: 22,

                            fontWeight:
                                FontWeight.bold,
                          ),

                          maxLength: 1,

                          decoration: InputDecoration(

                            counterText: "",

                            filled: true,

                            fillColor:
                                Colors.grey.shade100,

                            contentPadding:
                                EdgeInsets.zero,

                            border:
                                OutlineInputBorder(

                              borderRadius:
                                  BorderRadius.circular(
                                      12),
                            ),
                          ),

                          inputFormatters: [

                            FilteringTextInputFormatter
                                .digitsOnly,
                          ],

                          onChanged: (value) {

                            // 🔥 NEXT
                            if (value.isNotEmpty &&
                                index < 3) {

                              focusNodes[index + 1]
                                  .requestFocus();
                            }

                            // 🔥 BACKSPACE
                            if (value.isEmpty &&
                                index > 0) {

                              focusNodes[index - 1]
                                  .requestFocus();
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 28),

                // 🔵 VERIFY BUTTON
                SizedBox(

                  width: double.infinity,

                  child: ElevatedButton(

                    onPressed: () {

                      String enteredOtp =
                          otpControllers
                              .map((e) => e.text)
                              .join();

                      if (enteredOtp ==
                          "1234") {

                        Navigator.pop(context);

                        ScaffoldMessenger.of(
                                context)
                            .showSnackBar(

                          SnackBar(

                            backgroundColor:
                                Colors.green,

                            behavior:
                                SnackBarBehavior
                                    .floating,

                            content:
                                const Center(

                              child: Text(

                                "Account Created Successfully",

                                style: TextStyle(

                                  color:
                                      Colors.white,

                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),

                            duration:
                                const Duration(
                                    seconds: 2),
                          ),
                        );

                        Navigator.pop(context);
                      }

                      else {

                        ScaffoldMessenger.of(
                                context)
                            .showSnackBar(

                          SnackBar(

                            backgroundColor:
                                Colors.red,

                            behavior:
                                SnackBarBehavior
                                    .floating,

                            content:
                                const Center(

                              child: Text(

                                "Invalid OTP",

                                style: TextStyle(

                                  color:
                                      Colors.white,

                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),

                            duration:
                                const Duration(
                                    seconds: 2),
                          ),
                        );
                      }
                    },

                    style: ElevatedButton.styleFrom(

                      backgroundColor:
                          AppColors.primaryBlue,

                      foregroundColor:
                          Colors.white,

                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 14,
                      ),

                      shape:
                          RoundedRectangleBorder(

                        borderRadius:
                            BorderRadius.circular(
                                14),
                      ),
                    ),

                    child:
                        const Text("Verify"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
// ✅ CNIC FORMATTER
class CnicInputFormatter
    extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(

    TextEditingValue oldValue,

    TextEditingValue newValue,
  ) {

    String text =
        newValue.text.replaceAll('-', '');

    if (text.length > 13) {
      text = text.substring(0, 13);
    }

    String formatted = "";

    for (int i = 0; i < text.length; i++) {

      if (i == 5 || i == 12) {
        formatted += "-";
      }

      formatted += text[i];
    }

    return TextEditingValue(

      text: formatted,

      selection: TextSelection.collapsed(
        offset: formatted.length,
      ),
    );
  }
}

// ✅ PHONE FORMATTER
class PhoneInputFormatter
    extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(

    TextEditingValue oldValue,

    TextEditingValue newValue,
  ) {

    String text =
        newValue.text.replaceAll('-', '');

    if (text.length > 11) {
      text = text.substring(0, 11);
    }

    String formatted = "";

    for (int i = 0; i < text.length; i++) {

      if (i == 4) {
        formatted += "-";
      }

      formatted += text[i];
    }

    return TextEditingValue(

      text: formatted,

      selection: TextSelection.collapsed(
        offset: formatted.length,
      ),
    );
  }
}