import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loca_app2/pages/details.dart';
import 'package:loca_app2/service/database.dart';
import 'package:loca_app2/widget/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool food = false, drink = false, quanao = false, family = false;

  Stream? itemStream;

  ontheLoad() async {
    itemStream = await DatabaseMethods().getItem("Drink");
    setState(() {});
  }

  @override
  void initState() {
    ontheLoad();
    super.initState();
  }

  Widget allItemsVertically() {
    return StreamBuilder(
        stream: itemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Details()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 20.0, bottom: 5.0),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 20.0,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: ClipRRect(
                                        child: Text(
                                          ds["Name"],
                                          style: AppWidget
                                              .semiBooldTextFieldStyle(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        "(Tôm, kim chi, mực,...)",
                                        style: AppWidget.LightTextFieldStyle(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25.0,
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        "\đ" + ds["Price"],
                                        style:
                                            AppWidget.semiBooldTextFieldStyle(),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator();
        });
  }

  Widget allItems() {
    return StreamBuilder(
        stream: itemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Details()));
                      },
                      child: Container(
                        margin: EdgeInsets.all(4),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Text(
                                    ds["Name"],
                                    style: AppWidget.semiBooldTextFieldStyle(),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "Đang bán chạy",
                                  style: AppWidget.LightTextFieldStyle(),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "\đ" + ds["Price"],
                                  style: AppWidget.semiBooldTextFieldStyle(),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Xin chào bạn", style: AppWidget.boldTextFieldStyle()),
                Container(
                  margin: EdgeInsets.only(right: 20.0),
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)),
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 23.0,
            ),
            Text("Loca App Store", style: AppWidget.HeadlineTextFieldStyle()),
            Text("App bán lẻ thịnh hành nhất hiện nay",
                style: AppWidget.LightTextFieldStyle()),
            SizedBox(
              height: 20.0,
            ),
            Container(margin: EdgeInsets.only(right: 20.0), child: showItem()),
            SizedBox(
              height: 30.0,
            ),
            Container(height: 270, child: allItems()),
            allItemsVertically(),
          ],
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            food = true;
            drink = false;
            quanao = false;
            family = false;
            itemStream = await DatabaseMethods().getItem("Food");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: food ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/food.png",
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                color: food ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            food = false;
            drink = true;
            quanao = false;
            family = false;
            itemStream = await DatabaseMethods().getItem("Drink");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: drink ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/drink.png",
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                color: drink ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            food = false;
            drink = false;
            quanao = true;
            family = false;
            itemStream = await DatabaseMethods().getItem("Quanao");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: quanao ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/quanao.png",
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                color: quanao ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            food = false;
            drink = false;
            quanao = false;
            family = true;
            itemStream = await DatabaseMethods().getItem("Family");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: family ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/family.png",
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                color: family ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
