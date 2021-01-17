class UserModel {
  final String userID;
  final String nama;
  final String phone;
  final String alamat;
  final String status;
  final String createdDate;

  UserModel({
    this.userID,
    this.nama,
    this.phone,
    this.alamat,
    this.status,
    this.createdDate,
  });
  
  factory UserModel.fromJson(Map <String, dynamic> data) {
    return UserModel(
      userID: data['userID'],
      nama: data['nama'],
      phone: data['phone'],
      alamat: data['alamat'],
      status: data['status'],
      createdDate: data['createdDate'],
    );
  }
}
