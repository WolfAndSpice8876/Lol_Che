import 'package:flutter/material.dart';
import 'package:lol/database/data_library.dart';
import 'package:lol/dto/trait_dto.dart';
import 'package:lol/normal/page_move.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/normal/wrapping.dart';
import 'package:lol/pages/trait_full_info_page.dart';
import 'package:lol/widgets/back_button.dart';
import 'package:lol/contents/style.dart' as Style;
import 'package:lol/widgets/page_name.dart';
import 'package:lol/contents/palette.dart' as Palette;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lol/widgets/trait_all_page/elements.dart';
import 'package:simple_shadow/simple_shadow.dart';

class TraitsAllPage extends StatefulWidget {
  const TraitsAllPage({Key? key}) : super(key: key);

  @override
  _TraitsAllPageState createState() => _TraitsAllPageState();
}

class _TraitsAllPageState extends State<TraitsAllPage> {

  Wrapping<String> selectedValue = Wrapping(value: "계열");

  late final List<TraitDto> origins;
  late final List<TraitDto> classes;

  _TraitsAllPageState(){
    origins = DataLibrary.trait.originsByKoreanName.entries.map( (entry) => entry.value).toList();
    classes = DataLibrary.trait.classesByKoreanName.entries.map( (entry) => entry.value).toList();
  }
   

  
  //#. 위젯함수
  DropdownMenuItem<String> Widget_Element(String item_){
    return DropdownMenuItem<String>(
      value: item_,
      child: Row(
        children: [
          Icon(
            Icons.settings,
            size: size(24),
          ),
          Style.wBox(7),
          Text(
            item_,
            style: TextStyle(
              fontSize: size(12),
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget Widget_Button(Wrapping<String> value_){

    Widget _description(){
      if(value_.value == null){
        return Text(
          "시너지",
          style: TextStyle(
              fontSize: size(14),
              color: Palette.lightColor,
              fontWeight: FontWeight.w500
          ),
        );
      }
      else{
        return Text(
          value_.value!,
          style: TextStyle(
              fontSize: size(14),
              color: Colors.black,
              fontWeight: FontWeight.w700
          ),
        );
      }
    }

    return Container(
      width: size(110),
      height: size(35),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size(15))
      ),
      child: SizedBox(
        width: size(93),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _description(),
            Icon(
              Icons.expand_more,
              size: size(22),
              color: Palette.middleColor,
            )
          ],
        ),
      ),
    );
  }

  Widget Widget_DropDown(List<String> items_ , Wrapping<String> selectedValue_){
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: [
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                '시너지',
                style: TextStyle(
                  fontSize: size(14),
                  fontWeight: FontWeight.w500,
                  color: Palette.lightColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: items_
            .map((item) => Widget_Element(item)).toList(),
        value: selectedValue_.value,
        onChanged: (value) {
          setState(() {
            selectedValue_.value = value as String;
          });
        },
        icon: const Icon(
          Icons.arrow_forward_ios_outlined,
          color: Colors.black,
        ),
        iconSize: 14,
        iconEnabledColor: Colors.yellow,
        iconDisabledColor: Colors.grey,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
        ),
        itemHeight: size(36),
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownWidth: size(120),
        dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size(20)),
            color: Colors.white,
            boxShadow: [Style.tftShadow]
        ),
        dropdownElevation: 1,
        offset: Offset(0, -10),
        customButton: Widget_Button(selectedValue_),
        dropdownMaxHeight: size(800),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.backColor,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top : size(5)),
              child: Row(
                children: [
                  CustomBackButton(),
                  Padding(
                    padding: EdgeInsets.only(left: size(5)),
                    child: PageName("시너지 전체보기"),
                  ),
                ],
              ),
            ),
            Style.hBox(size(40)),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: size(17)),
                child: Widget_DropDown(["계열" , "직업"] , selectedValue),
              )
            ),
            Style.hBox(size(35)),
            Expanded(
              child: Builder(
                builder: (context){
                  if(selectedValue.value == "계열")
                    return TraitButtonTable(traits: origins,);
                  else
                    return TraitButtonTable(traits: classes,);
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}
