import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lol/contents/screen_optimized.dart';
import 'package:lol/database/data_library.dart';
import 'package:lol/dto/item_dto.dart';
import 'package:lol/normal/page_move.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/contents/style.dart' as Style;
import 'package:lol/contents/palette.dart' as Palette;
import 'package:lol/pages/item_all_page.dart';
import 'package:lol/special_contents/complete_item_number.dart';
import 'package:lol/widgets/back_button.dart';
import 'package:lol/widgets/page_name.dart';
import 'package:lol/widgets/style_image.dart';


class ItemPage extends StatefulWidget {
  ItemDto? item0;
  ItemDto? item1;
  ItemDto? itemComplete;
  bool isFromAllItem;
  ItemPage({Key? key , this.item0 ,this.item1, this.itemComplete, required this.isFromAllItem}) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState(item0,item1,itemComplete);
}

class _ItemPageState extends State<ItemPage> {

  List<ItemDto> basicItems = <ItemDto>[];
  List<ItemDto?> selectedItems = [null,null];
  ItemDto? completeItem;
  ItemDto? targetItem;

  _ItemPageState(ItemDto? item0 ,ItemDto? item1 , ItemDto? completeItem_){
    basicItems = DataLibrary.item.basicItems;
    setItem(item0 , item1 , completeItem_);
  }

