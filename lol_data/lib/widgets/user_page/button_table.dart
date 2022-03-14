import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lol/contents/data.dart';
import 'package:lol/dto/dto_class.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/contents/style.dart' as Style;
import 'package:lol/contents/palette.dart' as Palette;
import 'package:lol/riot/riot_error_code.dart';
import 'package:lol/widgets/info_toast.dart';
import 'package:lol/widgets/user_page/match_element.dart';
import 'package:lol/widgets/user_page/match_list.dart';
import 'package:lol/widgets/user_page/match_view.dart';



class ButtonTable extends StatefulWidget {
  final Function getPage;
  final Function setPage;
  const ButtonTable({Key? key , required this.getPage , required this.setPage}) : super(key: key);

  @override
  _ButtonTableState createState() => _ButtonTableState();
}

class _ButtonTableState extends State<ButtonTable> {

  Widget Widget_PageButton(String str_ ,int thisPage_){
    final BoxDecoration onDeco = BoxDecoration(
        color: Color(0xffFFAD0C),
        borderRadius: BorderRadius.circular(size(13)),
        boxShadow: [BoxShadow(
          offset: Offset(0 , size(1)),
          color: Colors.black.withOpacity(0.15),
        )]
    );

    return GestureDetector(
      onTap: (){
        widget.setPage(thisPage_);
        //widget.matchViewState.currentPage = thisPage_;
        //widget.matchViewState.setState(() {});
      },
      child: Container(
        padding: EdgeInsets.only(left: size(2) , right: size(2)),
        margin: EdgeInsets.only(top: size(5),bottom: size(5)),
        alignment: Alignment.center,
        decoration: Style.blankDecoration,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: size(10) , left: size(10)),
          height: size(26),
          decoration: widget.getPage.call() == thisPage_ ? onDeco : BoxDecoration(),
          child: Text(
            str_,
            style: TextStyle(
              fontSize: size(11),
              fontWeight: FontWeight.w700,
              color: widget.getPage.call()  == thisPage_ ? Colors.white : Palette.lightColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(right: size(30), left: size(30)),
        child: SizedBox(
          height: size(49),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Button(str: "전체",thisPage: 0, getPage: widget.getPage, setPage: widget.setPage,),
              Button(str: "랭크",thisPage: 1, getPage: widget.getPage, setPage: widget.setPage,),
              Button(str: "초고속모드",thisPage: 2, getPage: widget.getPage, setPage: widget.setPage,),
              Button(str: "더블업",thisPage: 3, getPage: widget.getPage, setPage: widget.setPage,),
              Button(str: "일반",thisPage: 4, getPage: widget.getPage, setPage: widget.setPage,),
            ],
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final Function getPage;
  final Function setPage;
  final int thisPage;
  final String str;



  const Button({Key? key ,
    required this.setPage ,
    required this.getPage ,
    required this.thisPage,
    required this.str
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final BoxDecoration onDeco = BoxDecoration(
        color: const Color(0xffFFAD0C),
        borderRadius: BorderRadius.circular(size(13)),
        boxShadow: [BoxShadow(
          offset: Offset(0 , size(1)),
          color: Colors.black.withOpacity(0.15),
        )]
    );

    return GestureDetector(
      onTap: (){
        setPage(thisPage);
      },
      child: Container(
        padding: EdgeInsets.only(left: size(2) , right: size(2)),
        margin: EdgeInsets.only(top: size(5),bottom: size(5)),
        alignment: Alignment.center,
        decoration: Style.blankDecoration,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: size(10) , left: size(10)),
          height: size(26),
          decoration: getPage.call() == thisPage ? onDeco : BoxDecoration(),
          child: Text(
            str,
            style: TextStyle(
              fontSize: size(11),
              fontWeight: FontWeight.w700,
              color: getPage.call()  == thisPage ? Colors.white : Palette.lightColor,
            ),
          ),
        ),
      ),
    );
  }
}

// Widget Widget_PageButtonTable(){
//
//   Widget Widget_PageButton(String str_ ,int thisPage_){
//     final BoxDecoration onDeco = BoxDecoration(
//         color: Color(0xffFFAD0C),
//         borderRadius: BorderRadius.circular(size(13)),
//         boxShadow: [BoxShadow(
//           offset: Offset(0 , size(1)),
//           color: Colors.black.withOpacity(0.15),
//         )]
//     );
//
//     return GestureDetector(
//       onTap: (){
//         currentPage = thisPage_;
//         setState(() {});
//       },
//       child: Container(
//         padding: EdgeInsets.only(left: size(2) , right: size(2)),
//         margin: EdgeInsets.only(top: size(5),bottom: size(5)),
//         alignment: Alignment.center,
//         decoration: Style.blankDecoration,
//         child: Container(
//           alignment: Alignment.center,
//           padding: EdgeInsets.only(right: size(10) , left: size(10)),
//           height: size(26),
//           decoration: currentPage == thisPage_ ? onDeco : BoxDecoration(),
//           child: Text(
//             str_,
//             style: TextStyle(
//               fontSize: size(11),
//               fontWeight: FontWeight.w700,
//               color: currentPage == thisPage_ ? Colors.white : Palette.lightColor,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   return Center(
//     child: Padding(
//       padding: EdgeInsets.only(right: size(30), left: size(30)),
//       child: SizedBox(
//         height: size(49),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Widget_PageButton("전체" , 0),
//             Widget_PageButton("랭크" , 1),
//             Widget_PageButton("초고속모드" , 2),
//             Widget_PageButton("더블업" , 3),
//             Widget_PageButton("일반" , 4),
//           ],
//         ),
//       ),
//     ),
//   );
// }

