import 'package:final_exam/controller/theme_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Setting_page extends StatefulWidget {
  const Setting_page({super.key});

  @override
  State<Setting_page> createState() => _Setting_pageState();
}

class _Setting_pageState extends State<Setting_page> {
  @override
  Widget build(BuildContext context) {
    Themecontroller themecontroller = Get.put(Themecontroller());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GetBuilder<Themecontroller>(
              builder: (_) {
                return ListTile(
                  leading: const Text("Change Theme"),
                  trailing: Switch(
                      value: themecontroller.themeModel.isdark,
                      onChanged: (val) {
                        themecontroller.changeTheme(Val: val);
                      }),
                  // trailing: IconButton(
                  //   onPressed: () async {
                  //     await themecontroller.changeTheme(Val: themecontroller.themeModel.isdark);
                  //   },
                  //   icon: (themecontroller.themeModel.isdark)
                  //       ? const Icon(CupertinoIcons.sun_min)
                  //       : const Icon(Icons.nightlight),
                  // ),
                  tileColor: Colors.deepPurple.shade200,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