  //#. 위젯 함수
  Widget Widget_ItemCombination(){
    Widget image(ItemDto? item , int index){
      if(item == null)
        return Container(
          width: size(63),
          height: size(63),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size(63)),
              color: Colors.black12
          ),
        );
      else
        return GestureDetector(
          onTap: (){
            selectedItems[index] = null;
            completeItem = null;
            setTargetItem();
            setState(() { });
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size(63)),
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
                borderRadius: BorderRadius.circular(size(63)),
                child: Image.asset(
                  item.image,
                  width: size(63),
                  height: size(63),
                )),
          ),
        );
    }

    Widget completeImage(){
      if(completeItem != null)
        return GestureDetector(
          onTap: (){
            if(completeItem != null){
              completeItem = null;
              selectedItems[0] = null;
              selectedItems[1] = null;
              setTargetItem();
              setState(() {});
            }
          },
          child: Container(
            width: size(63),
            height: size(63),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size(10)),
              boxShadow: [BoxShadow(
                offset: Offset(0,size(4)),
                blurRadius: size(4),
                color: Colors.black.withOpacity(0.25),
              )],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size(10)),
              child: Image.asset(completeItem!.image , fit: BoxFit.fill,),
            ),
          ),
        );
      else
        return Container(
          width: size(63),
          height: size(63),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size(10)),
            color: Colors.black12
          ),
        );

    }

    return Padding(
      padding: EdgeInsets.only(right: size(33),left: size(33)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          image(selectedItems[0] , 0),
          SvgPicture.asset("assets/item_info_page/plus.svg"),
          image(selectedItems[1] , 1),
          SvgPicture.asset("assets/item_info_page/equals.svg"),
          completeImage(),
        ],
      ),
    );
  }

  Widget Widget_ItemDescription(){
    ItemDto? item;
    if(completeItem != null)
      item = completeItem;
    else if(selectedItems[0] != null)
      item = selectedItems[0];
    else if(selectedItems[1] != null)
      item = selectedItems[1];

    if(item == null)
      return Container(
        width: size(276),
        height: size(192),
        decoration: BoxDecoration(
          color: Palette.mainColor,
          borderRadius: BorderRadius.circular(size(15)),
          boxShadow: [Style.tftShadow],
        )
      );
    else
      return Container(
        width: size(276),
        height: size(192),
        decoration: BoxDecoration(
          color: Palette.mainColor,
          borderRadius: BorderRadius.circular(size(15)),
          boxShadow: [Style.tftShadow],
        ),
        child: Padding(
          padding: EdgeInsets.only(left: size(15) ,right: size(15) , top: size(35)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.koreanName , style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: size(15),
                color: Color(0xffFBAC35),
              ),),
              Style.hBox(size(20)),
              Text( item.description,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: size(13),
                  color: Palette.lightColor,
              ),),
            ],
          ),
        )
      );
  }

  Widget Widget_Items(){
    return Column(
      children: [
        SizedBox(
          width: size(300),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Widget_ItemImage(basicItems[0]),
              Widget_ItemImage(basicItems[1]),
              Widget_ItemImage(basicItems[2]),
              Widget_ItemImage(basicItems[3]),
              Widget_ItemImage(basicItems[4]),
            ],
          ),
        ),
        Style.hBox(size(20)),
        SizedBox(
          width: size(234),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Widget_ItemImage(basicItems[5]),
              Widget_ItemImage(basicItems[6]),
              Widget_ItemImage(basicItems[8]),
              Widget_ItemImage(basicItems[7]),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget Widget_ItemImage(ItemDto itemDto){
    return GestureDetector(
      onTap: (){
        if(selectedItems[0] == null)
          selectedItems[0] = itemDto;
        else if(selectedItems[1] == null)
          selectedItems[1] = itemDto;
        else
          selectedItems[1] = itemDto;

        if(selectedItems[0] != null && selectedItems[1] != null){
          completeItem = DataLibrary.item.findAllByIndex(getCompleteItemNum(selectedItems[0]!.index, selectedItems[1]!.index));
        }

        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size(45)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0,size(4)),
              blurRadius: size(4),
              color: Colors.black.withOpacity(0.25),
            )
          ],
          color: Colors.grey,
        ),
        width: size(48),
        height: size(48),
        child: ClipRRect(
          child: Image.asset(
            itemDto.image,
            width: size(48),
            height: size(48),
          ),
          borderRadius: BorderRadius.circular(size(45)),
        ),
      ),
    );
  }



  //#. 함수
  void setItem(ItemDto? item0_ , ItemDto? item1_ , ItemDto? completeItem_){
    selectedItems[0] = null;
    selectedItems[1] = null;
    completeItem = null;

    if(completeItem_ != null){
      completeItem = completeItem_;
      if(completeItem_.materials.length == 2){
        selectedItems[0] = DataLibrary.item.findAllByIndex(completeItem_.materials[0]);
        selectedItems[1] = DataLibrary.item.findAllByIndex(completeItem_.materials[1]);
      }
    }
    else{
      if(item0_ != null)
        selectedItems[0] = item0_;
      if(item1_ != null)
        selectedItems[1] = item1_;
      if(selectedItems[0] != null && selectedItems[1] != null)
        completeItem = DataLibrary.item.findAllByIndex(getCompleteItemNum(selectedItems[0]!.index, selectedItems[1]!.index));
    }

    setTargetItem();
  }

  void setTargetItem(){
    if(completeItem != null)
      targetItem = completeItem;
    else if(selectedItems[0] != null)
      targetItem = selectedItems[0];
    else if(selectedItems[1] != null)
      targetItem = selectedItems[1];
    else
      targetItem = null;
  }

  void goAllItemPage(BuildContext context) async {
    // Navigator.push는 Future를 반환합니다. Future는 선택 창에서
    // Navigator.pop이 호출된 이후 완료될 것입니다.
    List<ItemDto?> result = await PageMove.move(context, ItemAllPage());
    if(result == null)
      result = [null, null,null];
    setItem(result[0],result[1],result[2]);
    setState(() {});
  }


  //#. 빌드
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: size(7)),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: size(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: (){
                            goAllItemPage(context);
                          },
                          icon: SvgPicture.asset(
                            "assets/item_info_page/item_all.svg",
                            width: size(24),
                            height: size(24),
                          ),
                          padding: EdgeInsets.only(right: size(7)),
                          iconSize: size(24),
                        ),
                        Text(
                          "아이템 전체보기",
                          style: TextStyle(color: Palette.lightColor , fontSize: size(12)),
                       )
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        CustomBackButton(),
                        Style.wBox(size(7)),
                        PageName("아이템 검색"),
                        Style.expanded,
                      ],
                    ),
                    Style.hBox(size(
                        ScreenOptimized.std(
                            maxHeight: 65,
                            minHeight: 35,
                            screen: MediaQuery.of(context)
                        ).value
                    )), // top padding
                    Widget_ItemCombination(),
                    Style.hBox(size(
                        ScreenOptimized.std(
                            maxHeight: 80,
                            minHeight: 35,
                            screen: MediaQuery.of(context)
                        ).value
                    )), // middle padding
                    //Widget_ItemDescription(),
                    Widget_ItemDescription(),
                    Style.hBox(size(
                        ScreenOptimized.std(
                            maxHeight: 70,
                            minHeight: 50,
                            screen: MediaQuery.of(context)
                        ).value
                    )), // bottom padding
                    Widget_Items()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class ItemDescription extends StatelessWidget {
  final ItemDto? item;
  const ItemDescription({Key? key , required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(item == null)
      return Container(
          width: size(276),
          height: size(192),
          decoration: BoxDecoration(
            color: Palette.mainColor,
            borderRadius: BorderRadius.circular(size(15)),
            boxShadow: [Style.tftShadow],
          )
      );
    else
      return Container(
          width: size(276),
          height: size(192),
          decoration: BoxDecoration(
            color: Palette.mainColor,
            borderRadius: BorderRadius.circular(size(15)),
            boxShadow: [Style.tftShadow],
          ),
          child: Padding(
            padding: EdgeInsets.only(left: size(15) ,right: size(15) , top: size(35)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item!.koreanName , style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: size(15),
                  color: Color(0xffFBAC35),
                ),),
                Style.hBox(size(20)),
                Text(item!.description,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: size(13),
                    color: Palette.lightColor,
                  ),),
              ],
            ),
          )
      );
  }
}



