import 'package:flutter/material.dart';
import 'package:lol/database/data_library.dart';
import 'package:lol/dto/item_dto.dart';
import 'package:lol/normal/page_move.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/pages/item_page.dart';
import 'package:lol/widgets/back_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lol/widgets/page_name.dart';
import 'package:lol/contents/palette.dart' as Palette;
import 'package:lol/contents/style.dart' as Style;
import 'package:lol/widgets/style_image.dart';

class ItemAllPage extends StatefulWidget {
  ItemAllPage({Key? key}) : super(key: key);

  @override
  _ItemAllPageState createState() => _ItemAllPageState();
}

class _ItemAllPageState extends State<ItemAllPage> {


  final List<ItemDto> itemList = <ItemDto>[];
  bool isSearchBarOn = false;
  bool isSearch = false;
  String searchText = "";

  _ItemAllPageState(){
    DataLibrary.item.allByKoreanName.forEach((key, value) {
      itemList.add(value);
    });
  }

  
  //#. 위젯함수
  // Widget Widget_ItemView(){
  //   if(isSearch == false)
  //     return ListView.builder(
  //         itemCount: itemList.length,
  //         itemBuilder: (itemContext , index){
  //           return Widget_Element(itemList[index]);
  //         }
  //     );
  //   else{
  //     List<ItemDto> searchItemList = <ItemDto>[];
  //     DataLibrary.item.allByKoreanName.forEach((key, value) {
  //       if(key.contains(searchText) == true)
  //         searchItemList.add(value);
  //     });
  //
  //     return ListView.builder(
  //         itemCount: searchItemList.length,
  //         itemBuilder: (itemContext , index){
  //           return Widget_Element(searchItemList[index]);
  //         }
  //     );
  //   }
  // }

