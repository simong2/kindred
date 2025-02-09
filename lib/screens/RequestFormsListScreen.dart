import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kindred/screens/ItemDetailScreen.dart';
import 'package:kindred/screens/sign_up.dart';

class RequestFormsListScreen extends StatelessWidget {
  const RequestFormsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = List.generate(
      50,
      (index) {
        // Define categories
        List<String> categories = [
          "Clothing",
          "Footwear",
          "Accessories",
          "Electronics",
          "Books",
          "Home Decor",
          "Toys",
          "Sports Equipment",
          "Beauty",
          "Kitchenware"
        ];

        // Define different image URLs (mix of local assets & web URLs)
        List<String> imageUrls = [
          "assets/img/l1.png",
          "assets/img/l2.png",
          "assets/img/l3.png",
          "assets/img/l4.png",
          "assets/img/l5.png",
          "assets/img/l6.png",
          "assets/img/l7.png",
          "assets/img/l8.png",
          "assets/img/l9.png",
          "assets/img/l10.png",
        ];

        // Assign a category cyclically
        String category = categories[index % categories.length];

        // Assign a unique item name
        String itemName = "$category Item $index";

        // Assign an image dynamically
        String? image =
            index % 3 == 0 ? null : imageUrls[index % imageUrls.length];

        return {
          "category": category,
          "item_name": itemName,
          "date_posted": "${index + 1} m ago",
          "status": "Pending",
          "organization": "Organization $index",
          "image": image,
        };
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Current Requests".toUpperCase(),
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
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              children: [
                // Image Container
                Container(
                  margin: const EdgeInsets.all(8.0),
                  width: 100, // Increased width
                  height: 100, // Increased height
                  decoration: BoxDecoration(
                    color: item['image'] == null
                        ? Colors.transparent
                        : const Color(0xFF80BFFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: item['image'] != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: item['image']!.startsWith('http')
                              ? Image.network(
                                  item['image']!,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  item['image']!,
                                  fit: BoxFit.cover,
                                ),
                        )
                      : const Center(
                          child: Icon(Icons.broken_image, color: Colors.red)),
                ),

                // Text Information Container
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category and Item Name with Chevron in between
                        Row(
                          children: [
                            Text(
                              item['category'],
                              style: const TextStyle(
                                fontSize: 17, // Increased by 1em (from 16px)
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(Icons.chevron_right,
                                size: 18, color: Colors.grey),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                item['item_name'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),

                        // Date Posted
                        Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 5),
                            Text(
                              "Posted: ${item['date_posted']}",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),

                        // Organization
                        Row(
                          children: [
                            const Icon(Icons.business,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 5),
                            Text(
                              "From: ${item['organization']}",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Navigation Icon
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios,
                      size: 20, color: Colors.blue),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemDetailScreen(item: item),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Refresh logic here
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.refresh),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: const Text("Pull to refresh or tap the button above."),
        ),
      ),
    );
  }
}
