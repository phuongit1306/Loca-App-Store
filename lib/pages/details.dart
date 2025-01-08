import 'package:flutter/material.dart';
import 'package:loca_app2/service/database.dart';
import 'package:loca_app2/service/shared_pref.dart';
import 'package:loca_app2/widget/widget_support.dart';

class Details extends StatefulWidget {
  String name, detail, price;
  Details({required this.detail, required this.name, required this.price});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a = 1, total = 0;
  String? id;

  getthesharedpref() async {
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  ontheLoad() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    ontheLoad();
    total = int.parse(widget.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: AppWidget.semiBooldTextFieldStyle(),
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    if (a > 1) {
                      --a;
                      total = total - int.parse(widget.price);
                    }
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  a.toString(),
                  style: AppWidget.semiBooldTextFieldStyle(),
                ),
                SizedBox(
                  width: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    ++a;
                    total = total + int.parse(widget.price);
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              widget.detail,
              maxLines: 4,
              style: AppWidget.LightTextFieldStyle(),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                Text(
                  "Giao ngay\nThời gian dự kiến",
                  style: AppWidget.semiBooldTextFieldStyle(),
                ),
                SizedBox(
                  width: 25.0,
                ),
                Icon(
                  Icons.alarm,
                  color: Colors.black54,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "30 phút",
                  style: AppWidget.semiBooldTextFieldStyle(),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tổng Tiền",
                        style: AppWidget.semiBooldTextFieldStyle(),
                      ),
                      Text(
                        "\đ" + total.toString(),
                        style: AppWidget.HeadlineTextFieldStyle(),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      Map<String, dynamic> addItemToCart = {
                        "Tên": widget.name,
                        "Số lượng": a.toString(),
                        "Tổng": total.toString(),
                      };
                      await DatabaseMethods().addItemToCart(addItemToCart, id!);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.orangeAccent,
                          content: Text(
                            "Mặt hàng đã được thêm vào giỏ hàng",
                            style: TextStyle(fontSize: 18.0),
                          )));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Thêm vào giỏ hàng",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontFamily: 'Poppins'),
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(8)),
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