  // Widget Widget_Element(ItemDto item_){
  //   return GestureDetector(
  //     onTap: (){
  //       if(item_.isComplete == false)
  //         Navigator.pop(context , [item_ , null , null]);
  //       else
  //         Navigator.pop(context , [null , null , item_]);;
  //
  //     },
  //     child: Padding(
  //       padding: EdgeInsets.only(right: size(40) , bottom: size(20)),
  //       child: Container(
  //         height: size(57),
  //         decoration: BoxDecoration(
  //           color: Palette.mainColor,
  //           boxShadow: [
  //             BoxShadow(
  //               offset: Offset(0,size(4)),
  //               color: Colors.black.withOpacity(0.15),
  //               blurRadius: size(4)
  //             )
  //           ],
  //           borderRadius: BorderRadius.only(
  //             topRight: Radius.circular(size(10)),
  //             bottomRight: Radius.circular(size(10))
  //           ),
  //         ),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Widget_Info(item_),
  //             Style.expanded,
  //             Widget_Materials(item_),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget Widget_Info(ItemDto item_){
  //   String dis = item_.description.replaceAll("\n", " ");
  //   double disSize = 0;
  //
  //   if(item_.materials.length != 2)
  //     disSize = MediaQuery.of(context).size.width - size(46 + 13 + 30 + 40 - 20);
  //   else
  //     disSize = MediaQuery.of(context).size.width - size(46 + 13 + 73 + 30 + 50);
  //
  //   return Row(
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.only(left: size(6)),
  //         child: StyleImage(
  //           path: item_.image,
  //           width: size(40),
  //           height: size(40),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.all(Radius.circular(size(9))),
  //           ),
  //           borderRadius: BorderRadius.all(Radius.circular(size(9))),
  //           boxFit: BoxFit.fill,
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(left: size(13)),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text(
  //               item_.koreanName,
  //               style: TextStyle(
  //                 color: Colors.black,
  //                 fontSize: size(11),
  //                 fontWeight: FontWeight.w700,
  //               ),
  //             ),
  //             Style.hBox(size(2)),
  //             SizedBox(
  //               width: disSize,
  //               child: Text(
  //                 dis,
  //                 style: TextStyle(
  //                     color: Palette.lightColor,
  //                     fontFamily: "roboto",
  //                     fontSize: size(10),
  //                     fontWeight: FontWeight.w300
  //                 ),
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //             ),
  //           ],
  //         ),
  //       )
  //     ],
  //   );
  // }

  // Widget Widget_Materials(ItemDto item_){
  //
  //   if(item_.materials.length == 2){
  //     return Padding(
  //       padding: EdgeInsets.only(right: size(30)),
  //       child: SizedBox(
  //         width: size(73),
  //         child: Row(
  //           children: [
  //             StyleImage(
  //               path: DataLibrary.item.findAllByIndex(item_.materials[0]).image,
  //               width: size(23),
  //               height: size(23),
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(size(23)),
  //               ),
  //               boxFit: BoxFit.fill,
  //               borderRadius: BorderRadius.circular(size(23)),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.only(left: size(5) , right: size(5)),
  //               child: SvgPicture.asset(
  //                 "assets/item_all_page/plus.svg",
  //                 height: size(17),
  //                 width: size(17),
  //               ),
  //             ),
  //             StyleImage(
  //               path: DataLibrary.item.findAllByIndex(item_.materials[1]).image,
  //               width: size(23),
  //               height: size(23),
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(size(23)),
  //               ),
  //               boxFit: BoxFit.fill,
  //               borderRadius: BorderRadius.circular(size(23)),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  //   else
  //     return SizedBox(
  //       width: size(0),
  //     );
  //
  //
  // }

  Widget Widget_SearchBar(){

    double _width = 0;
    double _iconSize = 24;
    double _height = 40;
    double _openWidth = 150;

    Widget _SearchBar(){
      return SizedBox(
          width: size(_openWidth),
          height: size(_height),
          child: Padding(
            padding: EdgeInsets.only(left: size(5)),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                suffixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  icon: SvgPicture.asset(
                    "assets/search.svg",
                    width: size(_iconSize),
                    height: size(_iconSize),
                  ),
                  onPressed: (){
                    isSearchBarOn = false;
                    setState(() {});
                  },
                  iconSize: size(_iconSize),
                ),
                hintText: "아이템 입력",
                hintStyle: TextStyle(
                    fontSize: size(12),
                    textBaseline : TextBaseline.alphabetic,
                    height: 1
                ),

              ),
              onChanged: (value){
                searchText = value;
                if(value != "" || searchText != null){
                  isSearch = true;
                  setState(() {});
                }
                if(value == "" && isSearch == true){
                  isSearch = false;
                  setState(() {});
                }

              },
              onEditingComplete: (){
                isSearchBarOn = false;
                if(searchText != ""  || searchText != null){
                  setState(() {});
                  print("com");
                }
              },
              autofocus: true,
            ),
          )
      );
    }

    Widget _Button(){
      return SizedBox(
        height: size(_height),
        child: IconButton(
          onPressed: (){
            isSearchBarOn = true;
            setState(() {});
          },
          icon: SvgPicture.asset(
            "assets/search.svg",
            width: size(_iconSize),
            height: size(_iconSize),
          ),
          iconSize: size(_iconSize),
        ),
      );
    }

    Widget _getChild(){
      if(isSearchBarOn == false)
        return _Button();
      else
        return Align(
            alignment: Alignment.centerRight,
            child: _SearchBar()
        );
    }

    if(isSearchBarOn == true)
      _width = size(_openWidth);
    else
      _width = size(0);

    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            width: _width,
            height: size(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Align(
            alignment: Alignment.centerRight,
            child: _getChild()
        ),
      ],
    );
  }

  Widget Widget_MaterialButtons(){
    Widget _button(ItemDto element){
      return Container(
        margin: EdgeInsets.all(size(5)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size(45)),
            boxShadow: [
              BoxShadow(
                offset: Offset(0,size(4)),
                blurRadius: size(4),
                color: Colors.black.withOpacity(0.25),
              )
            ],
            color: Colors.white12
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(size(5)),
            child: Image.asset(
              element.image,
              width: size(45),
              height: size(45),
              fit: BoxFit.fill,
            )),
      );
    }


    List<Widget> elements = <Widget>[];

    DataLibrary.item.basicItems.forEach((element) {
      elements.add(_button(element));
    });



    return Container(
      child: Wrap(
          children: elements
      ),
    );
  }





  
  //#. 빌드
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.backColor,
        body: Padding(
          padding: EdgeInsets.only(top: size(7)),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: size(20)),
                child: Row(
                  children: [
                    CustomBackButton(),
                    Padding(
                      padding: EdgeInsets.only(left: size(10)),
                      child: SvgPicture.asset(
                        "assets/item_info_page/item_all.svg",
                        width: size(24),
                        height: size(24),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size(8)),
                      child: PageName("아이템 전체보기"),
                    ),
                    Style.expanded,
                    Widget_SearchBar(),
                  ],
                ),
              ),
              Expanded(child: ItemView(
                itemList: itemList,
                searchText: searchText,
                isSearch: isSearch,
              )),
            ],
          ),
        ),
      )
    );
  }
}


