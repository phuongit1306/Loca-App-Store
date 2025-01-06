class UnboardingContent {
  String image;
  String title;
  String description;
  UnboardingContent(
      {required this.description, required this.image, required this.title});
}

List<UnboardingContent> contents = [
  UnboardingContent(
      description: 'Lựa chọn đa dạng\n  Tiện lợi cho bạn ',
      image: "images/screen1.png",
      title: 'Chọn lựa sản phẩm tốt nhất\n từ ứng dụng của chúng tôi'),
  UnboardingContent(
      description:
          'Bạn có thể thanh toán bằng tiền mặt khi\n    giao hàng hoặc thanh toán bằng thẻ',
      image: "images/screen2.png",
      title: 'Thanh toán trực tuyến\n              dễ dàng'),
  UnboardingContent(
      description:
          'Dịch vụ giao hàng đảm bảo an toàn\n                 nhanh chóng',
      image: "images/screen3.png",
      title: 'Giao hàng tận cửa nhà\n              của bạn'),
];
