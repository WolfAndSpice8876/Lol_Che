import 'package:flutter/material.dart';
import 'package:lol/dto/trait_dto.dart';
import 'package:lol/normal/page_move.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/pages/trait_full_info_page.dart';
import 'package:lol/contents/style.dart' as Style;
import 'package:lol/contents/palette.dart' as Palette;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_shadow/simple_shadow.dart';


class TraitIconButton extends StatelessWidget {
  final TraitDto trait;
  const TraitIconButton({Key? key , required this.trait}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        PageMove.move(context, TraitFullInfoPage(trait: trait,));
      },
      child: Column(
        children: [
          SimpleShadow(
            child: SvgPicture.asset(
              trait.image ,
              width: size(60),
              height: size(60),
              color: Color(0xffBD9E59),
            ),
            offset: Offset(0,size(4)),
            color: Colors.black,
            opacity: 0.15,
          ),
          Style.hBox(size(10)),
          Text(trait.koreanName , style: TextStyle(
              fontSize: size(12) , fontWeight: FontWeight.w700, color: Palette.lightColor
          ),),
        ],
      ),
    );
  }
}

class TraitButtonTable extends StatelessWidget {
  final List<TraitDto> traits;
  const TraitButtonTable({Key? key , required this.traits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> content = <Widget>[];

    for(int i = 0; i<traits.length;){
      List<Widget> widgets = <Widget>[];
      for(int j = 0; ; j++, i++){
        if(j >= 3 || i>=traits.length){
          for(int k = j; k<3; k++){
            widgets.add(SizedBox(width: size(60),));
          }
          break;
        }
        widgets.add(TraitIconButton(trait : traits[i]));
      }
      content.add(
          Padding(
            padding: EdgeInsets.only(bottom: size(25)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widgets,
            ),
          ));
    }

    return SingleChildScrollView(
      child: Column(
        children: content,
      ),
    );
  }
}




