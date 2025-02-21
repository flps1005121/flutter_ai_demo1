import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
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
    Crop('Tomatoes', 10, 10, 10, [
      'assets/tomatoes_stage1.png',
      'assets/tomatoes_stage2.png',
      'assets/tomatoes_stage3.png'
    ]),
    Crop('Potatoes', 15, 16, 13, [
      'assets/potatoes_stage1.png',
      'assets/potatoes_stage2.png',
      'assets/potatoes_stage3.png'
    ]),
    Crop('Carrots', 12, 12, 10, [
      'assets/carrots_stage1.png',
      'assets/carrots_stage2.png',
      'assets/carrots_stage3.png'
    ]),
  ];
  int _money = 100;
  final AudioPlayer _audioPlayer = AudioPlayer();
  int? _selectedIndex;
  String? _action; // 新增變數來記錄當前的操作
  bool _showActionButtons = false; // 新增變數來控制按鈕顯示

  @override
  void initState() {
    super.initState();
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
    _audioPlayer.play(AssetSource('background_music.mp3'));
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _plantCrop(int index, Crop crop) {
    if (_money >= crop.cost) {
      setState(() {
        _gameData[index] = GameData(crop: crop);
        _money -= crop.cost;
      });
    }
  }

  void _waterCrop(int index) {
    setState(() {
      if (_gameData[index].plantedTime == null) {
        _gameData[index].plantedTime = DateTime.now(); // 設置種植時間
      }
      _gameData[index].growthStage += 1;
    });
  }

  void _fertilizeCrop(int index) {
    setState(() {
      if (_gameData[index].plantedTime != null) {
        _gameData[index].plantedTime = _gameData[index]
            .plantedTime!
            .subtract(const Duration(seconds: 4)); // 減少4秒的生長時間
      }
      _gameData[index].growthStage += 2; // 增加成長階段
    });
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

  // 更改 _showActionButtons 變數來控制按鈕顯示，並修改為更簡單的拖曳邏輯
  void _setAction(String action) {
    setState(() {
      _action = action; // 記錄當前的操作，澆水或施肥
      _showActionButtons = false; // 隱藏按鈕，因為拖曳圖示取代了按鈕
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farm Game', style: TextStyle(fontFamily: 'Pixel')),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Money: \$$_money',
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pixel',
                      color: Colors.white),
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
                    final timePassed =
                        crop != null && gameData.plantedTime != null
                            ? DateTime.now()
                                .difference(gameData.plantedTime!)
                                .inSeconds
                            : 0;
                    final isGrown =
                        crop != null && timePassed >= crop.growthTime;
                    final growthStage = crop != null
                        ? (timePassed / (crop.growthTime / 3))
                            .clamp(0, 2)
                            .toInt()
                        : 0;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                          _showActionButtons = crop != null; // 有植物時顯示按鈕
                        });
                        if (_action == 'water' && crop != null) {
                          _waterCrop(index);
                          _action = null; // 重置操作
                        } else if (_action == 'fertilize' && crop != null) {
                          _fertilizeCrop(index);
                          _action = null; // 重置操作
                        } else if (crop == null) {
                          _showCropSelectionDialog(index);
                        } else if (isGrown) {
                          _harvestCrop(index);
                        }
                      },
                      child: DragTarget<String>(
                        onAccept: (receivedData) {
                          if (receivedData == 'water' && crop != null) {
                            _waterCrop(index);
                          } else if (receivedData == 'fertilize' &&
                              crop != null) {
                            _fertilizeCrop(index);
                          }
                        },
                        builder: (context, candidateData, rejectedData) {
                          return GridTile(
                            child: Container(
                              margin: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage('assets/pixel_field.png'),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                                border:
                                    Border.all(color: Colors.brown, width: 1),
                              ),
                              child: Center(
                                child: crop == null
                                    ? const Text('Empty',
                                        style: TextStyle(
                                            fontFamily: 'Pixel',
                                            color: Colors.white))
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                              crop.imagePaths[growthStage],
                                              height: 50),
                                          Text(crop.name,
                                              style: const TextStyle(
                                                  fontFamily: 'Pixel',
                                                  color: Colors.white)),
                                          Text(
                                            isGrown
                                                ? 'Ready to harvest'
                                                : 'Growing (${timePassed}s/${crop.growthTime}s)',
                                            style: const TextStyle(
                                                fontFamily: 'Pixel',
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              // 固定在下方的澆水和施肥按鈕
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Draggable<String>(
                      data: 'water', // 這是被拖曳的資料，表示澆水
                      child: IconButton(
                        icon:
                            Image.asset('assets/watering_can.png', height: 50),
                        onPressed: () {
                          _setAction('water');
                        },
                      ),
                      feedback: Material(
                        color: Colors.transparent,
                        child:
                            Image.asset('assets/watering_can.png', height: 50),
                      ),
                    ),
                    Draggable<String>(
                      data: 'fertilize', // 這是被拖曳的資料，表示施肥
                      child: IconButton(
                        icon: Image.asset('assets/basic_fertilizer.png',
                            height: 50),
                        onPressed: () {
                          _setAction('fertilize');
                        },
                      ),
                      feedback: Material(
                        color: Colors.transparent,
                        child: Image.asset('assets/basic_fertilizer.png',
                            height: 50),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
          title: const Text('Select a crop to plant',
              style: TextStyle(fontFamily: 'Pixel')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _crops.map((crop) {
              return ListTile(
                leading: Image.asset(crop.imagePaths[0], height: 30),
                title: Text(crop.name,
                    style: const TextStyle(fontFamily: 'Pixel')),
                subtitle: Text(
                    'Growth time: ${crop.growthTime}s, Cost: \$${crop.cost}, Price: \$${crop.price}',
                    style: const TextStyle(fontFamily: 'Pixel')),
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
