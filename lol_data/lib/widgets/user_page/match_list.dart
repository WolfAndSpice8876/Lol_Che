import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lol/dto/dto_class.dart';
import 'package:lol/widgets/user_page/match_element.dart';

class MatchList extends StatelessWidget {
  final List<Tft_MatchDto> matches;
  const MatchList({Key? key , required this.matches}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> elements = <Widget>[];

    matches.forEach((element) {
      elements.add(MatchElement(tft_matchDto: element));
    });

    return Column(
      children: elements,
    );
  }
}

