import 'package:flutter/material.dart';
import 'package:lol/dto/dto_class.dart';
import 'package:lol/riot/riot_api.dart';
import 'package:lol/normal/size.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lol/normal/date_calculation.dart';
import 'package:lol/contents/style.dart' as Style;
import 'package:lol/contents/palette.dart' as Palette;

const List<Color> placementColor = <Color>[
  Color(0xffFABA48),
  Color(0xff13B188),
  Color(0xff7F7F7F),
];

final List<Color> rarityColor = [
  Color(0xff7F7F7F),
  Color(0xff13B188),
  Color(0xff237AC3),
  Color(0xffBD44D1),
  Color(0xffFABA48)
];



//#. 위젯 함수

Widget Widget_Placement(int placement_ , int queueId_){

  Color _getColor(){
    Color color_ = Colors.black87;
    if(RiotWords.getGameTypeName(queueId_) == "더블 업")
      placement_ = placement_ * 2 - 1;

    switch(placement_){
      case 1 :
        color_ = placementColor[0];
        break;

      case 2 : case 3 : case 4 :
      color_ = placementColor[1];
      break;

      case 5 : case 6 : case 7 : case 8 :
      color_ = placementColor[2];
      break;
    }
    return color_;
  }

  if(RiotWords.getGameTypeName(queueId_) == "더블 업")
    placement_ = ((placement_ + 1) /2).floor();

  return Padding(
    padding: const EdgeInsets.only(right: 15),
    child: Text(
      "#${placement_}등",
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: size(11),
        color: _getColor()
      ),
    ),
  );
}

Widget Widget_Level(int level_){
  return Padding(
    padding: const EdgeInsets.only(right: 10),
    child: Text(
      "#${level_}레벨",
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: size(11),
        color: Palette.lightColor,
      ),
    ),
  );
}

Widget Widget_ChampionInfo(Tft_UnitInfoDto unitDto_){
  return Padding(
    padding: EdgeInsets.only(bottom: size(9)),
    child: SizedBox(
      width: size(46),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _Widget_Star(unitDto_.tier,rarityColor[unitDto_.rarity]),
          _Widget_ChampionImage(unitDto_.character_id ,unitDto_.rarity),
          _Widget_Items(unitDto_.items),
        ],
      ),
    ),
  );
}

Widget _Widget_Star(int nums_ , Color color_){

  Widget _star(){
    return SvgPicture.asset(
      "assets/user_page/star.svg",
      width: size(11),
      height: size(11),
      color: color_,
    );
  }

  switch(nums_)
  {
    case 0:
      return SizedBox(height: size(11),);
    case 1:
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _star(),
        ],
      );
    case 2:
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _star(),
          _star(),
        ],
      );
    case 3:
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _star(),
          _star(),
          _star(),
        ],
      );
    default:
      return SizedBox(height: size(11),);
  }
}

Widget _Widget_ChampionImage(String character_id_, int rarity_){

  return Padding(
    padding: EdgeInsets.only(top: size(2),bottom: size(4)),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: rarityColor[rarity_], width: 3),
        color: rarityColor[rarity_]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Image.asset(
          "assets/image/champion_face/$character_id_.png",
          width: size(34),
          height: size(34),
        ),
      ),
    ),
  );
}

Widget _Widget_Items(List<int> items){

  Widget _image(int item_){
    return Padding(
      padding: EdgeInsets.only(left: size(1) , right: size(1)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(size(2))),
        child: Image.asset(
          "assets/image/item/${item_}.png",
          width: size(10),
          height: size(10),
        ),
      ),
    );
  }

  List<Widget> images = <Widget>[];

  items.forEach((element) {
    images.add(_image(element));
  });

  return SizedBox(
    width: size(36),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: images,
    ),
  );
}

Widget Widget_Champions(Tft_MatchDto match_){
  List<Widget> widgets = <Widget>[];
  match_.myParticipantDto.units.forEach((element) {
    if(widgets.length < 12)
      widgets.add(Widget_ChampionInfo(element));
  });

  return Padding(
    padding: EdgeInsets.only(left : size(18)),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        alignment: WrapAlignment.start,
        children: widgets,
      ),
    ),
  );
}

