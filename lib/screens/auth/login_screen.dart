import 'package:flutter/material.dart';
import '../resident/resident_dashboard.dart';
//import '../staff/staff_dashboard.dart';
import 'signup_screen.dart';
import '../../colors.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: 24, vertical: 30),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
         
              const SizedBox(height: 60),

              // 📧 EMAIL FIELD
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.email),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // 🔒 PASSWORD FIELD
              TextField(
                controller: passwordController,
                obscureText: obscurePassword,

                decoration: InputDecoration(
                  hintText: "Password",

                  prefixIcon:
                      const Icon(Icons.lock),

                  // 👁 EYE ICON
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
                  fillColor: Colors.grey.shade100,

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
                  onPressed: () {

                    // 🔥 GO TO DASHBOARD
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const ResidentDashboard(),
                      ),
                    );
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
                    "Login",
                    style: TextStyle(fontSize: 16),
                  ),
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
                        builder: (_) => const SignupScreen(),
                      ),
                    );
                  },

                    child: const Text(
                      "SignUp",
                      style: TextStyle(
                        color:
                            AppColors.primaryBlue,
                        fontWeight: FontWeight.bold,
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