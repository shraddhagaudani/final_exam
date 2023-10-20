
import 'package:get/get.dart';

import '../models/insert_model.dart';
import '../utills/utills.dart';

class Insert_GC extends GetxController{
  Insert insert = Insert(insert: box.read('insert') ?? false, insertBag: box.read('insertBag') ?? false);

  trueWhenInsert() async {
    insert.insert = true;
    await box.write('insert', insert.insert);
  }
  trueWhenInsertBag() async {
    insert.insertBag = true;
    await box.write('insertBag', insert.insertBag);
  }
}