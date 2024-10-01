import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../services/database_helper.dart';

class ItemProvider with ChangeNotifier {
  List<Item> _items = [];

  List<Item> get items => _items;

  Future<void> fetchItems() async {
    _items = await DatabaseHelper.instance.getItems();
    notifyListeners();
  }

  Future<void> addItem(String name) async {
    final newItem = Item(name: name);
    await DatabaseHelper.instance.insertItem(newItem);
    fetchItems();
  }

  Future<void> updateItem(Item item) async {
    await DatabaseHelper.instance.updateItem(item);
    fetchItems();
  }

  Future<void> deleteItem(int id) async {
    await DatabaseHelper.instance.deleteItem(id);
    fetchItems();
  }
}
