import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/product_model.dart';
import '../../utills/helper/db_helper.dart';
import '../../utills/utills.dart';

class Cart_page extends StatefulWidget {
  const Cart_page({Key? key}) : super(key: key);

  @override
  State<Cart_page> createState() => _Cart_pageState();
}

class _Cart_pageState extends State<Cart_page> {
  late Future<List<DataBaseBag>> getDataBag;

  @override
  void initState() {
    super.initState();
    getDataBag = DBHelper.dbHelper.fetchBagData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            await DBHelper.dbHelper.deleteBagAllItemDB();
            Get.back();
          },
          icon: Icon(
            CupertinoIcons.back,
          ),
        ),
        title: Text("Cart Page"),
      ),
      body: Container(
        child: FutureBuilder(
            future: getDataBag,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("ERROR:${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                List<DataBaseBag>? data = snapshot.data;
                return (data == null || data.isEmpty)
                    ? const Center(
                        child: Text("No data available"),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              color: Colors.grey.withOpacity(0.2),
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Price : $totalPrice',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      OutlinedButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll( Color(0xFF724FD6),)),
                                          onPressed: () {
                                            Get.toNamed('/coupon_page');
                                          },
                                          child: Text("Apply Coupon",style: TextStyle(color: Colors.white),)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, i) {
                                  return Card(
                                    margin: EdgeInsets.all(10),
                                    child: ListTile(
                                      leading: Text(data[i].id.toString()),
                                      title: Text(data[i].name),
                                      subtitle: Text(
                                          "${data[i].price} \n ${data[i].qts}"),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              print("1");
                                              DBHelper.dbHelper.updateBagDB(
                                                  qts: --data[i].qts,
                                                  id: data[i].id);
                                              totalPrice -= data[i].price;
                                              if (data[i].qts == 0) {
                                                DBHelper.dbHelper.deleteBagDB(
                                                    id: data[i].id);
                                              }
                                              setState(() {});
                                              print("2");
                                            },
                                            icon: Icon(
                                              Icons.remove_circle_outline,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              print("1");
                                              DBHelper.dbHelper.updateBagDB(
                                                  qts: ++data[i].qts,
                                                  id: data[i].id);
                                              print("2");

                                              totalPrice += data[i].price;

                                              setState(() {});
                                            },
                                            icon: Icon(
                                              Icons.add_circle_outline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Spacer(),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      fixedSize: MaterialStatePropertyAll(
                                          Size(250, 50))),
                                  onPressed: () async {
                                    DBHelper.dbHelper.insertCouponDB(
                                        name: controller.text, applied: true);
                                    Get.snackbar("Success",
                                        "Your Payment Done SuccessFully!",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.green);
                                    controller.clear();
                                    name = null;
                                    Get.dialog(AlertDialog(
                                      content: Text("Thank You for Shopping!"),
                                    )).then((value) => Future.delayed(
                                            Duration(seconds: 5), () {
                                          Get.back();
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  '/', (route) => false)
                                              .then((value) => setState(() {}));
                                        }));
                                    await DBHelper.dbHelper
                                        .deleteBagAllItemDB();
                                    checkout.clear();
                                  },
                                  child: Text("Check Out"),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ],
                      );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
