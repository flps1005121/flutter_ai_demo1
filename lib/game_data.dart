import 'crop.dart';

class GameData {
  Crop? crop;
  int growthStage;
  DateTime? plantedTime;

  GameData({this.crop, this.growthStage = 0, this.plantedTime});
}
