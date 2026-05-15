import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Complaint {
  String category;
  String title;
  String desc;
  String date;
  String status;

  Complaint({
    required this.category,
    required this.title,
    required this.desc,
    required this.date,
    this.status = "Pending",
  });

  Map<String, dynamic> toJson() => {
        "category": category,
        "title": title,
        "desc": desc,
        "date": date,
        "status": status,
      };

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      category: json["category"],
      title: json["title"],
      desc: json["desc"],
      date: json["date"],
      status: json["status"],
    );
  }
}

class ComplaintData {
  static List<Complaint> complaints = [];

  static Future<void> saveComplaints() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> data =
        complaints.map((c) => jsonEncode(c.toJson())).toList();

    await prefs.setStringList("complaints", data);
  }

  static Future<void> loadComplaints() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList("complaints");

    if (data != null) {
      complaints =
          data.map((e) => Complaint.fromJson(jsonDecode(e))).toList();
    }
  }
}