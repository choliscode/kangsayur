class BASEURL {
  static String urlApi = "http://192.168.43.149/sayurApp/api";
  static String urlImages = "http://192.168.43.149/sayurApp/assets/images";
  static String urlAuth = "$urlApi/auth";
  static String urlProduk = "$urlApi/produk";
  static String urlKeranjang = "$urlApi/cart";
  static String registrasi = "$urlAuth/registrasi.php";
  static String login = "$urlAuth/login.php";
  static String getProduk = "$urlProduk/getProduk.php";
  static String imageProduct = "$urlImages/produk/";
  static String imageCategory = "$urlImages/icon/";
  static String addKeranjang = "$urlKeranjang/cart.php";
  static String getKeranjang = "$urlKeranjang/getCart.php?deviceID=";
  static String deleteMenuKeranjang = "$urlKeranjang/deleteCart.php";
  static String updateQuantity = "$urlKeranjang/updateQuantity.php";
  static String totalCart = "$urlKeranjang/totalPriceCat.php?deviceID=";
  static String totalItem = "$urlKeranjang/totalItem.php?deviceID=";
  static String getcategoryproduct = "$urlProduk/getcategoryproduct.php";
}