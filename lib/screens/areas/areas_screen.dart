
import 'package:flutter/material.dart';

class AreasScreen extends StatelessWidget {
  const AreasScreen({super.key});

  static const Color yellow = Color(0xFFFFC928);
  static const Color background = Color(0xFF17191B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Areas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          const _AreasBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Region',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Choose a region to explore its areas.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 25),
                  _RegionCard(
                    name: 'Valley IV',
                    description: 'Explore areas in Valley IV',
                    onTap: () => _openRegion(context, 'Valley IV'),
                  ),
                  const SizedBox(height: 18),
                  _RegionCard(
                    name: 'Wuling',
                    description: 'Explore areas in Wuling',
                    onTap: () => _openRegion(context, 'Wuling'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openRegion(BuildContext context, String region) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PACSelectionScreen(region: region),
      ),
    );
  }
}

class _RegionCard extends StatelessWidget {
  final String name;
  final String description;
  final VoidCallback onTap;

  const _RegionCard({
    required this.name,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF292D30),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.white12,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC928).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.landscape,
                  color: Color(0xFFFFC928),
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Color(0xFFFFC928),
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PACSelectionScreen extends StatelessWidget {
  final String region;

  const PACSelectionScreen({
    super.key,
    required this.region,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF17191B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF17191B),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(region),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              region.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              height: 220,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF292D30),
                border: Border.all(
                  color: const Color(0xFFFFC928),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                'MAP',
                style: TextStyle(
                  color: Color(0xFFFFC928),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AreasBackground extends StatelessWidget {
  const _AreasBackground();

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
          stops: [0, 0.38, 1],
        ),
      ),
      child: SizedBox.expand(),
    );
  }
}
