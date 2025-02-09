import 'package:flutter/material.dart';

class ItemDetailScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  const ItemDetailScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Placeholder image if none is provided
    String placeholderImage =
        "https://images.unsplash.com/photo-1579546929518-9e396f3cc809?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=400";

    // Determine if the image is a local asset or a URL
    Widget itemImage = Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: Color(0xFF80BFFF), width: 1), // 1px Carolina blue border
        ),
      ),
      child: item['image'] != null
          ? item['image']!.startsWith("http")
              ? Image.network(
                  item['image']!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250,
                  errorBuilder: (context, error, stackTrace) => Image.network(
                    placeholderImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 250,
                  ),
                )
              : Image.asset(
                  item['image']!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250,
                )
          : Image.network(
              placeholderImage,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250,
            ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          (item['item_name'] ?? 'Item Details').toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white, size: 32),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with bottom border
            itemImage,

            const SizedBox(height: 20),

            // Item Details in a structured way
            _buildDetailRow("Category", item['category'] ?? 'Uncategorized'),
            _buildDetailRow("Organization", item['organization'] ?? 'Unknown'),
            _buildDetailRow("Date Posted", item['date_posted'] ?? 'Unknown'),
            _buildDetailRow("Status", item['status'] ?? 'Unavailable'),

            const Spacer(), // Pushes buttons to bottom

            // Action Buttons with equal sizes
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(0), // Removed rounded border
                      ),
                    ),
                    child: const Text(
                      "I Pass",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(0), // Removed rounded border
                      ),
                    ),
                    child: const Text(
                      "Yes, I Want to Donate",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20), // Space below buttons
          ],
        ),
      ),
    );
  }

  // Helper method to create structured detail rows
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 18, color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
