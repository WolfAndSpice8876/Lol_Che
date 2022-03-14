import 'package:flutter/material.dart';
import 'package:lol/contents/palette.dart' as Palette;
import 'package:lol/database/data_library.dart';
import 'package:lol/dto/champion_dto.dart';
import 'package:lol/dto/trait_dto.dart';
import 'package:lol/normal/page_move.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/pages/champion_full_info_page.dart';
import 'package:lol/widgets/back_button.dart';
import 'package:lol/widgets/page_name.dart';
import 'package:lol/contents/style.dart' as Style;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lol/widgets/trait_full_info_page/elements.dart';


class TraitFullInfoPage extends StatelessWidget {
  TraitDto trait;
  TraitFullInfoPage({Key? key , required this.trait}) : super(key: key);

  
  
  //#. 위젯 함수
  Widget Widget_Content(context){

    List<Widget> champions = getChampionWidgetList(context);
    List<String> fullDes = trait.description.split("\n\n");
    String? des;
    String? synergyDes;

    if(fullDes.length == 2){
      des = fullDes[0];
      synergyDes = fullDes[1];
    }
    else{
      synergyDes = fullDes[0];
    }


    return Padding(
      padding: EdgeInsets.only(left: size(12) , right: size(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size(15)),
          boxShadow: [BoxShadow(
            offset: Offset(0,size(4)),
            color: Colors.black.withOpacity(0.15),
            blurRadius: size(4)
          )],
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: size(5) , left: size(6) ,bottom: size(3)),
              child: Row(
                children: [
                  SizedBox(
                    width: size(42),
                    height: size(42),
                    child: SvgPicture.asset(
                      trait.image,
                      color: Palette.traitGoldColor,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Style.wBox(size(5)),
                  Text(
                    trait.koreanName,
                    style: TextStyle(
                      fontSize: size(14),
                      color: Color(0xffF28E31),
                      fontWeight: FontWeight.w700
                    ),
                  )
                ],
              ),
            ),
            Divider(thickness: 2, color: Color(0xffDFDFDF),),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: size(12) , right: size(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: size(5)),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          children: champions,
                        ),
                      ),
                    ),
                    Style.hBox(size(12)),
                    Widget_Des(des),
                    Style.hBox(size(12)),
                    Widget_SynergyDes(synergyDes),
                    Style.hBox(size(25)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),

    );
  }

  Widget Widget_ChampionFace(ChampionDto championDto , context){
    return GestureDetector(
      onTap: (){
        PageMove.move(context, ChampionFullInfo(championDto: championDto));
      },
      child: Container(
        margin : EdgeInsets.only(right: size(10) , bottom: size(7)),
        width: size(36),
        height: size(36),
        decoration:BoxDecoration(
          color: Palette.Riot.championRarityColor[championDto.rarity],
          borderRadius: BorderRadius.circular(size(7)),
        ),
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: size(32),
            height: size(32),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size(7)),
              child: Image.asset(
                championDto.faceImage,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Widget_Des(String? des){
    if(des != null)
      return Text(
        des,
        style: TextStyle(
            fontSize: size(14),
            fontWeight: FontWeight.w600,
            fontFamily: "roboto",
            color: Colors.black,
            height: 1.7
        ),
      );
    else
      return Style.hBox(0);
  }

  Widget Widget_SynergyDes(String? des){
    if(des != null)
      return Text(
        des,
        style: TextStyle(
          color: Palette.lightColor,
          fontWeight: FontWeight.w600,
          fontSize: size(12),
        ),
      );
    else
      return Style.hBox(0);
  }





  //#. 함수
  List<Widget> getChampionWidgetList(context){
    List<ChampionDto> temp = <ChampionDto>[];
    List<Widget> result = <Widget>[];

    trait.members.forEach((element) {
      temp.add(DataLibrary.champion.findAllByName(element));
    });

    for(int i = 0; i <5; i++){
      temp.forEach((element) {
        if(element.rarity == i)
          result.add(Widget_ChampionFace(element , context));
      });
    }

    return result;
  }

  List<String> getDescription(){
    return trait.description.split("\n\n");
  }

  
  //#. 빌드
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.backColor,
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: size(5)),
                  child: CustomBackButton(),
                ),
                PageName(trait.koreanName),
              ],
            ),
            Style.hBox(size(30)),
            Content(trait: trait,),
          ],
        ),
      ),
    );
  }
}
