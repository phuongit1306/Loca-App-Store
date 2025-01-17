import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:loca_app2/service/database.dart';
import 'package:loca_app2/service/shared_pref.dart';
import 'package:loca_app2/widget/app_constant.dart';
import 'package:loca_app2/widget/widget_support.dart';
import 'package:http/http.dart' as http;

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String? wallet, id;
  int? add;

  getthesharedpref() async {
    wallet = await SharedPreferenceHelper().getUserWallet();
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: wallet == null
          ? CircularProgressIndicator()
          : Container(
              margin: EdgeInsets.only(top: 60.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    elevation: 2.0,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Center(
                        child: Text(
                          "Ví tiền của bạn",
                          style: AppWidget.HeadlineTextFieldStyle(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Color(0xFFF2F2F2)),
                    child: Row(
                      children: [
                        Image.asset(
                          "images/wallet.png",
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: 40.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Số dư của bạn",
                              style: AppWidget.LightTextFieldStyle(),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "\đ" + wallet!,
                              style: AppWidget.boldTextFieldStyle(),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Thêm tiền vào tài khoản",
                      style: AppWidget.semiBooldTextFieldStyle(),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print('Tapped 50.000');
                          makePayment('50.000');
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 69, 228, 55)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "\đ" + "50.000",
                            style: AppWidget.semiBooldTextFieldStyle(),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          makePayment('100.000');
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 48, 221, 233)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "\đ" + "100.000",
                            style: AppWidget.semiBooldTextFieldStyle(),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          makePayment('200.000');
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 233, 229, 23)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "\đ" + "200.000",
                            style: AppWidget.semiBooldTextFieldStyle(),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          makePayment('500.000');
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 241, 23, 23)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "\đ" + "500.000",
                            style: AppWidget.semiBooldTextFieldStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 221, 18, 18),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "Thêm Tiền",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      print("Making payment for: $amount");
      paymentIntent = await createPaymentIntent(amount, 'VND');

      if (paymentIntent != null) {
        await Stripe.instance
            .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                paymentIntentClientSecret: paymentIntent!['client_secret'],
                style: ThemeMode.dark,
                merchantDisplayName: 'Adnan',
              ),
            )
            .then((value) {});

        displayPaymentSheet(amount);
      } else {
        print("paymentIntent is null");
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        add = int.parse(wallet!) + int.parse(amount.replaceAll('.', ''));
        await SharedPreferenceHelper().saveUserWallet(add.toString());
        await DatabaseMethods().UpdateUserwallet(id!, add.toString());
        await DatabaseMethods().clearCart(id!);

        await ontheload(); // Reload giỏ hàng sau khi thanh toán
        setState(() {}); // Cập nhật lại giao diện

        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Text("Thanh toán thành công"),
                        ],
                      ),
                    ],
                  ),
                ));
        await getthesharedpref();
        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Hủy bỏ "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    // Loại bỏ tất cả dấu chấm và chuyển đổi chuỗi thành số
    final cleanedAmount = amount.replaceAll('.', '');
    try {
      final calculatedAmount = int.parse(cleanedAmount);
      return (calculatedAmount).toString();
    } catch (e) {
      print("Error parsing amount: $e");
      return '0';
    }
  }
}
