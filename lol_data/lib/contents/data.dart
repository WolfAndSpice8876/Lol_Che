import 'dart:convert';
import 'package:lol/contents/dto_type.dart';
import 'package:lol/contents/error_name.dart';

import '../normal/debug.dart';
import '../dto/dto_class.dart';
import '../riot/riot_api.dart';
import 'package:http/http.dart';


class Tft_DataGetter {

  static Future<Tft_UserDto> getUserDtoByName(String name_) async
  {
    Response response;
    String progress = "none";
    late Tft_UserDto tft_userDto;


    response = await RiotResponse.getTftUserDataByName(name_);
    progress = "response : ${response.statusCode}";

    if (response.statusCode == 200) {
      try {
        var json = jsonDecode(response.body);

        progress = "jsonDecode";
        tft_userDto = Tft_UserDto(
            puuid: json['puuid'],
            name: json['name'],
            id: json['id'],
            userLevel: json['summonerLevel'],
            profileIconId: json['profileIconId'],
            status: response.statusCode,
            isLoaded: true
        );

        return tft_userDto;
      } catch (e) {
        Debug.log("Tft_DataGetter : getUserDtoByName : ${e}");
        return Tft_UserDto.status(-100);
      }
    }
    else {
      print("Tft_getUserDtoByName : ${getErrorName(response.statusCode)} : ${progress}");
      return Tft_UserDto.status(response.statusCode);
    }
  }

  static Future<Tft_MatchIdsDto> getMatchesId(String puuid_, int num_) async
  {
    Response response;

    response = await RiotResponse.getTftMatchesIds(puuid_, num_);

    if (response.statusCode == 200) {
      return Tft_MatchIdsDto(
        ids: List<String>.from(jsonDecode(response.body)),
        status: 200
      );
    }
    else {
      print("Tft_DataGetter : getMatchesId : Connect Error : ${response.statusCode}");
      return Tft_MatchIdsDto.status(response.statusCode);
    }
  }

  static Future<Tft_MatchDto> getMatchDto(String matchId_, String myPuuid_) async
  {
    Response response;
    response = await RiotResponse.getTftMatchDto(matchId_);
    String progress = "getMatchDto : none";
    if (response.statusCode == 200) {

      try {
        var jsonData = jsonDecode(response.body)['info'];
        var jsonPart = jsonData['participants'];

        progress = "getMatchDto : response";

        List<Tft_ParticipantDto> pDtos = <Tft_ParticipantDto>[];

        for (int i = 0; i < 8; i++) {
          var jsonTraits = jsonPart[i]['traits'] as List<dynamic>;
          var jsonUnits = jsonPart[i]['units'] as List<dynamic>;
          List<Tft_TraitInfoDto> traits = <Tft_TraitInfoDto>[];
          List<Tft_UnitInfoDto> units = <Tft_UnitInfoDto>[];

          progress = "trait info";
          for (int j = 0; j < jsonTraits.length; j++) {
            Tft_TraitInfoDto tft_traitDto = Tft_TraitInfoDto(
                name: jsonTraits[j]['name'],
                numUnits: jsonTraits[j]['num_units'],
                style: jsonTraits[j]['style'],
                tierCurrent: jsonTraits[j]['tier_current'],
                tierTotal: jsonTraits[j]['tier_total'],
                isLoaded: true,
                status: response.statusCode
            );
            traits.add(tft_traitDto);
          }

          progress = "unit info";
          for (int j = 0; j < jsonUnits.length; j++) {
            List<int> items = [];
            var jsonItems = jsonUnits[j]['items'] as List;
            for (int k = 0; k < jsonItems.length; k++) {
              items.add(jsonItems[k]);
            }

            Tft_UnitInfoDto tft_unitDto = Tft_UnitInfoDto(
                character_id: jsonUnits[j]['character_id'],
                name: jsonUnits[j]['name'],
                //chosen: jsonUnits[j]['chosen'],
                rarity: jsonUnits[j]['rarity'],
                tier: jsonUnits[j]['tier'],
                items: items,
                isLoaded: true,
                status: response.statusCode,
            );
            units.add(tft_unitDto);
          }

          progress = "participant info";
          Tft_ParticipantDto tmp = Tft_ParticipantDto(
              puuid: jsonPart[i]['puuid'],
              level: jsonPart[i]['level'],
              placement: jsonPart[i]['placement'],
              traits: traits,
              units: units,
              isLoaded: true,
              status: response.statusCode
          );
          pDtos.add(tmp);
        }

        progress = "getMatchDto : jsonDecode";
        Tft_MatchDto matchDTO = Tft_MatchDto.makeByPuuid(
            Tft_MatchInfoDto(
                gameDataTime: jsonData['game_datetime'],
                gameLength: jsonData['game_length'],
                gameType: jsonData['tft_game_type'],
                queueId: jsonData['queue_id'],
                isLoaded: true,
                status: response.statusCode
            ),
            pDtos,
            myPuuid_,
            response.statusCode
        );
        return matchDTO;

      }catch (e) {
       Debug.log("Tft_DataGetter : getMatchDto : ${e} : ${progress}");
       return Tft_MatchDto.status(-100);
      }


    }
    else {
      print("Tft_getMatchDto : ${getErrorName(response.statusCode)}");
      return Tft_MatchDto.status(response.statusCode);
    }
  }

