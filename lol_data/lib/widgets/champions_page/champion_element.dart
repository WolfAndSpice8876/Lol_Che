import 'package:flutter/material.dart';
import 'package:lol/dto/item_dto.dart';
import 'package:lol/normal/page_move.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/contents/style.dart' as Style;
import 'package:lol/contents/palette.dart' as Palette;
import 'package:lol/database/data_library.dart';
import 'package:lol/dto/trait_dto.dart';
import 'package:lol/pages/champion_full_info_page.dart';
import 'package:lol/dto/champion_dto.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChampionElement extends StatelessWidget {
  final ChampionDto championDto;
  const ChampionElement({required this.championDto});

  //#. 빌드
  @override
  Widget build(BuildContext context) {

    List<TraitDto> origins = <TraitDto>[];
    List<TraitDto> classes = <TraitDto>[];

    championDto.origins.forEach((element) {
      TraitDto? temp = DataLibrary.trait.allByKoreanName[element];
      temp ??= TraitDto.blank();
      origins.add(temp);
    });

    championDto.classes.forEach((element) {
      TraitDto? temp = DataLibrary.trait.allByKoreanName[element];
      temp ??= TraitDto.blank();
      classes.add(temp);
    });

    return GestureDetector(
      onTap: (){
        PageMove.moveWithAnime(
          context,
          ChampionFullInfo(championDto: championDto),
          PageTransitionType.bottomToTop,
          Duration(milliseconds: 300),
        );
        //PageMove.move(context, ChampionFullInfo(championDto: championDto,));
      },
      child: Container(
        height: size(86),
        margin: EdgeInsets.fromLTRB(size(7), 0, size(7), size(21)),
        decoration: BoxDecoration(
            color: Palette.mainColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [Style.Champions.commonShadow]
        ),
        child: Row(
          children: [
            Face(championDto: championDto),
            Info(championDto: championDto),
            Style.expanded,
            Item(championDto: championDto),
          ],
        ),
      ),
    );
  }
}

class Face extends StatelessWidget {
  final ChampionDto championDto;
  const Face({Key? key , required this.championDto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: size(7), right: size(17)),
      child: Container(
        width: size(73),
        height: size(73),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size(73)),
            color: Colors.black,
            boxShadow: [Style.Champions.commonShadow]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size(73)),
          child: Image.asset(championDto.faceImage),
        ),
      ),
    );
  }
}

class Info extends StatelessWidget {
  final ChampionDto championDto;
  
  
  const Info({Key? key, required this.championDto}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    List<Widget> contents = <Widget>[];
    
    contents.add(Padding(
      padding: EdgeInsets.only(left: 6,bottom: size(10)),
      child: Text(
        championDto.koreanName,
        style: TextStyle(
          fontSize: size(12),
          fontWeight: FontWeight.w600,
        ),
      ),
    ));

    championDto.origins.forEach((element) {
      contents.add(Trait(traitDto : DataLibrary.trait.findAllByName(element)));
    });

    championDto.classes.forEach((element) {
      contents.add(Trait(traitDto : DataLibrary.trait.findAllByName(element)));
    });

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: contents
    );
  }
}

class Trait extends StatelessWidget {
  final TraitDto traitDto;
  const Trait({Key? key , required this.traitDto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: size(3)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: size(5)),
            child: SvgPicture.asset(
              traitDto.image,
              width: size(15),
              height: size(15),
            ),
          ),
          Text(
            traitDto.koreanName,
            style: TextStyle(
                fontSize: size(10),
                fontWeight: FontWeight.w600,
                color: Palette.lightColor
            ),
          ),
        ],
      ),
    );
  }
}

class Item extends StatelessWidget {
  final ChampionDto championDto;
  const Item({Key? key , required this.championDto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: size(15)),
      child: SizedBox(
        width: size(124),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ItemImage(item : DataLibrary.item.findAllByName(championDto.recommendedItems[0])),
            ItemImage(item : DataLibrary.item.findAllByName(championDto.recommendedItems[1])),
            ItemImage(item : DataLibrary.item.findAllByName(championDto.recommendedItems[2])),
            ItemImage(item : DataLibrary.item.findAllByName(championDto.recommendedItems[3])),
          ],
        ),
      ),
    );
  }
}

class ItemImage extends StatelessWidget {
  final ItemDto? item;
  const ItemImage({Key? key , required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(item == null)
      return Container(
          width: size(25),
          height: size(25),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size(25)),
              color: Colors.black12
          )
      );
    else
      return Container(
        width: size(25),
        height: size(25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size(25)),
            color: Colors.black,
            boxShadow: [Style.Champions.commonShadow]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size(25)),
          child: Image.asset(item!.image),
        ),
      );
  }
}

