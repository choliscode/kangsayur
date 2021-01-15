class CartModel {
  final String cartid;
  final String produkId;
  final String qty;
  final String kategoriID;
  final String createdDate;
  final String nama;
  final String deskripsi;
  final String gambar;
  final String harga;
  final String status;

  CartModel({
    this.cartid,
    this.produkId,
    this.qty,
    this.kategoriID,
    this.createdDate,
    this.nama,
    this.deskripsi,
    this.gambar,
    this.harga,
    this.status,
  });

  factory CartModel.fromJson(Map <String, dynamic> data) {
    return CartModel(
      cartid: data['cartid'],
      produkId: data['produkId'],
      qty: data['qty'],
      kategoriID: data['kategoriID'],
      createdDate: data['createdDate'],
      nama: data['nama'],
      deskripsi: data['deskripsi'],
      gambar: data['gambar'],
      harga: data['harga'],
      status: data['status'],
    );

    // localhost --> file php (jadi url) --> ditarik ke projek di file kumpulan API --> [get] buat model --> halaman data yang akan dikeluarkan (method)
  }
}
