
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const yellow = Color(0xFFFFD600);
  static const panel = Color(0xFF202326);
  static const border = Color(0xFF3B4044);

  final keywordController = TextEditingController();

  String selectedTab = 'Factory';
  String selectedArea = 'All areas';
  String selectedCategory = 'All categories';
  String selectedSort = 'Newest';

  @override
  void dispose() {
    keywordController.dispose();
    super.dispose();
  }

  void resetFilters() {
    setState(() {
      keywordController.clear();
      selectedTab = 'Factory';
      selectedArea = 'All areas';
      selectedCategory = 'All categories';
      selectedSort = 'Newest';
    });
  }

  void applyFilters() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Filters applied: $selectedTab · $selectedArea',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF17191B),
      body: Stack(
        children: [
          const Positioned.fill(child: _SearchBackground()),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 22, 18, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ENDFIELD / FACTORY BLUEPRINTS',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 9,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Find blueprints, items and machines',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 24),

                  _sectionLabel('KEYWORD'),
                  const SizedBox(height: 7),
                  TextField(
                    controller: keywordController,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                    decoration: _inputDecoration('Enter keywords...'),
                  ),

                  const SizedBox(height: 20),
                  _sectionLabel('TYPE'),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      _tab('Factory'),
                      const SizedBox(width: 7),
                      _tab('Materials'),
                      const SizedBox(width: 7),
                      _tab('Machines'),
                    ],
                  ),

                  const SizedBox(height: 20),
                  _sectionLabel('AREA'),
                  const SizedBox(height: 7),
                  _dropdown(
                    value: selectedArea,
                    options: const [
                      'All areas',
                      'Valley IV',
                      'Wuling',
                    ],
                    onChanged: (value) {
                      setState(() => selectedArea = value!);
                    },
                  ),

                  const SizedBox(height: 17),
                  _sectionLabel('CATEGORY'),
                  const SizedBox(height: 7),
                  _dropdown(
                    value: selectedCategory,
                    options: const [
                      'All categories',
                      'Blueprint',
                      'Material',
                      'Machine',
                    ],
                    onChanged: (value) {
                      setState(() => selectedCategory = value!);
                    },
                  ),

                  const SizedBox(height: 17),
                  _sectionLabel('SORT BY'),
                  const SizedBox(height: 7),
                  _dropdown(
                    value: selectedSort,
                    options: const [
                      'Newest',
                      'Oldest',
                      'Name A-Z',
                      'Name Z-A',
                    ],
                    onChanged: (value) {
                      setState(() => selectedSort = value!);
                    },
                  ),

                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: resetFilters,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: border),
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: const Text('Reset'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: applyFilters,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: yellow,
                            foregroundColor: Colors.black,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: const Text(
                            'Apply filters',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _bottomNavigation(),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 10,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _tab(String text) {
    final selected = selectedTab == text;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => selectedTab = text),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            color: selected ? yellow : panel,
            border: Border.all(
              color: selected ? yellow : border,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: selected ? Colors.black : Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Colors.white54,
        fontSize: 12,
      ),
      filled: true,
      fillColor: panel,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 15,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: yellow),
      ),
    );
  }

  Widget _dropdown({
    required String value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: panel,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: panel,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white70,
          ),
          items: options.map((option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _bottomNavigation() {
    const labels = ['Home', 'Search', 'Items', 'Map', 'Profile'];
    const icons = [
      Icons.home_outlined,
      Icons.search,
      Icons.inventory_2_outlined,
      Icons.map_outlined,
      Icons.person_outline,
    ];

    return Container(
      height: 58,
      decoration: const BoxDecoration(
        color: Color(0xFF111315),
        border: Border(
          top: BorderSide(color: border),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: List.generate(5, (index) {
            final selected = index == 1;

            return Expanded(
              child: InkWell(
                onTap: () {
                  if (index == 0) {
                    Navigator.pop(context);
                  } else if (!selected) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${labels[index]} page coming soon.'),
                      ),
                    );
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icons[index],
                      size: 19,
                      color: selected ? yellow : Colors.white70,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      labels[index],
                      style: TextStyle(
                        fontSize: 9,
                        color: selected ? yellow : Colors.white70,
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

class _SearchBackground extends StatelessWidget {
  const _SearchBackground();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF555B5F),
            Color(0xFF292D30),
            Color(0xFF111315),
          ],
          stops: [0, 0.4, 1],
        ),
      ),
    );
  }
}
