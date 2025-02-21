import 'crop.dart';

class GameData {
  final Crop? crop;
  DateTime? plantedTime;
  int growthStage;

  GameData({this.crop, this.plantedTime, this.growthStage = 0});
}
