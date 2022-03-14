
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lol/contents/data.dart';
import 'package:lol/dto/dto_class.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/contents/style.dart' as Style;
import 'package:lol/contents/palette.dart' as Palette;
import 'package:lol/riot/riot_error_code.dart';
import 'package:lol/widgets/info_toast.dart';
import 'package:lol/widgets/user_page/button_table.dart';
import 'package:lol/widgets/user_page/match_element.dart';
import 'package:lol/widgets/user_page/match_list.dart';

class MatchView extends StatefulWidget {
  Tft_RequestData tft_requestData;
  int extraMatchNum;
  MatchView({Key? key, required this.tft_requestData , required this.extraMatchNum}) : super(key: key);

  @override
  MatchViewState createState() => MatchViewState(requestData: tft_requestData , matchDatas: tft_requestData.matchesData);
}

class MatchViewState extends State<MatchView> {

  //#. 선언
  Tft_RequestData requestData;
  Tft_RequestedMatches matchDatas;
  int currentPage = 0;
  bool additionalLoad = false;
  bool isLoading = false;
  late List<List<Widget>> matchElementsLists;

  //#. 생성자
  MatchViewState({required this.requestData, required this.matchDatas}){
    _makeMatchLists();
  }



  //#. 함수
  Future<void> _getExtraMatchDatas() async{
    Tft_RequestedMatches tmpData;
    tmpData = await Tft_DataGetter.getExtraMatchDatas(requestData.userData.puuid, widget.extraMatchNum);
    print("_getExtraMatchDatas : ${tmpData.statusCode}");
    if(tmpData.statusCode != 200)
      InfoToast.show(RiotError.getErrorText(tmpData.statusCode));

    // for(final element in tmpData.allMatches){
    //   if(element.statusCode != 200){
    //     InfoToast.show(RiotError.getErrorText(element.statusCode));
    //     additionalLoad = true;
    //     return;
    //   }
    // }

    matchDatas = tmpData;
    _makeMatchLists();
    additionalLoad = true;
  }

  List<Tft_MatchDto> _getShowMatches(int currentPage_){
    switch(currentPage_){
      case 0:
        return matchDatas.allMatches;

      case 1:
        return matchDatas.rankMatchDatas;

      case 2:
        return matchDatas.turboMatchDatas;

      case 3:
        return matchDatas.doubleMatchDatas;

      case 4:
        return matchDatas.normalMatchDatas;

      default:
        return matchDatas.allMatches;
    }
  }


  void _makeMatchLists(){
    matchElementsLists = <List<Widget>>[];
    for(int i = 0; i<matchDatas.allMatches.length; i++){
      List<Widget> widgets_ = <Widget>[];
      _getShowMatches(i).forEach((element) {
        widgets_.add(MatchElement(tft_matchDto: element));
      });
      matchElementsLists.add(widgets_);
    }
  }



  //#. 위젯 함수

  Widget Widget_MatchLoadInfo(){

    if(isLoading == true)
      return Padding(
        padding: EdgeInsets.only(bottom: size(10)),
        child: CircularProgressIndicator(
          color: const Color(0xffEB7100),
        ),
      );

    if(matchDatas.allMatches.length == 0){
      return Text(
        "[정보가 없습니다.]",
        style: TextStyle(
            fontSize: size(12),
            fontWeight: FontWeight.w300,
            color: const Color(0xff8E8E8E)
        ),
      );
    }

    if(additionalLoad == false){
      return TextButton(
        onPressed: () async{
          isLoading = true;
          setState(() {});
          await _getExtraMatchDatas().then((value){
            isLoading = false;
            setState(() {});
          });
        },
        child: Text(
          "[더보기]",
          style: TextStyle(
              fontSize: size(12),
              fontWeight: FontWeight.w300,
              color: const Color(0xff8E8E8E)
          ),
        ),
      );
    }
    else{
      return TextButton(
        onPressed: (){},
        child: Text(
          "[정보가 없습니다.]",
          style: TextStyle(
            fontSize: size(12),
            fontWeight: FontWeight.w300,
            color: const Color(0xff8E8E8E)
          ),
        ),
      );
    }
  }



  //#. 함수

  int getPage(){
    return currentPage;
  }

  void setPage(int thisPage){
    currentPage = thisPage;
    setState(() {});
  }


  //#. 빌드
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ButtonTable(setPage: setPage, getPage: getPage,),
        Style.hBox(10),
        //Widget_MatchView(),
        Builder(
          builder: (context){
            if(matchDatas.allMatches.length > 0)
              return MatchList(matches: _getShowMatches(currentPage),);
            else
              return SizedBox();
          },
        ),
        Widget_MatchLoadInfo(),
      ],
    );
  }
}



