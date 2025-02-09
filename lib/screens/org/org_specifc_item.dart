import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kindred/services/firebase_services.dart';

class OrgSpecifcItem extends StatefulWidget {
  final String id;
  const OrgSpecifcItem({super.key, required this.id});

  @override
  State<OrgSpecifcItem> createState() => _OrgSpecifcItemState();
}

class _OrgSpecifcItemState extends State<OrgSpecifcItem> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> _itemFuture;
  late TextEditingController _newDescController;
  late TextEditingController _newQuantController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _newDescController = TextEditingController();
    _newQuantController = TextEditingController();
    _getAllValues();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _newDescController.dispose();
    _newQuantController.dispose();
    super.dispose();
  }

  // get the values on init
  void _getAllValues() async {
    _itemFuture = FirebaseServices().getSpecifcOrgStuff(widget.id);
  }

  String newDesc = "";
  bool isDescUpdated = false;
  String newQuant = "";
  bool isQuantUpdated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Current Values'),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: _itemFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error loading data'),
                );
              } else {
                final data = snapshot.data!;

                String itemDesc = data['itemDesc'];
                int quantity = data['quantity'];
                return Column(
                  children: [
                    isDescUpdated
                        ? const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'NEW Item description: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                              ),
                            ),
                          )
                        : const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Item description: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                              ),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          isDescUpdated ? newDesc : itemDesc,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: const Text('New description'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: _newDescController,
                                      maxLength: 25,
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Close'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_newDescController.text == "" ||
                                          _newDescController == null) {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'No update was made. Please fill in value to update.'),
                                          ),
                                        );
                                      } else {
                                        setState(() {
                                          isDescUpdated = true;
                                        });
                                        newDesc = _newDescController.text;
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Confirm by hitting `confirm button` above'),
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text('Update value'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text('edit'),
                      ),
                    ),
                    const Divider(),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        isQuantUpdated ? 'NEW quantity' : 'Quantity: ',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                    ),
                    Text(
                      isQuantUpdated ? newQuant : quantity.toString(),
                      style: const TextStyle(
                        fontSize: 23,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: const Text('New Quantity'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: _newQuantController,
                                      maxLength: 25,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Close'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_newQuantController.text == "" ||
                                          _newQuantController == null) {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'No update was made. Please fill in value to update.'),
                                          ),
                                        );
                                      } else {
                                        setState(() {
                                          isQuantUpdated = true;
                                        });
                                        newQuant = _newQuantController.text;
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Confirm by hitting `confirm button` above'),
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text('Update value'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text('edit'),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  if (isDescUpdated) {
                    FirebaseServices().updateSpecificDesc(widget.id, newDesc);
                  }
                  if (isQuantUpdated) {
                    int x = int.parse(newQuant);
                    FirebaseServices().updateSpecificQuant(widget.id, x);
                  }

                  setState(() {}); // force ui update
                },
                child: const Text('Confirm edits'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {},
                child: const Text('Delete'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