Widget Widget_Synergy(List<Tft_TraitInfoDto> traits_){

  traits_.sort((a, b) => b.style.compareTo(a.style));

  Widget _makeImage(Tft_TraitInfoDto traitDto_){
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Stack(
        alignment: Alignment.center,
        children:[
          Image.asset(
            "assets/user_page/traits_background/${RiotWords.getSynergyTier(traitDto_.style)}.png",
            width: size(18),
            height: size(18),
          ),
          SvgPicture.asset(
            "assets/image/synergy/${traitDto_.name}.svg",
            width: size(12),
            height: size(12),
          ),
          //
          // Image.asset(
          //
          //   width: size(18),
          //   height: size(18),
          // ),
        ],
      ),
    );
  }

  List<Widget> _makeList(){
    List<Widget> _widgets = <Widget>[];
    traits_.forEach((element) {
      if(element.style > 0)
        _widgets.add(_makeImage(element));
    });

    return _widgets;
  }

  List<Widget> widgets = <Widget>[];
  widgets = _makeList();

  return Row(
    children: widgets
  );
}

Widget Widget_QueueName(int queueId_){
  return Text(
    RiotWords.getGameTypeName(queueId_),
    style: TextStyle(
      color: Color(0xff575757),
      fontWeight: FontWeight.w600,
      fontSize: size(11),
    ),
  );
}

Widget Widget_StartTime(int timeStamp_){
  return Text(
    DataCalculation.getTimeDifferenceNow(timeStamp_),
    style: TextStyle(
      color: Color(0xff8E8E8E),
      fontWeight: FontWeight.w600,
      fontSize: size(11),
    ),
  );
}


class Placement extends StatelessWidget {
  final int placement;
  final int queueId;
  const Placement({Key? key , required this.placement , required this.queueId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int printPlacement = placement;

    Color _getColor(){
      Color color_ = Colors.black87;
      if(RiotWords.getGameTypeName(queueId) == "더블 업")
        printPlacement = printPlacement * 2 - 1;

      switch(printPlacement){
        case 1 :
          color_ = placementColor[0];
          break;

        case 2 : case 3 : case 4 :
          color_ = placementColor[1];
          break;

        case 5 : case 6 : case 7 : case 8 :
          color_ = placementColor[2];
          break;

        default:
          print(printPlacement);
          color_ = placementColor[2];
      }
      return color_;
    }

    if(RiotWords.getGameTypeName(queueId) == "더블 업")
      printPlacement = ((printPlacement + 1) /2).floor();

    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Text(
        "#${printPlacement}등",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: size(11),
          color: _getColor()
        ),
      ),
    );
  }
}

class Level extends StatelessWidget {
  final int level;
  const Level({Key? key , required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Text(
        "#${level}레벨",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: size(11),
          color: Palette.lightColor,
        ),
      ),
    );
  }
}

class ChampionInfo extends StatelessWidget {
  final Tft_UnitInfoDto unitInfoDto;
  const ChampionInfo({Key? key, required this.unitInfoDto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: size(9)),
      child: SizedBox(
        width: size(46),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Star(nums : unitInfoDto.tier ,color : rarityColor[unitInfoDto.rarity]),
            ChampionImage(characterId : unitInfoDto.character_id , rarity : unitInfoDto.rarity),
            Items(items: unitInfoDto.items,),
          ],
        ),
      ),
    );
  }
}

class Star extends StatelessWidget {
  final int nums;
  final Color color;

  const Star({Key? key ,required this.nums , required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Widget star = SvgPicture.asset(
      "assets/user_page/star.svg",
      width: size(11),
      height: size(11),
      color: color,
    );

    switch(nums)
    {
      case 0:
        return SizedBox(height: size(11),);
      case 1:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            star,
          ],
        );
      case 2:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            star,
            star,
          ],
        );
      case 3:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            star,
            star,
            star,
          ],
        );
      default:
        return SizedBox(height: size(11),);
    }
  }
}

class ChampionImage extends StatelessWidget {
  final String characterId;
  final int rarity;
  const ChampionImage({Key? key , required this.characterId , required this.rarity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: size(2),bottom: size(4)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: rarityColor[rarity], width: 3),
          color: rarityColor[rarity]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Image.asset(
          "assets/image/champion_face/$characterId.png",
          width: size(34),
          height: size(34),
        ),
      ),
    );
  }
}

