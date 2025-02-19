import 'package:flutter/material.dart';
import 'dart:async';
import 'game_data.dart';
import 'crop.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<GameData> _gameData = List.generate(9, (_) => GameData());
  final List<Crop> _crops = [
    Crop('Tomatoes', 10, 5, 10, 'assets/tomatoes.png'),
    Crop('Potatoes', 15, 8, 13, 'assets/potatoes.png'),
    Crop('Carrots', 12, 6, 10, 'assets/carrots.png'),
  ];
  int _money = 100;

  void _plantCrop(int index, Crop crop) {
    if (_money >= crop.cost) {
      setState(() {
        _gameData[index] = GameData(crop: crop, plantedTime: DateTime.now());
        _money -= crop.cost;
      });
    }
  }

  void _harvestCrop(int index) {
    setState(() {
      final crop = _gameData[index].crop;
      if (crop != null) {
        _money += crop.price;
      }
      _gameData[index] = GameData();
    });
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farm Game'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Money: \$$_money',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: _gameData.length,
              itemBuilder: (context, index) {
                final gameData = _gameData[index];
                final crop = gameData.crop;
                final timePassed = crop != null && gameData.plantedTime != null
                    ? DateTime.now().difference(gameData.plantedTime!).inSeconds
                    : 0;
                final isGrown = crop != null && timePassed >= crop.growthTime;

                return GestureDetector(
                  onTap: () {
                    if (crop == null) {
                      _showCropSelectionDialog(index);
                    } else if (isGrown) {
                      _harvestCrop(index);
                    }
                  },
                  child: GridTile(
                    child: Container(
                      margin: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.green[200],
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.green, width: 2),
                      ),
                      child: Center(
                        child: crop == null
                            ? const Text('Empty')
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(crop.imagePath, height: 50),
                                  Text(crop.name),
                                  Text(isGrown
                                      ? 'Ready to harvest'
                                      : 'Growing (${timePassed}s/${crop.growthTime}s)'),
                                ],
                              ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showCropSelectionDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select a crop to plant'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _crops.map((crop) {
              return ListTile(
                leading: Image.asset(crop.imagePath, height: 30),
                title: Text(crop.name),
                subtitle: Text(
                    'Growth time: ${crop.growthTime}s, Cost: \$${crop.cost}, Price: \$${crop.price}'),
                onTap: () {
                  _plantCrop(index, crop);
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
