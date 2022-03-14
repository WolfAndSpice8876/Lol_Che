import 'package:flutter/material.dart';
import 'package:lol/dto/champion_dto.dart';
import 'package:lol/normal/screen_percentage.dart';
import 'package:lol/normal/search.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/contents/style.dart' as Style;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:lol/contents/palette.dart' as Palette;
import 'package:lol/normal/wrapping.dart';
import 'package:lol/database/champion_data.dart';
import 'package:lol/database/data_library.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lol/widgets/back_button.dart';
import 'package:lol/widgets/champions_page/champion_element.dart';
import 'package:lol/widgets/page_name.dart';
import 'dart:ui';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {




  @override
  Widget build(BuildContext context) {



    List<Widget> widgets = <Widget>[];
    for(int i = 0; i<100; i++ ){
      widgets.add(ImageBox());
    }

    final MediaQueryData screen = MediaQueryData.fromWindow(window);
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: widgets
        )
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  const CustomText({Key? key , required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
      style: TextStyle(fontSize: size(15)),
    );
  }
}

class ImageBox extends StatefulWidget {
  const ImageBox({Key? key}) : super(key: key);

  @override
  State<ImageBox> createState() => _ImageBoxState();
}

class _ImageBoxState extends State<ImageBox> {
  @override
  Widget build(BuildContext context) {
    ChampionDto championDto = DataLibrary.champion.findAllByName("아리");
    return Container(
      margin: EdgeInsets.only(bottom: size(2) , right: size(5)),
      decoration: BoxDecoration(
          color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(size(8))
      ),
      height: size(80),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImage(),
          CustomImage(),
          CustomImage(),
          CustomImage(),
          CustomImage(),
          CustomImage(),
          CustomImage(),
          CustomImage(),
        ],
      ),
    );
  }
}

class CustomImage extends StatelessWidget {
  const CustomImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChampionDto championDto = DataLibrary.champion.findAllByName("아리");
    return Container(
      width: size(40),
      height: size(40),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        boxShadow: [Style.tftShadow],
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(size(10)),
          child: Image.asset(championDto.faceImage)
      ),
    );
  }
}