class Items extends StatelessWidget {
  final List<int> items;
  const Items({Key? key , required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Widget> images = <Widget>[];

    items.forEach((element) {
      images.add(ItemImage(item : element));
    });

    return SizedBox(
      width: size(36),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: images,
      ),
    );
  }
}

class ItemImage extends StatelessWidget {
  final int item;
  const ItemImage({Key? key , required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: size(1) , right: size(1)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(size(2))),
        child: Image.asset(
          "assets/image/item/${item}.png",
          width: size(10),
          height: size(10),
        ),
      ),
    );
  }
}

class Champions extends StatelessWidget {
  final Tft_MatchDto match;
  const Champions({Key? key ,required this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Widget> widgets = <Widget>[];

    match.myParticipantDto.units.forEach((element) {
      if(widgets.length < 13)
        widgets.add(ChampionInfo(unitInfoDto: element));
    });

    return Padding(
      padding: EdgeInsets.only(left : size(18)),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          alignment: WrapAlignment.start,
          children: widgets,
        ),
      ),
    );
  }
}

class Synergy extends StatelessWidget {
  final List<Tft_TraitInfoDto> traits;
  const Synergy({Key? key , required this.traits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    traits.sort((a, b) => b.style.compareTo(a.style));

    List<Widget> widgets = <Widget>[];

    traits.forEach((element) {
      if(element.style > 0)
        widgets.add(SynergyImage(traitInfoDto : element));
    });

    return Row(
        children: widgets
    );
  }
}

class SynergyImage extends StatelessWidget {
  final Tft_TraitInfoDto traitInfoDto;
  const SynergyImage({Key? key , required this.traitInfoDto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Stack(
        alignment: Alignment.center,
        children:[
          Image.asset(
            "assets/user_page/traits_background/${RiotWords.getSynergyTier(traitInfoDto.style)}.png",
            width: size(18),
            height: size(18),
          ),
          SvgPicture.asset(
            "assets/image/synergy/${traitInfoDto.name}.svg",
            width: size(12),
            height: size(12),
          ),
        ]
      ),
    );
  }
}

class QueueName extends StatelessWidget {
  final int queueId;
  const QueueName({Key? key , required this.queueId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      RiotWords.getGameTypeName(queueId),
      style: TextStyle(
        color: const Color(0xff575757),
        fontWeight: FontWeight.w600,
        fontSize: size(11),
      ),
    );
  }
}

class StartTime extends StatelessWidget {
  final int timeStamp;
  const StartTime({Key? key , required this.timeStamp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      DataCalculation.getTimeDifferenceNow(timeStamp),
      style: TextStyle(
        color: const Color(0xff8E8E8E),
        fontWeight: FontWeight.w600,
        fontSize: size(11),
      ),
    );
  }
}

class BasicInfo extends StatelessWidget {
  final Tft_MatchDto match;
  final Function getOpen;
  final Function setOpen;
  const BasicInfo({Key? key , required this.match , required this.getOpen , required this.setOpen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isOpened = getOpen.call();

    return SizedBox(
      height: size(80),
      child: Padding(
        padding: EdgeInsets.fromLTRB(size(20), size(15), size(20), size(0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Widget_Synergy(match.myParticipantDto.traits), // 시너지 이미지
            Synergy(traits: match.myParticipantDto.traits),
            Expanded(child: SizedBox()),
            Row(
              children: [
                // Widget_QueueName(match.matchinfoDto.queueId),
                // Style.wBox(size(22)),
                // Widget_StartTime(match.matchinfoDto.gameDataTime), //시간
                // Expanded(child: SizedBox(),),
                // Widget_Placement(match.myParticipantDto.placement,match.matchinfoDto.queueId),
                // Widget_Level(match.myParticipantDto.level),
                // GestureDetector(
                //     onTap: (){
                //       isOpened = set_;
                //       setState(() {});
                //     },
                //     child: Stack(
                //       alignment: Alignment.center,
                //       children: [
                //         Image.asset(
                //           isOpened == false ? "assets/user_page/down.png" : "assets/user_page/down.png",
                //           width: size(12),
                //           height: size(12),
                //         ),
                //         Container(
                //           decoration: Style.blankDecoration,
                //           width: size(30),
                //           height: size(20),
                //         )
                //       ],
                //     )
                // ),

                QueueName(queueId: match.matchinfoDto.queueId), //큐타입
                Style.wBox(size(22)),
                StartTime(timeStamp: match.matchinfoDto.gameDataTime,),
                Expanded(child: SizedBox(),),
                Placement(placement: match.myParticipantDto.placement, queueId: match.matchinfoDto.queueId),
                Level(level: match.myParticipantDto.level),
                GestureDetector(
                    onTap: (){
                      isOpened = !isOpened;
                      setOpen(isOpened);
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          isOpened == false ? "assets/user_page/down.png" : "assets/user_page/down.png",
                          width: size(12),
                          height: size(12),
                        ),
                        Container(
                          decoration: Style.blankDecoration,
                          width: size(30),
                          height: size(20),
                        )
                      ],
                    )
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: size(5)),
              child: Divider(color: Color(0xffD4D4D4),thickness: 2,),
            ),
          ],
        ),
      ),
    );
  }
}


class Closed extends StatefulWidget {
  final Tft_MatchDto match;
  final Function setOpen;
  final Function getOpen;
  const Closed({Key? key , required this.match , required this.getOpen , required this.setOpen}) : super(key: key);