  static Future<Tft_MatchListDto> getMatchDtos(String puuid_ , int nums_) async
  {
    Tft_MatchIdsDto matchIds = Tft_MatchIdsDto.blank();
    List<Tft_MatchDto> matchDtos = <Tft_MatchDto>[];
    matchIds = await getMatchesId(puuid_ ,nums_ );

    if(matchIds.statusCode != 200)
      return Tft_MatchListDto.status(matchIds.statusCode);


    int requestedNum = matchIds.ids.length;

    for (int i = 0; i < requestedNum; i++) {
      matchDtos.add(Tft_MatchDto.blank());
    }

    await Future.wait([
      for(int i = 0; i<requestedNum; i++)
        getMatchDto(matchIds.ids[i], puuid_).then((value){
          int j = i;
          matchDtos[j] = value;
        }),
    ]);

    return Tft_MatchListDto(matches: matchDtos, status: 200);
  }

  static Future<Tft_RequestedMatches> getExtraMatchDatas(String puuid_ , int nums_) async{
    return await Tft_RequestedMatches.getData(puuid_, nums_);
  }

  static Future<Tft_LeagueEntryDto> getLeagueEntryDto(
      String summonerId_) async
  {
    Response response;
    Tft_LeagueEntryDto tft_leagueEntryDto = Tft_LeagueEntryDto.blank();
    Tft_TurboLeagueEntryDto tft_turboLeagueEntryDto = Tft_TurboLeagueEntryDto.blank();
    String progress = "none";
    response = await RiotResponse.getTftLeagueEntryDTO(summonerId_);
    progress = "response : ${response.statusCode}";

    if (response.statusCode != 200) {
      Debug.log("Tft_DataGetter : getLeagueEntryDto : ${getErrorName(response.statusCode)}");
      return Tft_LeagueEntryDto.status(response.statusCode);
    }

    try {
      var jsonData = jsonDecode(response.body);
      var jsonDatas = jsonData as List<dynamic>;

      jsonDatas.forEach((element) {
        if(element['queueType'] == "RANKED_TFT"){
          tft_leagueEntryDto = Tft_LeagueEntryDto(
            leagueId: element['leagueId'],
            summonerId: element['summonerId'],
            summonerName: element['summonerName'],
            queueType: element['queueType'],
            tier: element['tier'],
            rank: element['rank'],
            //turboTier: jsonData['leagueId'],
            //turboRating: jsonData['leagueId'],
            leaguePoints: element['leaguePoints'],
            wins: element['wins'],
            losses: element['losses'],
            isLoaded: true,
            status: response.statusCode
          );
        }
        else if(element['queueType'] == "RANKED_TFT_TURBO"){
          tft_turboLeagueEntryDto = Tft_TurboLeagueEntryDto(
              queueType: element['queueType'],
              ratedTier: element['ratedTier'],
              ratedRating: element['ratedRating'],
              summonerId: element['summonerId'],
              summonerName: element['summonerName'],
              wins: element['wins'],
              losses: element['losses'],
              isLoaded: true,
              status: response.statusCode
          );
        }
      });
      progress = "jsonDecode";
      
      return tft_leagueEntryDto;
    }catch (e) {
      Debug.log("Tft_DataGetter : getExtraMatchDatas : ${e} : ${progress}");
      return Tft_LeagueEntryDto.status(-100);
    }
  }

}



class Tft_RequestData {
  late int maxRequestMatches;
  late int requestedMatches;
  late Tft_UserDto userData;
  late List<String> matchIds;
  late int statusCode;
  late Tft_LeagueEntryDto leagueEntryDto;
  late Tft_RequestedMatches matchesData;
  late bool canShow = false;
  late List<DtoType> errorDtos = [];

  Tft_RequestData(int matchNums) {
    maxRequestMatches = matchNums;
    requestedMatches = 0;
    userData = Tft_UserDto.blank();
    matchIds = <String>[];
    statusCode = 0;
    leagueEntryDto = Tft_LeagueEntryDto.blank();
    matchesData = Tft_RequestedMatches.blank();
  }

  Tft_RequestData.blank(){
    maxRequestMatches = 0;
    requestedMatches = 0;
    userData = Tft_UserDto.blank();
    matchIds = <String>[];
    statusCode = 0;
    leagueEntryDto = Tft_LeagueEntryDto.blank();
    matchesData = Tft_RequestedMatches.blank();
    canShow = false;
    errorDtos = [];
  }

