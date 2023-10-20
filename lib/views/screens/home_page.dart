import 'package:final_exam/utills/helper/firebase_auth_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/product_model.dart';
import '../../utills/helper/db_helper.dart';
import '../../utills/utills.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  late Future<List<DataBaseProduct>> getData;

  @override
  void initState() {
    super.initState();
    deleteData();
    getData = DBHelper.dbHelper.fetchData();
  }

  deleteData() async {
    await DBHelper.dbHelper.deleteBagAllItemDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () async {
              await FireBaseAuthHelper.fireBaseAuthHelper.signOut();

              Get.toNamed('/login_page');
            },
            icon: const Icon(CupertinoIcons.power),
          ),
          IconButton(
            onPressed: () async {
              await DBHelper.dbHelper.insertBagDB(data: checkout);

              Get.toNamed('cart_page');
            },
            icon: const Icon(
             Icons.add_shopping_cart_outlined
            ),
          ),
        ],
      ),
      body: FutureBuilder(
          future: getData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              List<DataBaseProduct>? data = snapshot.data;

              return (data == null || data.isEmpty)
                  ? const Center(
                      child: Text("No data available..."),
                    )
                  : ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, i) {
                        return Card(elevation: 3,
                          child: ListTile(
                            leading: Text("${data[i].id}"),
                            title: Text(data[i].name),
                            subtitle: Text("${data[i].price}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    print("1");
                                    // DBHelper.dbHelper.insertBagDB(data: data[i]);
                                    checkout.add(data[i]);
                                    totalPrice += data[i].price!;
                                    print("2");
                                  },
                                  icon: const Icon(
                                    Icons.add_circle_outline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
