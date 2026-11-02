import 'package:flutter/material.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({super.key});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  int selectedTab = 0;
  String searchQuery = '';

  final List<String> tabs = [
    'All Items',
    'Materials',
    'Other',
  ];

  final List<Map<String, String>> items = [
    {
      'name': 'Originium Ore',
      'category': 'Materials',
      'description': 'Raw material',
    },
    {
      'name': 'Originium Powder',
      'category': 'Materials',
      'description': 'Processed material',
    },
    {
      'name': 'Amethyst Component',
      'category': 'Other',
      'description': 'Factory component',
    },
    {
      'name': 'Ferrium Ore',
      'category': 'Materials',
      'description': 'Raw material',
    },
    {
      'name': 'Xiranite',
      'category': 'Materials',
      'description': 'Raw material',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredItems = items.where((item) {
      final matchesTab = selectedTab == 0 ||
          item['category'] == tabs[selectedTab];

      final matchesSearch = item['name']!
          .toLowerCase()
          .contains(searchQuery.toLowerCase());

      return matchesTab && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF17191B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111315),
        foregroundColor: Colors.white,
        title: const Text('Items & Materials'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search items...',
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white54,
                ),
                filled: true,
                fillColor: const Color(0xFF25292C),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Row(
            children: List.generate(tabs.length, (index) {
              final selected = selectedTab == index;

              return Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedTab = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    color: selected
                        ? const Color(0xFFFFD600)
                        : const Color(0xFF25292C),
                    child: Text(
                      tabs[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: selected ? Colors.black : Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),

          Expanded(
            child: filteredItems.isEmpty
                ? const Center(
              child: Text(
                'No items found.',
                style: TextStyle(color: Colors.white54),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];

                return Card(
                  color: const Color(0xFF25292C),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: const Icon(
                      Icons.inventory_2_outlined,
                      color: Color(0xFFFFD600),
                      size: 30,
                    ),
                    title: Text(
                      item['name']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      item['description']!,
                      style: const TextStyle(color: Colors.white54),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.white54,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ItemDetailScreen(
                            item: item,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ITEM DETAIL SCREEN

class ItemDetailScreen extends StatefulWidget {
  final Map<String, String> item;

  const ItemDetailScreen({
    super.key,
    required this.item,
  });

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  bool isLiked = false;
  bool isSaved = false;

  final TextEditingController commentController =
  TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      backgroundColor: const Color(0xFF17191B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111315),
        foregroundColor: Colors.white,
        title: const Text('Item Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ITEM PREVIEW
            Container(
              width: double.infinity,
              height: 210,
              decoration: BoxDecoration(
                color: const Color(0xFF25292C),
                border: Border.all(
                  color: const Color(0xFF41464A),
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                Icons.inventory_2_outlined,
                size: 75,
                color: Color(0xFFFFD600),
              ),
            ),

            const SizedBox(height: 18),

            // ITEM NAME
            Text(
              item['name'] ?? 'Unknown Item',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              item['description'] ?? '',
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 16),

            // LIKE, SAVE, SHARE
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    icon: isLiked
                        ? Icons.favorite
                        : Icons.favorite_border,
                    label: 'Like',
                    active: isLiked,
                    onTap: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _ActionButton(
                    icon: isSaved
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                    label: 'Save',
                    active: isSaved,
                    onTap: () {
                      setState(() {
                        isSaved = !isSaved;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _ActionButton(
                    icon: Icons.share_outlined,
                    label: 'Share',
                    onTap: () {
                      showMessage('Share feature coming soon.');
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // CATEGORY
            const Text(
              'CATEGORY',
              style: TextStyle(
                color: Color(0xFFFFD600),
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              item['category'] ?? 'Unknown',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 24),

            // RELATED MATERIALS & MACHINES
            const Text(
              'MATERIALS & MACHINES',
              style: TextStyle(
                color: Color(0xFFFFD600),
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF25292C),
                border: Border.all(
                  color: const Color(0xFF41464A),
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                'No related materials or machines available.',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // COMMENTS
            const Text(
              'COMMENTS',
              style: TextStyle(
                color: Color(0xFFFFD600),
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: commentController,
              style: const TextStyle(color: Colors.white),
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Write a comment...',
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: const Color(0xFF25292C),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Color(0xFF41464A),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  if (commentController.text.trim().isEmpty) {
                    showMessage('Please write a comment first.');
                    return;
                  }

                  showMessage('Comment feature coming soon.');
                  commentController.clear();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD600),
                  foregroundColor: Colors.black,
                ),
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// REUSABLE ACTION BUTTON

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF25292C),
          border: Border.all(
            color: active
                ? const Color(0xFFFFD600)
                : const Color(0xFF41464A),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: active
                  ? const Color(0xFFFFD600)
                  : Colors.white70,
              size: 19,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: active
                    ? const Color(0xFFFFD600)
                    : Colors.white70,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