  Future<int> getData(String name_, int matchNums_) async {

    requestedMatches = 0;
    maxRequestMatches = matchNums_;
    userData = Tft_UserDto.blank();
    canShow = true;

    // #. 유저 정보 가져오기
    await Tft_DataGetter.getUserDtoByName(name_).then((value) {
      userData = value;
    });

    if (userData.statusCode != 200) {
      Debug.log("Tft_RequestData : Tft_UserDto : ${getErrorName(userData.statusCode)}");
      statusCode = userData.statusCode;
      canShow = false;
      errorDtos.add(DtoType.user);
      return userData.statusCode;
    }

    // #. 유저 리그 정보 가져오기
    await Tft_DataGetter.getLeagueEntryDto(userData.id).then((value){
      leagueEntryDto = value;
    });

    if(leagueEntryDto.statusCode != 200){
      Debug.log("Tft_RequestData : Tft_UserDto : ${getErrorName(leagueEntryDto.statusCode)}");
      statusCode = leagueEntryDto.statusCode;
      errorDtos.add(DtoType.leagueEntry);
      //return leagueEntryDto.statusCode;
    }

    // #. match id 리스트 가져오기
    await Tft_DataGetter.getMatchesId(userData.puuid, matchNums_).then((value) {

      if(value.statusCode != 200){
        statusCode = value.statusCode;
        errorDtos.add(DtoType.matchIds);
      }
      matchIds = value.ids;
    });

    // #. match 정보 가져오기
    maxRequestMatches = matchIds.length;
    matchesData = await Tft_RequestedMatches.getData(userData.puuid, matchNums_);
    requestedMatches = matchesData.allMatches.length;

    if(statusCode != 200){
      statusCode = matchesData.statusCode;
      errorDtos.add(DtoType.match);
    }

    return statusCode;
  }
}

class Tft_RequestedMatches extends RiotDto
{
  late List<Tft_MatchDto> allMatches;
  late List<Tft_MatchDto> normalMatchDatas;
  late List<Tft_MatchDto> rankMatchDatas;
  late List<Tft_MatchDto> turboMatchDatas;
  late List<Tft_MatchDto> doubleMatchDatas;

  Tft_RequestedMatches({
    required this.allMatches,
    required this.normalMatchDatas,
    required this.rankMatchDatas,
    required this.turboMatchDatas,
    required this.doubleMatchDatas,
    required statusCode,
  });

  Tft_RequestedMatches.blank(){
    allMatches = <Tft_MatchDto>[];
    normalMatchDatas = <Tft_MatchDto>[];
    rankMatchDatas = <Tft_MatchDto>[];
    turboMatchDatas = <Tft_MatchDto>[];
    doubleMatchDatas = <Tft_MatchDto>[];
    statusCode = 0;
  }

  Tft_RequestedMatches.status(int status){
    allMatches = <Tft_MatchDto>[];
    normalMatchDatas = <Tft_MatchDto>[];
    rankMatchDatas = <Tft_MatchDto>[];
    turboMatchDatas = <Tft_MatchDto>[];
    doubleMatchDatas = <Tft_MatchDto>[];
    statusCode = status;
  }

  static Future<Tft_RequestedMatches> getData(String puuid_ ,int num_)async{
    late Tft_MatchListDto matchData;
    List<Tft_MatchDto> _allMatches = <Tft_MatchDto>[];
    List<Tft_MatchDto> _normalMatchDatas = <Tft_MatchDto>[];
    List<Tft_MatchDto> _rankMatchDatas = <Tft_MatchDto>[];
    List<Tft_MatchDto> _turboMatchDatas = <Tft_MatchDto>[];
    List<Tft_MatchDto> _doubleMatchDatas = <Tft_MatchDto>[];
    int statusCode = 200;

    matchData = await Tft_DataGetter.getMatchDtos(puuid_, num_);

    if(matchData.statusCode != 200)
      return Tft_RequestedMatches.status(matchData.statusCode);

    _allMatches = matchData.matches;

    _allMatches.forEach((element) {
      if(element.statusCode == 200){
        switch(element.matchinfoDto.queueId){
          case 1090:
            _normalMatchDatas.add(element);
            break ;

          case 1100:
            _rankMatchDatas.add(element);
            break ;

          case 1130:
            _turboMatchDatas.add(element);
            break ;
          case 1150:
            _doubleMatchDatas.add(element);
            break ;

          default :
            break ;
        }
      }
      else{
        statusCode = element.statusCode;
      }
    });

    return Tft_RequestedMatches(
        allMatches: _allMatches, 
        normalMatchDatas: _normalMatchDatas,
        rankMatchDatas: _rankMatchDatas, 
        turboMatchDatas: _turboMatchDatas,
        doubleMatchDatas: _doubleMatchDatas,
        statusCode: statusCode,
    );
  }

}