  @override
  _ClosedState createState() => _ClosedState();
}

class _ClosedState extends State<Closed> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.fromLTRB(0, 0, size(10), size(30)),
      height: size(83),
      decoration: BoxDecoration(
        color: Color(0xffEAEEF1),
        borderRadius: BorderRadius.only(topRight: Radius.circular(size(10)) , bottomRight: Radius.circular(size(10))),
        boxShadow: [Style.User.matchElementShadow],
      ),
      child: Column(
        children: [
          BasicInfo(match: widget.match, getOpen: widget.getOpen, setOpen: widget.setOpen)
          //Widget_BasicInfo(true),
        ],
      ),
    );
  }
}


class Opened extends StatefulWidget {
  final Tft_MatchDto match;
  final Function setOpen;
  final Function getOpen;
  const Opened({Key? key,required this.match , required this.getOpen , required this.setOpen}) : super(key: key);

  @override
  _OpenedState createState() => _OpenedState();
}

class _OpenedState extends State<Opened> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.fromLTRB(0, 0, size(10), size(30)),
      height: size(230),
      decoration: BoxDecoration(
        color: Color(0xffEAEEF1),
        borderRadius: BorderRadius.only(topRight: Radius.circular(size(10)) , bottomRight: Radius.circular(size(10))),
        boxShadow: [Style.User.matchElementShadow],
      ),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            BasicInfo(match: widget.match, getOpen: widget.getOpen, setOpen: widget.setOpen),
            Champions(match : widget.match),
          ],
        ),
      ),
    );
  }
}



class MatchInfo extends StatefulWidget {
  final Tft_MatchDto match;
  final Function setOpen;
  final Function getOpen;
  const MatchInfo({Key? key, required this.match , required this.getOpen , required this.setOpen}) : super(key: key);

  @override
  _MatchInfoState createState() => _MatchInfoState();
}

class _MatchInfoState extends State<MatchInfo> {

  @override
  Widget build(BuildContext context) {
    bool isOpen = widget.getOpen.call();

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.fromLTRB(0, 0, size(10), size(30)),
      height: size(isOpen == true ? 230 : 83),
      decoration: BoxDecoration(
        color: Color(0xffEAEEF1),
        borderRadius: BorderRadius.only(topRight: Radius.circular(size(10)) , bottomRight: Radius.circular(size(10))),
        boxShadow: [Style.User.matchElementShadow],
      ),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            BasicInfo(match: widget.match, getOpen: widget.getOpen, setOpen: widget.setOpen),
            Builder(
              builder: (context){
                if(isOpen == true)
                  return Champions(match : widget.match);
                else
                  return const SizedBox();
              }
            )
          ],
        ),
      ),
    );
  }
}







