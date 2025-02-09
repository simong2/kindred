import 'package:flutter/material.dart';
import 'package:kindred/screens/sign_up.dart';

class RequestFormsListScreen extends StatelessWidget {
  const RequestFormsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = List.generate(
        50,
        (index) => {
              "category": index % 2 == 0 ? "Clothing" : "Footwear",
              "item_name": index % 2 == 0 ? "Shirt $index" : "Sneakers $index",
              "date_posted": "${index + 1} m ago",
              "status": "Pending",
              "organization": "Organization $index",
              "image": index % 3 == 0 ? null : "https://via.placeholder.com/150"
            });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Forms List"),
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
                Container(
                  margin: const EdgeInsets.all(8.0),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: item['image'] == null
                        ? Colors.transparent
                        : const Color(0xFF80BFFF),
                    border: Border.all(
                      color: item['image'] == null
                          ? Colors.red
                          : Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: item['image'] != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            item['image']!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : null,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Category: ${item['category']}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Item Name: ${item['item_name']}"),
                      Text("Date Posted: ${item['date_posted']}"),
                      Text("Status: ${item['status']}"),
                      Text("Organization: ${item['organization']}"),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
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

class ItemDetailScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  const ItemDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details: ${item['item_name']}"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: item['image'] == null
                    ? Colors.transparent
                    : const Color(0xFF80BFFF),
                border: Border.all(
                  color:
                      item['image'] == null ? Colors.red : Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: item['image'] != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        item['image']!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : null,
            ),
            const SizedBox(height: 16),
            Text(
              "Category: ${item['category']}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text("Item Name: ${item['item_name']}"),
            Text("Date Posted: ${item['date_posted']}"),
            Text("Status: ${item['status']}"),
            Text("Organization: ${item['organization']}"),
          ],
        ),
      ),
    );
  }
}

class LoginState extends StatefulWidget {
  const LoginState({super.key});

  @override
  State<LoginState> createState() => _LoginStateState();
}

class _LoginStateState extends State<LoginState> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Donor'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Log-in'),
              Tab(text: 'Sign-up'),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: TabBarView(
          children: [
            Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: width / 1.3,
                              child: TextField(
                                controller: _usernameController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  fillColor: Colors.white,
                                  labelText: 'Email',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              width: width / 1.3,
                              child: TextField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.password),
                                  suffixIcon: Icon(Icons.remove_red_eye),
                                  fillColor: Colors.white,
                                  labelText: 'Password',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            SizedBox(
                              width: width / 2,
                              height: height * .06,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RequestFormsListScreen()));
                                },
                                child: const Text('Log in'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SignUp(),
          ],
        ),
      ),
    );
  }
}
