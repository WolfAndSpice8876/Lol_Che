
class ItemDto
{
  String koreanName = "";
  int index = 0;
  late String image;
  List<int> materials = []; //없는 경우 0 으로
  bool isComplete = false;
  String description = "";

  ItemDto({
    required this.koreanName,
    required this.index,
    required this.materials,
    required this.isComplete,
    required this.description,
  }){
    image = "assets/image/item/${index}.png";
  }

  ItemDto.blank(){
    image = "assets/image/item/1.png";
    materials = [1,1];
  }
}