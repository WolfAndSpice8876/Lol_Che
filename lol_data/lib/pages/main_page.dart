import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lol/contents/admob_id.dart';
import 'package:lol/contents/back_exit.dart';
import 'package:lol/contents/data.dart';
import 'package:lol/normal/debug.dart';
import 'package:lol/normal/page_move.dart';
import 'package:lol/normal/screen_percentage.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/contents/palette.dart' as Palette;
import 'package:lol/contents/style.dart' as Style;
import 'package:lol/pages/champion_page.dart';
import 'package:lol/pages/item_page.dart';
import 'package:lol/pages/synergy_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lol/pages/test_page.dart';
import 'package:lol/pages/traits_all_page.dart';
import 'package:lol/pages/user_page.dart';
import 'package:lol/riot/riot_error_code.dart';
import 'package:lol/special_contents/bookmark.dart';
import 'package:lol/special_contents/search_limit.dart';
import 'package:lol/widgets/info_toast.dart';
import 'package:lol/widgets/main_page/elements.dart';
import 'package:lol/widgets/main_page/my_summoner.dart';
import 'dart:collection';
import 'package:lol/special_contents/search_history.dart';
import 'package:lol/widgets/style_image.dart';
import 'package:admob_flutter/admob_flutter.dart';



class NoScrollAnimation extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}


