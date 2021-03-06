
class ChampionDto
{
  String riotName = "";
  String name = "";
  String koreanName = "";
  int rarity = 0;
  late String faceImage = "";
  late String fullImage = "";
  List<String> origins = [""];
  List<String> classes = [""];
  //late List<String> originImage;
  //late List<String> classImage;
  List<String> recommendedItems = [""];
  String skillName = "";
  String skillDescription = "";

  ChampionDto({

    required this.name,
    required this.koreanName,
    required this.riotName,
    required this.rarity,
    required this.origins,
    required this.classes,
    //required this.image,
    //required this.originImage,
    //required this.classImage,
    required this.recommendedItems,
    required this.skillName,
    required this.skillDescription,
  }){
    this.faceImage = "assets/image/champion_face/${riotName}.png";
    this.fullImage = "assets/image/champion_full/${riotName}.jpg";
    //this.image = "assets/champion_face/${riotName}.jpg";
    //this.originImage = ["Set6_Academy.png"];
    //this.classImage = ["Set6_Anti-Mage.png"];
  }

  ChampionDto.blank(){
    this.faceImage = "assets/image/champion_face/TFT6_Ahri.png";
    this.fullImage = "assets/image/champion_full/TFT6_Ahri.png";
  }
}