class ItemView extends StatelessWidget {
  final bool isSearch;
  final List<ItemDto> itemList;
  final String searchText;

  const ItemView({
    Key? key ,
    required this.isSearch,
    required this.itemList,
    required this.searchText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(isSearch == false)
      return ListView.builder(
          itemCount: itemList.length,
          itemBuilder: (itemContext , index){
            return Element(item: itemList[index]);
          }
      );
    else{
      List<ItemDto> searchItemList = <ItemDto>[];
      DataLibrary.item.allByKoreanName.forEach((key, value) {
        if(key.contains(searchText) == true)
          searchItemList.add(value);
      });

      return ListView.builder(
          itemCount: searchItemList.length,
          itemBuilder: (itemContext , index){
            return Element(item: searchItemList[index]);
          }
      );
    }
  }
}

class Element extends StatelessWidget {
  ItemDto item;
  Element({Key? key , required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(item.isComplete == false)
          Navigator.pop(context , [item , null , null]);
        else
          Navigator.pop(context , [null , null , item]);;

      },
      child: Padding(
        padding: EdgeInsets.only(right: size(40) , bottom: size(20)),
        child: Container(
          height: size(57),
          decoration: BoxDecoration(
            color: Palette.mainColor,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0,size(4)),
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: size(4)
              )
            ],
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(size(10)),
                bottomRight: Radius.circular(size(10))
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ItemInfo(item: item,),
              Style.expanded,
              Materials(item: item,),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemInfo extends StatelessWidget {
  final ItemDto item;
  const ItemInfo({Key? key ,required this.item}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    String dis = item.description.replaceAll("\n", " ");
    double disSize = 0;
    
    if(item.materials.length != 2)
      disSize = MediaQuery.of(context).size.width - size(46 + 13 + 30 + 40 - 20);
    else
      disSize = MediaQuery.of(context).size.width - size(46 + 13 + 73 + 30 + 50);

    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: size(6)),
          child: StyleImage(
            path: item.image,
            width: size(40),
            height: size(40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(size(9))),
            ),
            borderRadius: BorderRadius.all(Radius.circular(size(9))),
            boxFit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: size(13)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.koreanName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: size(11),
                  fontWeight: FontWeight.w700,
                ),
              ),
              Style.hBox(size(2)),
              SizedBox(
                width: disSize,
                child: Text(
                  dis,
                  style: TextStyle(
                      color: Palette.lightColor,
                      fontFamily: "roboto",
                      fontSize: size(10),
                      fontWeight: FontWeight.w300
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class Materials extends StatelessWidget {
  final ItemDto item;
  const Materials({Key? key , required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(item.materials.length == 2){
      return Padding(
        padding: EdgeInsets.only(right: size(30)),
        child: SizedBox(
          width: size(73),
          child: Row(
            children: [
              StyleImage(
                path: DataLibrary.item.findAllByIndex(item.materials[0]).image,
                width: size(23),
                height: size(23),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size(23)),
                ),
                boxFit: BoxFit.fill,
                borderRadius: BorderRadius.circular(size(23)),
              ),
              Padding(
                padding: EdgeInsets.only(left: size(5) , right: size(5)),
                child: SvgPicture.asset(
                  "assets/item_all_page/plus.svg",
                  height: size(17),
                  width: size(17),
                ),
              ),
              StyleImage(
                path: DataLibrary.item.findAllByIndex(item.materials[1]).image,
                width: size(23),
                height: size(23),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size(23)),
                ),
                boxFit: BoxFit.fill,
                borderRadius: BorderRadius.circular(size(23)),
              ),
            ],
          ),
        ),
      );
    }
    else
      return SizedBox(
        width: size(0),
      );
  }
}


