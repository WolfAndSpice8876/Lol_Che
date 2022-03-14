import 'package:flutter/material.dart';
import 'package:lol/normal/page_move.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/contents/palette.dart' as Palette;
import 'package:lol/contents/style.dart' as Style;
import 'package:lol/pages/champion_page.dart';
import 'package:lol/pages/item_page.dart';
import 'package:lol/pages/synergy_page.dart';
import 'package:lol/pages/traits_all_page.dart';
import '../style_image.dart';


double getHeight(double value_ , context){
  double maxHeight = MediaQuery.of(context).size.height;
  double stdHeight = 800;
  return (value_ / stdHeight ) * maxHeight;
}

class MoveButton extends StatelessWidget {
  final Widget page;
  final String dis;
  final Function resetPage;
  final String image;
  const MoveButton({Key? key ,
    required this.page ,
    required this.dis ,
    required this.resetPage ,
    required this.image ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        PageMove.move(context, page);
        resetPage.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Palette.backColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: size(60),
              height: size(60),
              child: Image.asset(
                image,
                fit: BoxFit.fill,
              ),
            ),
            Style.hBox(size(10)),
            Text(
              dis,
              style: TextStyle(
                  fontSize: size(11),
                  fontWeight: FontWeight.w300,
                  color: Palette.lightColor
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MoveButtonRound extends StatelessWidget {
  final Widget page;
  final String dis;
  final Function resetPage;
  final String image;
  const MoveButtonRound({Key? key ,
    required this.page ,
    required this.dis ,
    required this.resetPage ,
    required this.image ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        PageMove.move(context, page);
        resetPage.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Palette.backColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StyleImage(
              path: image,
              width: size(60),
              height: size(60),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size(60)),
                  boxShadow: [BoxShadow(
                    offset: Offset(0,size(4)),
                    blurRadius: size(4),
                    color: Colors.black.withOpacity(0.15),
                  )]
              ),
              borderRadius: BorderRadius.circular(size(60)),
              boxFit: BoxFit.fill,
            ),
            Style.hBox(size(10)),
            Text(
              dis,
              style: TextStyle(
                  fontSize: size(11),
                  fontWeight: FontWeight.w300,
                  color: Palette.lightColor
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MoveButtonTable extends StatelessWidget {
  final Function resetPage;
  const MoveButtonTable({Key? key , required this.resetPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: size(77) , right: size(77)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MoveButtonRound(
                image: "assets/image/champion_face/TFT6_Veigar.png",
                dis:  "챔피언",
                page : ChampionPage(),
                resetPage: resetPage,
              ),
              MoveButtonRound(
                image: "assets/image/item/47.png",
                dis:  "아이템 검색기",
                page : ItemPage(isFromAllItem: false),
                resetPage: resetPage,
              ),
            ],
          ),
        ),
        Style.hBox(size(30)),
        Padding(
          padding: EdgeInsets.only(left: size(77) , right: size(77)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MoveButton(
                image: "assets/main_page/search_trait.png",
                dis:  "시너지 검색기",
                page : SynergyPage(),
                resetPage: resetPage,
              ),
              MoveButton(
                image: "assets/main_page/all_traits.png",
                dis:  "시너지 전체보기",
                page : TraitsAllPage(),
                resetPage: resetPage,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class DummyBox extends StatelessWidget {
  const DummyBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: size(7),left: size(10)),
      child: Style.wBox(size(50)),
    );
  }
}

class TopPadding extends StatelessWidget {
  const TopPadding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        constraints: BoxConstraints(
            maxHeight: getHeight(106 , context), minWidth: double.infinity
        ),
        //child: Expanded(child: Container(color: Colors.blueAccent,),)
      ),
    );
  }
}

class SearchToMainUserPadding extends StatelessWidget {
  const SearchToMainUserPadding({Key? key}) : super(key: key);
  final double big = 800/360;
  final double small = 640/360;

  @override
  Widget build(BuildContext context) {

    double result = 0;
    final double screen =  MediaQuery.of(context).size.height / MediaQuery.of(context).size.width;
    // if(screen.height / screen.width > 1.8)
    //   return Style.hBox(getHeight(56));
    // else
    //   return Style.hBox(getHeight(30));;
    if(screen >= big){
      result = 56;
    }
    else if(screen >= small){
      result = 22 * (big - small) * (screen - small) + 34;
    }
    else{
      result = 34;
    }
    return Style.hBox(getHeight(result , context));
  }
}








