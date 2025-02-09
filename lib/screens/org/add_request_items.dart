import 'package:flutter/material.dart';
import 'package:kindred/services/firebase_services.dart';

class AddRequestItems extends StatefulWidget {
  const AddRequestItems({super.key});

  @override
  State<AddRequestItems> createState() => _AddRequestItemsState();
}

class _AddRequestItemsState extends State<AddRequestItems> {
  final Map<int, String> _imgs = {
    1: 'assets/items/beanie.png',
    2: 'assets/items/canned_food.png',
    3: 'assets/items/gloves.png',
    4: 'assets/items/hoodie.png',
    5: 'assets/items/joggers.png',
    6: 'assets/items/pads.png',
    7: 'assets/items/scarf.png',
    8: 'assets/items/toothbrush.png',
    9: 'assets/items/towels.png',
    10: 'assets/items/tshirt.png',
  };

  int _imagePointer = 1;

  void _updatePointer(int? val) {
    if (val is int) {
      setState(() {
        _imagePointer = val;
      });
    }
  }

  // controllers
  late TextEditingController _itemDescController;
  late TextEditingController _itemQuantityController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _itemDescController = TextEditingController();
    _itemQuantityController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _itemDescController.dispose();
    _itemQuantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Add requesting item'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            SizedBox(
              height: height * .18,
              width: double.infinity,
              child: Card(
                color: Colors.white,
                child: Image.asset(_imgs[_imagePointer]!),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Select item: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  width: 25,
                ),
                DropdownButton(
                  dropdownColor: Colors.white,
                  items: const [
                    DropdownMenuItem(
                      value: 1,
                      child: Text('Beanie'),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text('Canned Foods'),
                    ),
                    DropdownMenuItem(
                      value: 3,
                      child: Text('Gloves'),
                    ),
                    DropdownMenuItem(
                      value: 4,
                      child: Text('Hoodie'),
                    ),
                    DropdownMenuItem(
                      value: 5,
                      child: Text('Joggers'),
                    ),
                    DropdownMenuItem(
                      value: 6,
                      child: Text('Pads'),
                    ),
                    DropdownMenuItem(
                      value: 7,
                      child: Text('Scarf'),
                    ),
                    DropdownMenuItem(
                      value: 8,
                      child: Text('Toothbrush'),
                    ),
                    DropdownMenuItem(
                      value: 9,
                      child: Text('Towels'),
                    ),
                    DropdownMenuItem(
                      value: 10,
                      child: Text('T-Shirt'),
                    ),
                  ],
                  value: _imagePointer,
                  onChanged: _updatePointer,
                ),
              ],
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: width / 1.4,
              child: TextField(
                maxLength: 25,
                controller: _itemDescController,
                decoration: const InputDecoration(
                  labelText: 'Item description',
                ),
              ),
            ),
            const SizedBox(height: 25),
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  const Text(
                    'Quantity:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                  const SizedBox(width: 30),
                  SizedBox(
                    width: width / 3,
                    child: TextField(
                      controller: _itemQuantityController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Quantity',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * .1),
            SizedBox(
              width: width / 2,
              child: ElevatedButton(
                onPressed: () {
                  try {
                    FirebaseServices().postOrgItem(
                      _imgs[_imagePointer]!,
                      _itemDescController.text,
                      _itemQuantityController.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Item added!'),
                      ),
                    );
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${e.toString()}'),
                      ),
                    );
                  }
                },
                child: const Text('Submit request'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
