
import 'package:flutter/material.dart';

import '../profile/profile_screen.dart';
import '../search/search_screen.dart';
import '../items/factory_database_screen.dart';
import '../areas/areas_screen.dart';
import '../machines/machines_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color yellow = Color(0xFFFFD600);
  static const Color background = Color(0xFF17191B);
  static const Color panel = Color(0xFF202326);
  static const Color border = Color(0xFF3B4044);
  static const Color muted = Color(0xFF9BA0A4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
          const Positioned.fill(
            child: _PlaceholderBackground(),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 22, 18, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ENDFIELD / FACTORY BLUEPRINTS',
                    style: TextStyle(
                      color: Color(0xFFCFD2D4),
                      fontSize: 9,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Welcome, Endministrator',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 17),

                  // Guest Account
                  _GuestAccountCard(
                    onTap: () {
                      _showMessage(
                        context,
                        'Login feature coming soon.',
                      );
                    },
                  ),

                  const SizedBox(height: 13),

                  // Welcome Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: yellow,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'VALLEY IV / WULING',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.7,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Welcome to Endfield',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Explore regions, browse blueprints and\n'
                              'plan your factory.',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 11,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 13),

                  // Search Field
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SearchScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 43,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: panel,
                        border: Border.all(color: border),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: muted,
                            size: 19,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Search blueprint, item, machine...',
                            style: TextStyle(
                              color: muted,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Machines Catalogue Shortcut
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MachinesScreen(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xE6202326),
                        border: Border.all(color: border),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.precision_manufacturing_outlined,
                            color: yellow,
                            size: 23,
                          ),
                          SizedBox(width: 11),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Machines Catalogue',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  'Browse factory machines',
                                  style: TextStyle(
                                    color: muted,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.white70,
                            size: 21,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 21),

                  const Text(
                    'POPULAR BLUEPRINTS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),

                  const SizedBox(height: 10),

                  _BlueprintTile(
                    title: 'Smelter Line A',
                    subtitle: 'Valley IV · Originium',
                    onTap: () {
                      _showMessage(
                        context,
                        'Smelter Line A detail coming soon.',
                      );
                    },
                  ),

                  const SizedBox(height: 8),

                  _BlueprintTile(
                    title: 'Ferrium Compound',
                    subtitle: 'Wuling · Refining',
                    onTap: () {
                      _showMessage(
                        context,
                        'Ferrium Compound detail coming soon.',
                      );
                    },
                  ),

                  const SizedBox(height: 8),

                  _BlueprintTile(
                    title: 'Amethyst Component',
                    subtitle: 'Valley IV · Filtering',
                    onTap: () {
                      _showMessage(
                        context,
                        'Amethyst Component detail coming soon.',
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const _HomeBottomNavigation(),
    );
  }

  static void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

// GUEST ACCOUNT CARD

class _GuestAccountCard extends StatelessWidget {
  const _GuestAccountCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: const Color(0xE6202326),
          border: Border.all(color: const Color(0xFF41464A)),
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Row(
          children: [
            _AvatarPlaceholder(),
            SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Guest account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Sign in to save blueprints',
                    style: TextStyle(
                      color: Color(0xFFB7BBBE),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Color(0xFFB7BBBE),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

// AVATAR PLACEHOLDER

class _AvatarPlaceholder extends StatelessWidget {
  const _AvatarPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 37,
      height: 37,
      decoration: BoxDecoration(
        color: const Color(0xFF111315),
        border: Border.all(color: const Color(0xFF50565A)),
        borderRadius: BorderRadius.circular(3),
      ),
      child: const Icon(
        Icons.person_outline,
        color: Color(0xFF777D81),
        size: 22,
      ),
    );
  }
}

// BLUEPRINT CARD

class _BlueprintTile extends StatelessWidget {
  const _BlueprintTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: const Color(0xE6202326),
          border: Border.all(color: const Color(0xFF3B4044)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF111315),
                border: Border.all(color: const Color(0xFF4A5054)),
                borderRadius: BorderRadius.circular(2),
              ),
              child: const Icon(
                Icons.factory_outlined,
                color: Color(0xFF858B8F),
                size: 19,
              ),
            ),
            const SizedBox(width: 10),
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
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
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
                border: Border.all(color: const Color(0xFF555B5F)),
                borderRadius: BorderRadius.circular(2),
              ),
              child: const Text(
                'BLUEPRINT',
                style: TextStyle(
                  color: Color(0xFFBFC3C6),
                  fontSize: 7,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// BOTTOM NAVIGATION

class _HomeBottomNavigation extends StatelessWidget {
  const _HomeBottomNavigation();

  static const Color yellow = Color(0xFFFFD600);

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
      decoration: const BoxDecoration(
        color: Color(0xFF111315),
        border: Border(
          top: BorderSide(color: Color(0xFF383D41)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 58,
          child: Row(
            children: List.generate(items.length, (index) {
              final selected = index == 0;
              final item = items[index];

              return Expanded(
                child: InkWell(
                  onTap: () {
                    if (index == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SearchScreen(),
                        ),
                      );
                    } else if (index == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const FactoryDatabaseScreen(),
                        ),
                      );
                    } else if (index == 3) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AreasScreen(),
                        ),
                      );
                    } else if (index == 4) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProfileScreen(),
                        ),
                      );
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item.$1,
                        color: selected ? yellow : Colors.white70,
                        size: 20,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.$2,
                        style: TextStyle(
                          color: selected ? yellow : Colors.white70,
                          fontSize: 9,
                          fontWeight: selected
                              ? FontWeight.w700
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// TEMPORARY BACKGROUND

class _PlaceholderBackground extends StatelessWidget {
  const _PlaceholderBackground();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BackgroundPainter(),
      child: Container(
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
      ),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.035)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(size.width * 0.05, size.height * 0.42)
      ..lineTo(size.width * 0.42, size.height * 0.20)
      ..lineTo(size.width * 0.72, size.height * 0.48)
      ..lineTo(size.width * 0.98, size.height * 0.28)
      ..moveTo(size.width * 0.02, size.height * 0.68)
      ..lineTo(size.width * 0.35, size.height * 0.50)
      ..lineTo(size.width * 0.65, size.height * 0.75)
      ..lineTo(size.width * 0.95, size.height * 0.58);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
