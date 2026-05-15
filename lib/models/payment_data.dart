class Payment {
  final String title;
  final String amount;
  final String date;
  final String method;

  Payment({
    required this.title,
    required this.amount,
    required this.date,
    required this.method,
  });
}

class PaymentData {
  static List<Payment> payments = [];
}