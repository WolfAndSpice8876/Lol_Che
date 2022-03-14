import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lol/normal/page_move.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/contents/style.dart' as Style;
import 'package:lol/dto/champion_dto.dart';
import 'package:lol/widgets/champion_full_info_page/champion_info.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ChampionFullInfo extends StatefulWidget {
  ChampionDto championDto;
  ChampionFullInfo({Key? key ,required this.championDto});

  @override
  _ChampionFullInfoState createState() => _ChampionFullInfoState();
}

class _ChampionFullInfoState extends State<ChampionFullInfo> with TickerProviderStateMixin{

  String svgPath = "assets/champion_info_page/camera.svg";

  late final AnimationController controller = AnimationController(
    duration: Duration(milliseconds: 500),
    vsync: this,
  );

  late final Animation<double> animation = CurvedAnimation(
    parent: controller,
    curve: Curves.fastOutSlowIn,
  );
  bool isOpen = true;

  @override
  initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200)).then((value) => controller.forward());

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  //#. 위젯 함수
  Widget Widget_TopButtonTable(){
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: (){
                PageMove.back(context);
              },
                icon: SvgPicture.asset(
                  "assets/back.svg",
                  color: Colors.white,
                  width: size(30),
                  height: size(30),
                ),
              iconSize: size(30),
            ),
            Style.expanded,
            IconButton(
              onPressed: (){
                if(controller.isAnimating == false){
                  if(controller.isCompleted){
                    controller.reverse();
                    isOpen = false;
                    svgPath = "assets/champion_info_page/file.svg";
                    setState(() {});
                  }
                  else{
                    controller.forward();
                    isOpen = true;
                    svgPath = "assets/champion_info_page/camera.svg";
                    setState(() {});
                  }

                }
              },
                icon: SvgPicture.asset(
                  svgPath,
                  width: size(24),
                  height: size(24),
                ),
              iconSize: size(24),
            ),
          ],
        ),
      ],
    );
  }

  //#. 빌드
  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;

    double _getHeight(double height_){
      return screenHeight * (height_ / 800);
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white.withOpacity(0),
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness : Brightness.dark,
        statusBarIconBrightness : Brightness.light
      ),
      child: WillPopScope(
        onWillPop: ()async{
          if(isOpen == true && controller.isAnimating == false){
            controller.reverse();
            isOpen = false;
            svgPath = "assets/champion_info_page/file.svg";
            setState(() {});
            return false;
          }
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset : false,
          body: Stack(
            children: [
              Image.asset(
                widget.championDto.fullImage,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
                //fit: BoxFit.fitWidth,
              ),
              SafeArea(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Style.expanded,
                      SizeTransition(
                        child: Champion_Info(championDto: widget.championDto,),
                        sizeFactor: animation,
                        axis: Axis.vertical,
                        axisAlignment: -1,
                      ),
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    Widget_TopButtonTable(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
