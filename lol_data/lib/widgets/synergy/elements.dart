import 'package:flutter/material.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/contents/palette.dart' as Palette;
import 'package:lol/contents/style.dart' as Style;
import 'package:lol/normal/wrapping.dart';

Widget Widget_Button(String type_ , Wrapping<String> value_){

  Widget _description(){
    if(value_.value == null){
      return Text(
        "${type_}을 선택하세요",
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
    width: size(153),
    height: size(42),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size(15))
    ),
    child: SizedBox(
      width: size(137),
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

// Widget Widget_DropDown(String type_, List<String> items_ , Wrapping<String> selectedValue_){
//   return DropdownButtonHideUnderline(
//     child: DropdownButton2(
//       isExpanded: true,
//       hint: Row(
//         children: [
//           SizedBox(
//             width: 4,
//           ),
//           Expanded(
//             child: Text(
//               '직업을 선택하세요',
//               style: TextStyle(
//                 fontSize: size(14),
//                 fontWeight: FontWeight.w500,
//                 color: Palette.lightColor,
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//       items: items_
//           .map((item) => Widget_Element(item)).toList(),
//       value: selectedValue_.value,
//       onChanged: (value) {
//         setState(() {
//           selectedValue_.value = value as String;
//           championList = getChampionList(originValue.value, classValue.value);
//           championList.forEach((element) {
//           });
//         });
//       },
//       icon: const Icon(
//         Icons.arrow_forward_ios_outlined,
//         color: Colors.black,
//       ),
//       iconSize: 14,
//       iconEnabledColor: Colors.yellow,
//       iconDisabledColor: Colors.grey,
//       buttonHeight: 50,
//       buttonWidth: size(153),
//       buttonPadding: const EdgeInsets.only(left: 14, right: 14),
//       buttonDecoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(14),
//       ),
//       itemHeight: size(36),
//       itemPadding: const EdgeInsets.only(left: 14, right: 14),
//       dropdownWidth: size(153),
//       dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(size(20)),
//           color: Colors.white,
//           boxShadow: [Style.tftShadow]
//       ),
//       dropdownElevation: 1,
//       offset: Offset(0, -10),
//       customButton: Widget_Button(type_ , selectedValue_),
//       dropdownMaxHeight: size(300),
//     ),
//   );
// }

// class DropDown extends StatefulWidget {
//   final String type;
//   final List<String> items;
//
//   const DropDown({Key? key,
//     required this.type ,
//     required this.items ,
//     required Wrapping<String> selectedValue
//   }) : super(key: key);
//
//
//   @override
//   _DropDownState createState() => _DropDownState();
// }
//
// class _DropDownState extends State<DropDown> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2(
//         isExpanded: true,
//         hint: Row(
//           children: [
//             SizedBox(
//               width: 4,
//             ),
//             Expanded(
//               child: Text(
//                 '직업을 선택하세요',
//                 style: TextStyle(
//                   fontSize: size(14),
//                   fontWeight: FontWeight.w500,
//                   color: Palette.lightColor,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//         items: widget.items
//             .map((item) => Widget_Element(item)).toList(),
//         value: widget.selectedValue.value,
//         onChanged: (value) {
//           setState(() {
//             widget.selectedValue_.value = value as String;
//             championList = getChampionList(originValue.value, classValue.value);
//             championList.forEach((element) {
//             });
//           });
//         },
//         icon: const Icon(
//           Icons.arrow_forward_ios_outlined,
//           color: Colors.black,
//         ),
//         iconSize: 14,
//         iconEnabledColor: Colors.yellow,
//         iconDisabledColor: Colors.grey,
//         buttonHeight: 50,
//         buttonWidth: size(153),
//         buttonPadding: const EdgeInsets.only(left: 14, right: 14),
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(14),
//         ),
//         itemHeight: size(36),
//         itemPadding: const EdgeInsets.only(left: 14, right: 14),
//         dropdownWidth: size(153),
//         dropdownDecoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(size(20)),
//             color: Colors.white,
//             boxShadow: [Style.tftShadow]
//         ),
//         dropdownElevation: 1,
//         offset: Offset(0, -10),
//         customButton: Widget_Button(type_ , selectedValue_),
//         dropdownMaxHeight: size(300),
//       ),
//     );
//   }
// }
