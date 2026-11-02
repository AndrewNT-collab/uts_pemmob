import 'package:flutter/material.dart';

class MachinesScreen extends StatefulWidget {
  const MachinesScreen({super.key});

  @override
  State<MachinesScreen> createState() => _MachinesScreenState();
}

class _MachinesScreenState extends State<MachinesScreen> {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, String>> machines = [
    {
      'name': 'Smelter',
      'description': 'Fabricates ingots',
    },
    {
      'name': 'Fitting Unit',
      'description': 'Assembles components',
    },
    {
      'name': 'Refining Unit',
      'description': 'Processes raw ore',
    },
    {
      'name': 'Belt',
      'description': 'Transports items',
    },
  ];

  String searchQuery = '';

  List<Map<String, String>> get filteredMachines {
    return machines.where((machine) {
      final name = machine['name']!.toLowerCase();
      final description = machine['description']!.toLowerCase();

      return name.contains(searchQuery) ||
          description.contains(searchQuery);
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF17191B),
      body: Stack(
        children: [
          const _MachineBackground(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 20, 18, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'CATALOG',
                        style: TextStyle(
                          color: Color(0xFFFFC928),
                          fontSize: 9,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        'Machines',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Factory equipment catalog',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value.toLowerCase().trim();
                          });
                        },
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search machines...',
                          hintStyle: const TextStyle(
                            color: Colors.white54,
                            fontSize: 11,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.white60,
                            size: 18,
                          ),
                          filled: true,
                          fillColor: const Color(0xFF171B1E),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                            borderSide: const BorderSide(
                              color: Colors.white24,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                            borderSide: const BorderSide(
                              color: Color(0xFFFFC928),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: filteredMachines.isEmpty
                      ? const Center(
                    child: Text(
                      'No machines found',
                      style: TextStyle(color: Colors.white70),
                    ),
                  )
                      : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      12,
                      0,
                      12,
                      20,
                    ),
                    itemCount: filteredMachines.length,
                    separatorBuilder: (_, __) =>
                    const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final machine = filteredMachines[index];

                      return _MachineCard(
                        name: machine['name']!,
                        description: machine['description']!,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${machine['name']} selected',
                              ),
                              backgroundColor: const Color(0xFF292D30),
                            ),
                          );
                        },
                      );
                    },
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

class _MachineCard extends StatelessWidget {
  final String name;
  final String description;
  final VoidCallback onTap;

  const _MachineCard({
    required this.name,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF111518).withValues(alpha: 0.95),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 13,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white24),
          ),
          child: Row(
            children: [
              Container(
                width: 3,
                height: 34,
                color: const Color(0xFFFFC928),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white38),
                ),
                child: const Text(
                  'MACHINE',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 8,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MachineBackground extends StatelessWidget {
  const _MachineBackground();

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