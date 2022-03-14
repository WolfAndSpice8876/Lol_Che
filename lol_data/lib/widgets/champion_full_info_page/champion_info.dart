import 'package:flutter/material.dart';
import 'package:lol/contents/screen_optimized.dart';
import 'package:lol/dto/trait_dto.dart';
import 'package:lol/normal/page_move.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/contents/style.dart' as Style;
import 'package:lol/contents/palette.dart' as Palette;
import 'package:lol/database/data_library.dart';
import 'package:lol/dto/champion_dto.dart';
import 'package:lol/dto/item_dto.dart';
import 'package:lol/pages/item_page.dart';
import 'package:lol/pages/trait_full_info_page.dart';
import 'package:lol/special_contents/data_materialization.dart';

class Champion_Info extends StatefulWidget {
  ChampionDto championDto;
  Champion_Info({Key? key ,required this.championDto}) : super(key: key);

  @override
  State<Champion_Info> createState() => _Champion_InfoState(championData: SpecificChampion(championDto: championDto));
}

class _Champion_InfoState extends State<Champion_Info>{

  SpecificChampion championData;
  late final ScreenOptimized bottomPaddingSize;

  _Champion_InfoState({required this.championData});



  
  //#. 위젯 함수
  Widget Widget_Traits(){

    Widget _Widget_TraitElement(TraitDto traitDto){
      return GestureDetector(
        onTap: (){PageMove.move(context, TraitFullInfoPage(trait: traitDto));},
        child: Container(
          padding: EdgeInsets.fromLTRB(size(10), 0, size(10), 0),
          margin: EdgeInsets.only(right: size(10)),
          height: size(28),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size(10)),
              color: Color(0xffEAEEF1)
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              traitDto.koreanName,
              style: TextStyle(color: Palette.lightColor,fontSize: size(13), fontWeight: FontWeight.w400),
            ),
          ),
        ),
      );
    }

    List<Widget> _Widget_TraitElements(){
      List<Widget> result = <Widget>[];
      championData.origins.forEach((element) {
        result.add(_Widget_TraitElement(element!));
      });

      championData.classes.forEach((element) {
        result.add(_Widget_TraitElement(element!));
      });

      return result;
    }


    return  Padding(
      padding: EdgeInsets.only(left: size(28)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: _Widget_TraitElements()
      ),
    );
  }

  Widget Widget_Description(){
    return Padding(
      padding: EdgeInsets.only(right: size(15),left: size(15)),
      child: SizedBox(
        height: size(203),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              championData.championDto.skillName,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: size(14),
                color: Palette.middleColor
              ),
            ),
            Style.hBox(size(33)),
            SizedBox(
              height: size(140),
              child: SingleChildScrollView(

                child: Text(
                  championData.championDto.skillDescription,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: size(13),
                      color: Palette.lightColor
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget Widget_Item(ItemDto itemDto){
    

    List<ItemDto> items =  <ItemDto>[];

    for(int i = 0; i<itemDto.materials.length; i++){
      items.add(DataLibrary.item.findAllByIndex(itemDto.materials[i]));
    }
    for(int i = itemDto.materials.length; i<2; i++){
      items.add(ItemDto.blank());
    }


    Widget _Widget_Material(ItemDto itemDto){
      return Container(
        width: size(18),
        height: size(18),
        decoration: BoxDecoration(
            color: Palette.mainColor,
            boxShadow: [Style.commonBoxShadow],
            borderRadius: BorderRadius.circular(size(18))
        ),
        child: Visibility(
          visible: itemDto.materials.length == 2 ? false : true,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(size(18)),
            child: Image.asset(itemDto.image),
          ),
        ),
      );
    }

    return SizedBox(
      width: size(130),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
              if(itemDto.materials.length == 2)
                PageMove.move(context, ItemPage(item0: items[0],item1: items[1], isFromAllItem: false,));
              else
                PageMove.move(context, ItemPage(item0: itemDto, item1: null, isFromAllItem: false,));
            },
            child: Container(
              width: size(54),
              height: size(54),
              decoration: BoxDecoration(
                  color: Palette.mainColor,
                  boxShadow: [Style.commonBoxShadow],
                  borderRadius: BorderRadius.circular(size(5))
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size(5)),
                child: Image.asset(itemDto.image),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size(6),left: size(8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: size(2) , left: size(6)),
                  child: Row(
                    children: [
                      _Widget_Material(items[0]),
                      Style.wBox(size(6)),
                      _Widget_Material(items[1]),
                    ],
                  ),
                ),
                SizedBox(
                  width: size(55),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      itemDto.koreanName,
                      style: TextStyle(fontSize: size(11), fontWeight: FontWeight.w600, color: Palette.lightColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget Widget_ItemView(){

    List<ItemDto> items =  <ItemDto>[];

    for(int i = 0; i<widget.championDto.recommendedItems.length; i++){
      items.add(DataLibrary.item.findAllByName(widget.championDto.recommendedItems[i]));
    }
    for(int i = widget.championDto.recommendedItems.length; i<4; i++){
      items.add(ItemDto.blank());
    }



    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: size(14) , bottom: size(20)),
          child: Text(
            "추천 아이템",
            style: TextStyle(
              color: Palette.middleColor,
              fontSize: size(14),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: size(20)),
          child: Column(
            children: [
              Row(
                children: [
                  Widget_Item(items[0]),
                  Style.wBox(size(55)),
                  Widget_Item(items[1]),
                ],
              ),
              Style.hBox(size(46)),
              Row(
                children: [
                  Widget_Item(items[2]),
                  Style.wBox(size(55)),
                  Widget_Item(items[3]),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget BottomPadding(){
    final ScreenOptimized bottomPaddingSize = ScreenOptimized.std(
        maxHeight: 60,
        minHeight: 0,
        screen: MediaQuery.of(context)
    );
    return Style.hBox(size(bottomPaddingSize.value));
  }


  double getHeight(double value_){
    double maxHeight = MediaQuery.of(context).size.height;
    double stdHeight = 800;
    return (value_ / stdHeight ) * maxHeight;
  }

  
  //#. 빌드
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(size(25)),
            topLeft: Radius.circular(size(25))
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Style.hBox(size(31)),
            Padding(
              padding: EdgeInsets.only(left: size(34), bottom:size(24)),
              child: Text(
                championData.championDto.koreanName,
                style: TextStyle(fontSize: size(18), fontWeight: FontWeight.w700),
              ),
            ),
            Widget_Traits(),
            Style.hBox(size(63)),
            Widget_Description(),
            LimitedBox(maxHeight: size(79),),
            Widget_ItemView(),
            BottomPadding(),
            //Style.hBox(size(51))
          ],
        ),
      ),
    );
  }
}
