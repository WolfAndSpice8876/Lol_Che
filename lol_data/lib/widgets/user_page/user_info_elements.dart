import 'package:flutter/material.dart';
import 'package:lol/dto/dto_class.dart';
import 'package:lol/riot/riot_api.dart';
import 'package:lol/special_contents/bookmark.dart';
import '../../contents/style.dart' as Style;
import 'package:lol/normal/size.dart';
import 'package:lol/contents/palette.dart' as Palette;
import 'package:flutter_svg/flutter_svg.dart';

class UserInfo extends StatelessWidget {
  final Tft_UserDto userDto;
  final bool isMarked;
  const UserInfo({Key? key , required this.userDto , required this.isMarked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(size(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(
            children: [
              Profile(userDto: userDto, isMarked: isMarked,),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Level(level: userDto.userLevel,),
              Name(name: userDto.name,)
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  final int id;
  const ProfileImage({Key? key , required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size(96),
      height: size(96),
      margin: EdgeInsets.only(right: size(10)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size(10)),
        boxShadow: [
          Style.User.profileElementShadow,
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Image.network(
          RiotApiUrl.profileImage(id),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class Level extends StatelessWidget {
  final int level;
  const Level({Key? key , required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size(26),
      alignment: Alignment.center,
      child: Text(
        "LV. " + level.toString(),
        style: TextStyle(
          fontSize: size(14),
          color: Color(0xff9e9e9e),
          fontWeight: FontWeight.w700,
          fontFamily: "roboto",
        ),
      ),
    );
  }
}

class Name extends StatelessWidget {
  final String name;
  const Name({Key? key , required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size(44),
      alignment: Alignment.center,
      child: Text(
        name,
        style: TextStyle(
          fontSize: size(24) ,
          color: Palette.middleColor,
          fontWeight: FontWeight.w700 ,
        ),
      ),
    );
  }
}

class Rank extends StatelessWidget {
  final Tft_LeagueEntryDto leagueEntryDto;
  const Rank({Key? key , required this.leagueEntryDto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String path = "assets/image/rank/NULL.png";

    switch(leagueEntryDto.tier)
    {
      case "BRONZE" :
      case "CHALLENGER" :
      case "DIAMOND" :
      case "GOLD" :
      case "GRANDMASTER" :
      case "IRON" :
      case "MASTER" :
      case "PLATINUM" :
      case "SILVER" :
        path = "images/rank/${leagueEntryDto.tier}.png";
        break;
      default:
        break;
    }

    return Container(
      width: size(81),
      child: Column(
        children: [
          Image.asset(
            path,
            width: size(43),
          ),
          Text(
            "${leagueEntryDto.tier} ${leagueEntryDto.rank}",
            style: TextStyle(
                fontSize : size(10),
                fontWeight: FontWeight.w300,
                fontFamily: "roboto"
            ),
          ),
        ],
      ),
    );
  }
}




class Profile extends StatefulWidget {
  final Tft_UserDto userDto;
  bool isMarked;
  Profile({Key? key , required this.userDto , required this.isMarked}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          width: size(96),
          height: size(96),
          margin: EdgeInsets.fromLTRB(0, size(0.8), size(10), 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size(10)),
            boxShadow: [
              Style.User.profileElementShadow,
            ],
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Image.network(
                  RiotApiUrl.profileImage(widget.userDto.profileIconId),
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
        Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(right: size(10)),
              child: BookMarkImage(isMarked : widget.isMarked , userDto: widget.userDto,),
            )
        ),
      ],
    );
  }
}


class BookMarkImage extends StatefulWidget {
  bool isMarked;
  Tft_UserDto userDto;
  BookMarkImage({Key? key , required this.isMarked , required this.userDto}) : super(key: key);

  @override
  _BookMarkImageState createState() => _BookMarkImageState();
}

class _BookMarkImageState extends State<BookMarkImage> {

  Future<void> _setMark()async{
    widget.isMarked = true;
    await BookMark.set(widget.userDto.name);
  }

  Future<void> _delete()async{
    widget.isMarked = false;
    await BookMark.reset();
  }


  Widget Widget_BookmarkCheckAlert(Function delete_){
    return AlertDialog(
      content: SizedBox(
        height: 30,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "계정을 삭제하시겠습니까?",
            style: TextStyle(
                fontSize: 16
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: ()async{
              await delete_.call();
              setState(() {});
              Navigator.pop(context);
            },
            child: Text("예")
        ),
        TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("아니요")
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }


  @override
  Widget build(BuildContext context) {
    String bookmarkIcon;

    if(widget.isMarked == false)
      bookmarkIcon = "assets/user_page/bookmark_off.svg";
    else
      bookmarkIcon = "assets/user_page/bookmark_on.svg";

    return IconButton(
      onPressed: () async{
        if(widget.isMarked == false)
          await _setMark();
        else{
          showDialog(
            context: context,
            builder: (BuildContext context){
              return Widget_BookmarkCheckAlert(_delete);
            },
          );
        }
        await BookMark.get();
        setState(() {});
      },

      iconSize: size(31),
      icon: SvgPicture.asset(
        bookmarkIcon,
        width: size(31),
        height: size(31),
      ),
      padding: EdgeInsets.zero,
    );
  }
}






