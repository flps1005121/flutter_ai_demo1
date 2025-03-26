import 'package:flutter/material.dart';
import '../widgets/pet_grid.dart';
import '../models/pet.dart';
import '../widgets/tail_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isCatSelected = true;
  String _dogSizeFilter = 'all';
  String _catCoatFilter = 'all';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _isCatSelected = _tabController.index == 0;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildFilterButtons(String filterType, String currentFilter,
      List<String> filters, List<String> labels) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(filters.length, (index) {
          final filter = filters[index];
          final label = labels[index];
          final isSelected = filter == currentFilter;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Pixel',
                  color: isSelected ? Colors.white : const Color(0xFFFFA726),
                ),
              ),
              selected: isSelected,
              selectedColor: const Color(0xFFFFA726),
              backgroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFFFFA726)),
              elevation: 2,
              onSelected: (selected) {
                setState(() {
                  if (filterType == 'dog') {
                    _dogSizeFilter = filter;
                  } else {
                    _catCoatFilter = filter;
                  }
                });
              },
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pets = Pet.getSamplePets();
    final catPets = pets.where((pet) => pet.category == 'cat').toList();
    final filteredCatPets = _catCoatFilter == 'all'
        ? catPets
        : catPets.where((pet) => pet.coatLength == _catCoatFilter).toList();
    final dogPets = pets.where((pet) => pet.category == 'dog').toList();
    final filteredDogPets = _dogSizeFilter == 'all'
        ? dogPets
        : dogPets.where((pet) => pet.size == _dogSizeFilter).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '寵物圖鑑',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Pixel',
          ),
        ),
        backgroundColor: const Color(0xFFFFA726), // 明確指定 AppBar 背景為橘色
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(90.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TabBar(
                      controller: _tabController,
                      labelColor: Color.fromARGB(255, 0, 0, 0),
                      unselectedLabelColor: Colors.white,
                      indicatorColor: const Color(0xFFFFA726),
                      tabs: const [
                        Tab(
                            child: Text('貓咪',
                                style: TextStyle(fontFamily: 'Pixel'))),
                        Tab(
                            child: Text('狗狗',
                                style: TextStyle(fontFamily: 'Pixel'))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: TailAnimation(isCat: _isCatSelected),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                child: _tabController.index == 0
                    ? _buildFilterButtons(
                        'cat',
                        _catCoatFilter,
                        ['all', 'long', 'short'],
                        ['全部', '長毛', '短毛'],
                      )
                    : _buildFilterButtons(
                        'dog',
                        _dogSizeFilter,
                        ['all', 'large', 'medium', 'small'],
                        ['全部', '大型犬', '中型犬', '小型犬'],
                      ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFF3E0), // 黃橘色系背景
              Color(0xFFFFE0B2),
            ],
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: [
            PetGrid(pets: filteredCatPets),
            PetGrid(pets: filteredDogPets),
          ],
        ),
      ),
    );
  }
}
