import 'package:flutter/material.dart';

/// ✅ Reusable AppBar Utility with Optional Tabs
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final List<Tab>? tabs; // ✅ Optional TabBar

  static const darkGreen = 0xFF667B68;
  static const mediumGreen = 0xFFA3B899;
  static const lightGreen = 0xFFDDE6D5;

  const CustomAppBar(
      {Key? key, required this.title, this.onBackPressed, this.tabs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFA3B899), // ✅ Set AppBar background color
      title: Row(
        children: [
          GestureDetector(
            onTap: onBackPressed ??
                () => Navigator.pop(context), // ✅ Default back action
            child: const Icon(Icons.chevron_left,
                color: Color(darkGreen), size: 28), // ✅ White chevron icon
          ),
          const SizedBox(width: 8), // Space between icon and text
          Text(
            title,
            style: TextStyle(
                color: Color(darkGreen),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      centerTitle: true,
      automaticallyImplyLeading: false, // ✅ Disable default back button
      bottom: (tabs != null &&
              tabs!.length > 1) // ✅ If tabs exist and are more than 1
          ? TabBar(
              tabs: tabs!,
              indicatorColor: Colors.white,
            )
          : null,
    );
  }

  @override
  Size get preferredSize => tabs != null && tabs!.length > 1
      ? const Size.fromHeight(100)
      : const Size.fromHeight(kToolbarHeight);
}
