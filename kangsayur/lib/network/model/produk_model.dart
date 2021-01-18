class ProductModel {
  final String produkId;
  final String kategoriID;
  final String nama;
  final String deskripsi;
  final String gambar;
  final String harga;
  final String status;
  final String createdDate;

  ProductModel({
    this.produkId,
    this.kategoriID,
    this.nama,
    this.deskripsi,
    this.gambar,
    this.harga,
    this.status,
    this.createdDate,
  });
  // optional parameter

  factory ProductModel.fromJson(Map<String, dynamic> data) {
    return ProductModel(
      produkId: data['produkId'],
      kategoriID: data['kategoriID'],
      nama: data['nama'],
      deskripsi: data['deskripsi'],
      gambar: data['gambar'],
      harga: data['harga'],
      status: data['status'],
      createdDate: data['createdDate'],
    );

    // localhost --> file php (jadi url) --> ditarik ke projek di file kumpulan API --> [get] buat model --> halaman data yang akan dikeluarkan (method)
  }
}


// class product with categorynya
class Getcategoryproduct {
  final String categoriID;
  final String namaKategori;
  final String gambar;
  final String status;

  final List<ProductModel> produk;

  var kategoriID;

  Getcategoryproduct({
    this.categoriID,
    this.namaKategori,
    this.gambar,
    this.status,
    this.produk,
  });

  factory Getcategoryproduct.fromJson(Map<String, dynamic> data) {
    var list = data['produk'] as List;
    List<ProductModel> dataProduk =
        list.map((data) => ProductModel.fromJson(data)).toList();
    return Getcategoryproduct(
      categoriID: data['ketegoriID'],
      namaKategori: data['namaKategori'],
      gambar: data['gambar'],
      status: data['status'],
      produk: dataProduk,
    );
  }
}
