
import 'package:flutter/material.dart';

enum DatabaseItemType {
  rawMaterial,
  producedItem,
}

class DatabaseItem {
  final String name;
  final String region;
  final String location;
  final DatabaseItemType type;

  const DatabaseItem({
    required this.name,
    required this.region,
    required this.location,
    required this.type,
  });
}

class FactoryDatabaseScreen extends StatefulWidget {
  const FactoryDatabaseScreen({super.key});

  @override
  State<FactoryDatabaseScreen> createState() =>
      _FactoryDatabaseScreenState();
}

class _FactoryDatabaseScreenState
    extends State<FactoryDatabaseScreen> {
  static const Color yellow = Color(0xFFFFD600);
  static const Color background = Color(0xFF17191B);
  static const Color panel = Color(0xFF202326);
  static const Color border = Color(0xFF3B4044);

  int selectedRegion = 0;
  String searchQuery = '';

  final List<String> regions = [
    'All',
    'Valley IV',
    'Wuling',
  ];

  // TEMPORARY DATA BASED ON FIGMA MOCKUP
  final List<DatabaseItem> items = const [
    DatabaseItem(
      name: 'Originium Ore',
      region: 'Valley IV',
      location: 'Main PAC',
      type: DatabaseItemType.rawMaterial,
    ),
    DatabaseItem(
      name: 'Xiranite',
      region: 'Wuling',
      location: 'Sub PAC',
      type: DatabaseItemType.rawMaterial,
    ),
    DatabaseItem(
      name: 'Ferrium Component',
      region: 'Wuling',
      location: 'Main PAC',
      type: DatabaseItemType.producedItem,
    ),
    DatabaseItem(
      name: 'Ferrium Ore',
      region: 'Valley IV',
      location: 'Sub PAC',
      type: DatabaseItemType.rawMaterial,
    ),
    DatabaseItem(
      name: 'Cuprium',
      region: 'Wuling',
      location: 'Main PAC',
      type: DatabaseItemType.producedItem,
    ),
    DatabaseItem(
      name: 'Capsule A',
      region: 'Wuling',
      location: 'Sub PAC',
      type: DatabaseItemType.producedItem,
    ),
    DatabaseItem(
      name: 'Carbon',
      region: 'Wuling',
      location: 'Main PAC',
      type: DatabaseItemType.producedItem,
    ),
  ];

  void openItem(DatabaseItem item) {
    if (item.type == DatabaseItemType.rawMaterial) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ItemNameDetailScreen(item: item),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlueprintDetailScreen(item: item),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = items.where((item) {
      final matchesRegion = selectedRegion == 0 ||
          item.region == regions[selectedRegion];

      final matchesSearch = item.name
          .toLowerCase()
          .contains(searchQuery.toLowerCase());

      return matchesRegion && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
          const Positioned.fill(
            child: _DatabaseBackground(),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER
                const Padding(
                  padding: EdgeInsets.fromLTRB(18, 22, 18, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DATABASE',
                        style: TextStyle(
                          color: Color(0xFFB8BEC2),
                          fontSize: 9,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Factory Database',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Registered items by region',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),

                // SEARCH
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: SizedBox(
                    height: 39,
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search blueprint, item or machine',
                        hintStyle: const TextStyle(
                          color: Colors.white54,
                          fontSize: 10,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white70,
                          size: 17,
                        ),
                        filled: true,
                        fillColor: const Color(0xE6202326),
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                          borderSide: const BorderSide(color: border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                          borderSide: const BorderSide(color: border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                          borderSide: const BorderSide(color: yellow),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // REGION FILTER
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: List.generate(regions.length, (index) {
                      final selected = selectedRegion == index;

                      return Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedRegion = index;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: selected ? yellow : panel,
                              border: Border.all(
                                color: selected ? yellow : border,
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Text(
                              regions[index],
                              style: TextStyle(
                                color: selected
                                    ? Colors.black
                                    : Colors.white70,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 10),

                // ITEM LIST
                Expanded(
                  child: filteredItems.isEmpty
                      ? const Center(
                    child: Text(
                      'No items found.',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  )
                      : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      14, 0, 14, 16,
                    ),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];

                      return _DatabaseItemCard(
                        item: item,
                        onTap: () => openItem(item),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const _DatabaseBottomNavigation(),
    );
  }
}

// DATABASE ITEM CARD

class _DatabaseItemCard extends StatelessWidget {
  final DatabaseItem item;
  final VoidCallback onTap;

  const _DatabaseItemCard({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isRawMaterial =
        item.type == DatabaseItemType.rawMaterial;

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 7),
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: const Color(0xE6202326),
          border: Border.all(
            color: const Color(0xFF3B4044),
          ),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Row(
          children: [
            Container(
              width: 37,
              height: 37,
              decoration: BoxDecoration(
                color: const Color(0xFF111315),
                border: Border.all(
                  color: const Color(0xFF50565A),
                ),
              ),
              child: const Icon(
                Icons.inventory_2_outlined,
                color: Color(0xFF777D81),
                size: 20,
              ),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${item.region} · ${item.location}',
                    style: const TextStyle(
                      color: Color(0xFF9BA0A4),
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 7,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF555B5F),
                ),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(
                isRawMaterial ? 'ITEM' : 'BLUEPRINT',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TEMPORARY ITEM NAME DETAIL


class ItemNameDetailScreen extends StatelessWidget {
  final DatabaseItem item;

  const ItemNameDetailScreen({
    super.key,
    required this.item,
  });

  static const Color yellow = Color(0xFFFFD600);
  static const Color panel = Color(0xFF202326);
  static const Color border = Color(0xFF3B4044);

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 10,
          letterSpacing: 1,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget infoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    String? tag,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 7),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: panel,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFF111315),
              border: Border.all(color: border),
            ),
            child: Icon(
              icon,
              color: Colors.white54,
              size: 20,
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          if (tag != null)
            Text(
              tag.toUpperCase(),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 7,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF17191B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111315),
        foregroundColor: Colors.white,
        title: const Text(
          'Item Name Detail',
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Stack(
        children: [
          const Positioned.fill(
            child: _DatabaseBackground(),
          ),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 20),
              children: [
                // ITEM PREVIEW
                Container(
                  height: 185,
                  decoration: BoxDecoration(
                    color: const Color(0xD8202326),
                    border: Border.all(color: border),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: const Center(
                    child: Text(
                      'ITEM PREVIEW',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 10,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // ITEM INFORMATION
                sectionTitle('Item'),

                Text(
                  item.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  '${item.region} · ${item.location}',
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 10,
                  ),
                ),

                const SizedBox(height: 20),

                // SOURCE ITEMS
                sectionTitle('Source Items'),

                infoCard(
                  icon: Icons.inventory_2_outlined,
                  title: 'Source information',
                  subtitle: 'Source details have not been added.',
                  tag: 'ITEM',
                ),

                const SizedBox(height: 12),

                // MACHINES
                sectionTitle('Machines'),

                infoCard(
                  icon: Icons.precision_manufacturing_outlined,
                  title: 'Related Machines',
                  subtitle: 'No machine information available.',
                  tag: 'MACHINE',
                ),

                const SizedBox(height: 12),

                // COMMENTS
                sectionTitle('Comments'),

                TextField(
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Write a comment...',
                    hintStyle: const TextStyle(
                      color: Colors.white54,
                      fontSize: 10,
                    ),
                    filled: true,
                    fillColor: panel,
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: const BorderSide(color: border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: const BorderSide(color: border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: const BorderSide(color: yellow),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'No comments yet.',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// TEMPORARY BLUEPRINT DETAIL

class BlueprintDetailScreen extends StatefulWidget {
  final DatabaseItem item;

  const BlueprintDetailScreen({
    super.key,
    required this.item,
  });

  @override
  State<BlueprintDetailScreen> createState() =>
      _BlueprintDetailScreenState();
}

class _BlueprintDetailScreenState
    extends State<BlueprintDetailScreen> {
  static const Color yellow = Color(0xFFFFD600);
  static const Color panel = Color(0xFF202326);
  static const Color border = Color(0xFF3B4044);

  bool isLiked = false;
  bool isSaved = false;

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 10,
          letterSpacing: 1,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget infoCard({
    required String title,
    required String subtitle,
    required String tag,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 7),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: panel,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFF111315),
              border: Border.all(color: border),
            ),
            child: Icon(
              icon,
              color: Colors.white54,
              size: 20,
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          Text(
            tag,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 7,
            ),
          ),
        ],
      ),
    );
  }

  Widget actionButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    bool active = false,
    bool highlighted = false,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 39,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: highlighted
                ? yellow
                : active
                ? const Color(0xFF454A4E)
                : panel,
            border: Border.all(
              color: highlighted ? yellow : border,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 14,
                color: highlighted ? Colors.black : Colors.white,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  color: highlighted ? Colors.black : Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF17191B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111315),
        foregroundColor: Colors.white,
        title: const Text(
          'Blueprint Details',
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Stack(
        children: [
          const Positioned.fill(
            child: _DatabaseBackground(),
          ),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 20),
              children: [
                // BLUEPRINT PREVIEW
                Container(
                  height: 185,
                  decoration: BoxDecoration(
                    color: const Color(0xD8202326),
                    border: Border.all(color: border),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: const Center(
                    child: Text(
                      'PREVIEW',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 10,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // LIKE, SAVE, SHARE
                Row(
                  children: [
                    actionButton(
                      label: 'Like',
                      icon: isLiked
                          ? Icons.favorite
                          : Icons.favorite_border,
                      active: isLiked,
                      onTap: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      },
                    ),
                    actionButton(
                      label: 'Save',
                      icon: isSaved
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      active: isSaved,
                      onTap: () {
                        setState(() {
                          isSaved = !isSaved;
                        });
                      },
                    ),
                    actionButton(
                      label: 'Share',
                      icon: Icons.share_outlined,
                      highlighted: true,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Share feature will be added later.',
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 17),

                // BLUEPRINT NAME
                sectionTitle('Blueprint'),

                Text(
                  widget.item.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  '${widget.item.region} · ${widget.item.location}',
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 10,
                  ),
                ),

                const SizedBox(height: 20),

                // MATERIALS
                sectionTitle('Materials & Machines'),

                infoCard(
                  title: 'Required Items',
                  subtitle: 'Required materials will be added later.',
                  tag: 'ITEMS',
                  icon: Icons.inventory_2_outlined,
                ),

                // MACHINES
                infoCard(
                  title: 'Machines',
                  subtitle: 'Related machines will be added later.',
                  tag: 'MACHINE',
                  icon: Icons.precision_manufacturing_outlined,
                ),

                const SizedBox(height: 13),

                // COMMENTS
                sectionTitle('Comments'),

                TextField(
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Write a comment...',
                    hintStyle: const TextStyle(
                      color: Colors.white54,
                      fontSize: 10,
                    ),
                    filled: true,
                    fillColor: panel,
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: const BorderSide(color: border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: const BorderSide(color: border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: const BorderSide(color: yellow),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'No comments yet.',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// BOTTOM NAVIGATION

class _DatabaseBottomNavigation extends StatelessWidget {
  const _DatabaseBottomNavigation();

  @override
  Widget build(BuildContext context) {
    const items = [
      (Icons.home_outlined, 'Home'),
      (Icons.search, 'Search'),
      (Icons.inventory_2_outlined, 'Items'),
      (Icons.map_outlined, 'Map'),
      (Icons.person_outline, 'Profile'),
    ];

    return Container(
      height: 58,
      decoration: const BoxDecoration(
        color: Color(0xFF111315),
        border: Border(
          top: BorderSide(color: Color(0xFF383D41)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: List.generate(items.length, (index) {
            final item = items[index];
            final selected = index == 2;

            return Expanded(
              child: InkWell(
                onTap: () {
                  if (selected) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${item.$2} page coming soon.'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item.$1,
                      color: selected
                          ? const Color(0xFFFFD600)
                          : Colors.white70,
                      size: 19,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.$2,
                      style: TextStyle(
                        color: selected
                            ? const Color(0xFFFFD600)
                            : Colors.white70,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

// TEMPORARY BACKGROUND

class _DatabaseBackground extends StatelessWidget {
  const _DatabaseBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF555B5F),
            Color(0xFF292D30),
            Color(0xFF111315),
          ],
          stops: [0, 0.38, 1],
        ),
      ),
    );
  }
}