class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final int matchNums = 5;
  final TextEditingController _searchTextController = new TextEditingController();

  int maxMatchNum = 30;
  Tft_RequestData tftData = Tft_RequestData(0);
  List<Widget> matchResult = <Widget>[];
  String searchStr = "";
  List<String> searchHistory = [];
  bool isLoading = false;



  //#. 위젯 함수

    //#. 검색 박스
  Widget Widget_SearchBox(){
    OutlineInputBorder border = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(size(20))),
        borderSide: BorderSide( color: Palette.Main.boxColor )
    );

    return Padding(
      padding: EdgeInsets.only(left: size(20),right: size(20)),
      child: TextFormField(
        controller: _searchTextController,
        decoration: InputDecoration(
            hintText: "검색할 소환사 이름을 입력해주세요",
            hintStyle: TextStyle(
              fontSize: size(12),
              color: const Color(0xffB6B6B6),
              fontWeight: FontWeight.w500,
              height: 1,
              textBaseline: TextBaseline.alphabetic,
            ),
            enabledBorder: border,
            border: border,
            focusedBorder: border,
            filled: true,
            fillColor: Palette.Main.boxColor,
            suffixIcon: IconButton(
              onPressed: (){
                FocusScope.of(context).unfocus();
                _goSearch(searchStr, matchNums, context);
              },
              icon: SvgPicture.asset(
                "assets/main_page/search.svg",
                height: size(24),
                width: size(24),
                color: Color(0xff6F6F6F).withOpacity(0.6),
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(size(10),size(25),size(25),0)
        ),
        onChanged : (value){
          searchStr = value;
        },
        onFieldSubmitted: (value){
          _goSearch(searchStr, matchNums, context);
        },
        textInputAction: TextInputAction.go
      ),
    );
  }

    //#. Search History
  Widget Widget_SearchHistory(){
    List<Widget> historyWidgets = <Widget>[];

    return Center(
      child: SizedBox(
        height: size(19),
        child: FutureBuilder(
            future: SearchHistory.get().then((value){
              historyWidgets = <Widget>[];
              searchHistory = value.toList();
              print(searchHistory);
              for(int i = 0; i<value.length; i++){
                historyWidgets.add(Widget_SearchText(value.elementAt(value.length - i - 1),value.length - i - 1));
              }
              for(int i = value.length; i<3; i++){
                historyWidgets.add(DummyBox());
              }
            }),
            builder: (context_ , snapshot_){
              if(snapshot_.connectionState == ConnectionState.waiting){
                return SizedBox();
              }
              else if(snapshot_.error != null){
                return Text("Error");
              }
              else{
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: historyWidgets,
                );
              }
            }
        ),
      ),
    );
  }

  Widget Widget_SearchText(String str_ , int index_){
    return Container(
      //decoration: Style.testBorder(),
      child: Padding(
        padding: EdgeInsets.only(right: size(0),left: size(0)),
        child: SizedBox(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  _goSearch(str_, matchNums, context);
                },
                child: Container(
                  decoration: Style.blankDecoration,
                  width: size(65),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          str_,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: size(14),
                            color: Palette.middleColor,
                            fontWeight: FontWeight.w700,
                              height: 1
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Style.wBox(size(5)),
              Widget_HistoryDeleteButton(index_),
            ],
          ),
        ),
      ),
    );
  }

  Widget Widget_HistoryDeleteButton(int index_){
    return GestureDetector(
      onTap: (){
        searchHistory.removeAt(index_);
        SearchHistory.replace(Queue.from(searchHistory));
        print(searchHistory);
        setState(() {
        });
      },
      child: SvgPicture.asset(
        "assets/main_page/delete.svg",
        width: size(15),
        height: size(15),
        color: Palette.lightColor,
      ),
    );
  }

  // Widget Widget_TopPadding(){
  //   // Size screen =  MediaQuery.of(context).size;
  //   // if(screen.height / screen.width > 1.8)
  //   //   return Style.hBox(getHeight(106));
  //   // else
  //   //   return Style.hBox(getHeight(55));
  //
  //   return Flexible(
  //     child: Container(
  //         constraints: BoxConstraints(
  //             maxHeight: getHeight(106), minWidth: double.infinity
  //         ),
  //         //child: Expanded(child: Container(color: Colors.blueAccent,),)
  //     ),
  //   );
  // }
  //
  // Widget Widget_SearchToMainUserPadding(){
  //   double screen =  MediaQuery.of(context).size.height / MediaQuery.of(context).size.width;
  //   double result = 0;
  //   double big = 800/360;
  //   double small = 640/360;
  //   // if(screen.height / screen.width > 1.8)
  //   //   return Style.hBox(getHeight(56));
  //   // else
  //   //   return Style.hBox(getHeight(30));;
  //   if(screen >= big){
  //     result = 56;
  //   }
  //   else if(screen >= small){
  //     result = 22 * (big - small) * (screen - small) + 34;
  //   }
  //   else{
  //     result = 34;
  //   }
  //   return Style.hBox(getHeight(result));
  // }
  
  
  //#. 디버그
  Widget Widget_Debug(){
    Widget DebugText(String text){
      return Text(
        text,
        style: TextStyle(
          fontSize: size(15),
        ),
      );
    }

    return Column(
      children: [
       // DebugText("isLoading :  ${isLoading}"),
       // DebugText("search num : ${SearchLimit.num}"),
        DebugText("ad size width: ${AdmobBannerSize.BANNER.width}"),
        DebugText("ad size height: ${AdmobBannerSize.BANNER.height}"),
        TextButton(
          onPressed: (){PageMove.move(context, TestPage());},
          child: DebugText("테스트 페이지")
        )
      ],
    );
  }





  //#. 함수
  void _goSearch(String userName_ , int num_ , BuildContext context_) async{

    if(isLoading == true)
      return;

    isLoading = true;
    setState(() {});

    int limitResult = await SearchLimit.trySearch();

    if(limitResult != 0){
      showSearchResult("1분 동안 최대 10번 검색 할 수 있습니다. (${(limitResult/1000).round()} 초)");
      isLoading = false;
      setState(() {});
      return;
    }



    await SearchHistory.add(userName_);
    Tft_RequestData tft_requestData = await GetData(userName_ , num_);

    if(tft_requestData.canShow == false){
      Debug.log("_goSearch : ${tft_requestData.statusCode}");
      isLoading = false;
      showSearchResult(RiotError.getErrorText(tft_requestData.statusCode));
      if(tft_requestData.statusCode == 600)
        await SearchLimit.setMinus();
    }
    else{
      bool isMarked = await BookMark.markCompare(userName_);
      Debug.log("_goSearch : ${tft_requestData.statusCode}");
      isLoading = false;
      PageMove.move(context_, UserPage(tft_requestData: tft_requestData, isMarked: isMarked));
      _resetPage();
    }
    setState(() {});
  }

  void goSearchOtherInOther(String userName_) async{
    _goSearch(userName_ ,matchNums , context );
  }

  void _resetPage(){
    print("reset");
    FocusScope.of(context).unfocus();
    _searchTextController.text = "";
    setState(() {});
  }

  Future<Tft_RequestData> GetData(String userName_, int num_)async{
    Tft_RequestData tftData = Tft_RequestData(num_);
    await tftData.getData(userName_, num_);
    return tftData;
  }

  double getHeight(double value_){
    double maxHeight = MediaQuery.of(context).size.height;
    double stdHeight = 800;
    return (value_ / stdHeight ) * maxHeight;
  }

  void showSearchResult(String msg_){
    InfoToast.show(msg_);
    return;
  }



  //#. 빌드
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SearchHistory.get().then((value) => searchHistory = value.toList());

  }

  @override
  Widget build(BuildContext context) {

    final ScreenSize screenSize = ScreenSize(context);

    Debug.setDebugMode(true);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Palette.backColor,
        systemNavigationBarColor: Palette.backColor,
        systemNavigationBarIconBrightness : Brightness.dark,
        statusBarIconBrightness : Brightness.dark
      ),
      child: WillPopScope(
        onWillPop: ()async{
          return BackButtonExit.doubleTap(2);
        },
        child: SafeArea(
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              resizeToAvoidBottomInset : false,
              backgroundColor: Palette.Main.backColor,
              // bottomNavigationBar: Container(
              //   child: AdmobBanner(
              //     adUnitId: admobBannerId,
              //     adSize: AdmobBannerSize.BANNER,
              //   ),
              // ),
              body: Stack(
                children: [
                  SizedBox(
                    height:
                      MediaQuery.of(context).size.height -
                      AdmobBannerSize.BANNER.height -
                      MediaQuery.of(context).padding.top -
                      size(10),
                    child: Column(
                      children: [
                        TopPadding(),
                        Widget_SearchBox(),
                        Style.hBox(getHeight(18)),
                        Padding(
                          padding: EdgeInsets.only(left: size(40) , right: size(40)),
                          child: Widget_SearchHistory(),
                        ),
                        SearchToMainUserPadding(),
                        MainUser(search : goSearchOtherInOther),
                        Style.hBox(getHeight(56)),
                        MoveButtonTable(resetPage: _resetPage,),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: screenSize.height.sizeByPercent(98/800)),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Visibility(
                        visible: isLoading,
                        child: CircularProgressIndicator(
                          color: Color(0xffEB7100),
                          backgroundColor: Color(0xffEB7100).withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                  Widget_Debug(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




