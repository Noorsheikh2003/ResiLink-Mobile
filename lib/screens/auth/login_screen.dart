import 'package:flutter/material.dart';
import '../resident/resident_dashboard.dart';
//import '../staff/staff_dashboard.dart';
import 'signup_screen.dart';
import '../../utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  bool obscurePassword = true;

  String errorMessage = "";

  // ✅ EMAIL VALIDATION FUNCTION
  bool isValidEmail(String email) {

    String pattern =
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

    RegExp regex = RegExp(pattern);

    return regex.hasMatch(email);
  }

  // ✅ LOGIN VALIDATION
  void loginUser() {

    String email = emailController.text.trim();
    String password =
        passwordController.text.trim();

    // EMPTY CHECK
    if (email.isEmpty || password.isEmpty) {

      setState(() {
        errorMessage =
            "Please insert login credentials";
      });

      return;
    }

    // EMAIL FORMAT CHECK
    if (!isValidEmail(email)) {

      setState(() {
        errorMessage =
            "Please enter a valid email address";
      });

      return;
    }

    // CLEAR ERROR
    setState(() {
      errorMessage = "";
    });

    // ✅ GO TO DASHBOARD
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const ResidentDashboard(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(

          padding: const EdgeInsets.symmetric(
              horizontal: 24, vertical: 30),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center,

            children: [

              const SizedBox(height: 90),

              // 🔷 LOGO
              Center(
                child: Image.asset(
                  'assets/logo.png',
                  width: 220,
                  height: 220,
                ),
              ),

              const SizedBox(height: 50),

            // 📧 EMAIL FIELD
            TextField(

              controller: emailController,

              keyboardType: TextInputType.emailAddress,

              onTap: () {

                if (errorMessage.isNotEmpty) {

                  setState(() {
                    errorMessage = "";
                  });
                }
              },

              decoration: InputDecoration(

                hintText: "example@gmail.com",

                labelText: "Email",

                prefixIcon:
                    const Icon(Icons.email),

                filled: true,

                fillColor:
                    Colors.grey.shade100,

                border: OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(14),

                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // 🔒 PASSWORD FIELD
            TextField(

              controller: passwordController,

              obscureText: obscurePassword,

              onTap: () {

                if (errorMessage.isNotEmpty) {

                  setState(() {
                    errorMessage = "";
                  });
                }
              },

              decoration: InputDecoration(

                hintText: "Enter password",

                labelText: "Password",

                prefixIcon:
                    const Icon(Icons.lock),

                suffixIcon: IconButton(

                  icon: Icon(
                    obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),

                  onPressed: () {

                    setState(() {
                      obscurePassword =
                          !obscurePassword;
                    });
                  },
                ),

                filled: true,

                fillColor:
                    Colors.grey.shade100,

                border: OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(14),

                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 28),

            // 🔵 LOGIN BUTTON
            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: loginUser,

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

                  "Login",

                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ❌ ERROR MESSAGE BELOW BUTTON
            if (errorMessage.isNotEmpty)

              Text(
                errorMessage,

                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

            const SizedBox(height: 25),

              // 🔷 SIGNUP TEXT
              Row(

                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  const Text(
                    "Don't have an account? ",
                  ),

                  GestureDetector(

                    onTap: () {

                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (_) =>
                              const SignupScreen(),
                        ),
                      );
                    },

                    child: const Text(

                      "SignUp",

                      style: TextStyle(

                        color:
                            AppColors.primaryBlue,

                        fontWeight:
                            FontWeight.bold,
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
}