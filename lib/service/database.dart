import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userInfoMap);
  }

  UpdateUserwallet(String id, String amount) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update({"Wallet": amount});
  }

  Future addItem(Map<String, dynamic> userInfoMap, String name) async {
    return await FirebaseFirestore.instance.collection(name).add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getItem(String name) async {
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }

  Future addItemToCart(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Cart")
        .add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getCart(String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Cart")
        .snapshots();
  }

  Future<void> clearCart(String userId) async {
    try {
      // Lấy tất cả các sản phẩm trong giỏ hàng
      QuerySnapshot cartItems = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('Cart')
          .get();

      // Xóa từng sản phẩm
      for (var doc in cartItems.docs) {
        await doc.reference.delete();
      }

      print('Giỏ hàng đã được xóa thành công');
    } catch (e) {
      print('Lỗi khi xóa giỏ hàng: $e');
    }
  }
}
