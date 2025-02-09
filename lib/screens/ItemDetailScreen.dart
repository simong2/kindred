import 'package:flutter/material.dart';

class ItemDetailScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  const ItemDetailScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['item_name'] ?? 'Item Details'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Container
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(
                        item['image'] ??
                            'https://images.unsplash.com/photo-1579546929518-9e396f3cc809?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=400',
                      ),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.grey.shade200,
                  ),
                ),
                const SizedBox(height: 20),

                // Item Name
                Text(
                  item['item_name'] ?? "Unknown Item",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // Category and Organization
                Text(
                  "Category: ${item['category'] ?? 'Uncategorized'}",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Organization: ${item['organization'] ?? 'Unknown'}",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),

                // Date Posted
                Text(
                  "Date Posted: ${item['date_posted'] ?? 'Unknown'}",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),

                // Status
                Text(
                  "Status: ${item['status'] ?? 'Unavailable'}",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 24),

                // Action Buttons (Side-by-side)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // "I Pass" Button
                    ElevatedButton(
                      onPressed: () {
                        // Action for "I Pass"
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "I Pass",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),

                    // "Yes, I Want to Donate" Button
                    ElevatedButton(
                      onPressed: () {
                        // Action for "Yes, I Want to Donate"
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Yes, I Want to Donate",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
