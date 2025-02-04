// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:fit_form/models/healty_diet.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<HealtyDiet>> healthyNotify = ValueNotifier([]);

Future<void> healthyDietInitialize() async {
  if (!Hive.isAdapterRegistered(HealtyDietAdapter().typeId)) {
    Hive.registerAdapter(HealtyDietAdapter());
  }
  await getHealtyDiet();
}

Future<void> addHeathyDiets(HealtyDiet healty) async {
  final db = await Hive.openBox<HealtyDiet>('HealtyDiets');
  String customId = DateTime.now().microsecondsSinceEpoch.toString();
  healty.id = customId;
  await db.add(healty);
}

Future<void> getHealtyDiet() async {
  final db = await Hive.openBox<HealtyDiet>('HealtyDiets');
  healthyNotify.value = db.values.toList();
  healthyNotify.notifyListeners();
}

Future<void> deletDiet(int id) async {
  final db = await Hive.openBox<HealtyDiet>('HealtyDiets');
  await db.deleteAt(id);
  await getHealtyDiet();
  healthyNotify.value = db.values.toList();
}



Future<void> editHealthyDiet(String id, HealtyDiet editDiet) async {
  final db = await Hive.openBox<HealtyDiet>('HealtyDiets');
  
  // Find the index of the item to edit
  int indexToEdit = -1;
  for (int i = 0; i < db.length; i++) {
    if (db.getAt(i)?.id == id) {
      indexToEdit = i;
      break;
    }
  }
  
  if (indexToEdit != -1) {
    // Update at the correct index
    await db.putAt(indexToEdit, editDiet);
  } else {
  }
  
  await getHealtyDiet();
}