import 'package:flutter/material.dart';


class ChampionView extends StatelessWidget {
  final List<Widget> championList;
  const ChampionView({Key? key , required this.championList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: championList,
    );
  }
}
