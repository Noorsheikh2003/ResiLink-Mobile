import 'package:flutter/material.dart';
//import 'staff_dashboard.dart';
//import 'resident_dashboard.dart';
import 'models/complaint_data.dart';
import 'screens/auth/splash_screen.dart';

const Color primaryBlue = Color(0xFF00129C); //  global color

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //  REQUIRED
  await ComplaintData.loadComplaints();      //  LOAD DATA
  runApp(const ResiLinkApp());               //  FIXED
}

//  ROOT APP
class ResiLinkApp extends StatelessWidget {
  const ResiLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ResiLink',

      theme: ThemeData(
        primaryColor: primaryBlue,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),

      home: const SplashScreen(),
    );
  }
}