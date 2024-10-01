import 'package:flutter/material.dart';
import 'package:jdiin_pratama_crud_sqlite/models/item_model.dart';
import 'package:provider/provider.dart';

import '../providers/item_provider.dart';

class UserFormScreen extends StatefulWidget {
  final Item? item;

  const UserFormScreen({super.key, this.item});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.item != null ? widget.item!.name : '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? 'Tambah Item' : 'Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Nama Item'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Nama item tidak boleh kosong'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  return;
                }

                if (widget.item == null) {
                  itemProvider.addItem(_controller.text);
                } else {
                  itemProvider.updateItem(
                    Item(id: widget.item!.id, name: _controller.text),
                  );
                }
                Navigator.pop(context);
              },
              child: Text(widget.item == null ? 'Simpan' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }
}
