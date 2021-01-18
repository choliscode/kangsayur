class PaymentAPI {
  final String paymentId;
  final String paymentName;
  final String notes;
  final String createdDate;
  final String status;

  PaymentAPI({
    this.paymentId,
    this.paymentName,
    this.notes,
    this.createdDate,
    this.status,
  });

  factory PaymentAPI.fromJson(Map<String, dynamic> data) {
    return PaymentAPI(
      paymentId: data['payment_id'],
      paymentName: data['payment_name'],
      notes: data['notes'],
      createdDate: data['created_Date'],
      status: data['status'],
    );
  }
}
