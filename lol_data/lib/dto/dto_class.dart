
import 'package:flutter/material.dart';

class RiotDto
{
  int statusCode = 0;
}

// Tft Data Class

class Tft_UnitInfoDto extends RiotDto
{
  String character_id = "null";
  String name = "null";
  int rarity = 0;
  int tier = 0;
  List<int> items = [];
  bool isLoaded = false;

  Tft_UnitInfoDto({
    required this.character_id,
    required this.name,
    //required this.chosen,
    required this.rarity,
    required this.tier,
    required this.items,
    required this.isLoaded,
    required int status,
  }){
    statusCode = status;
  }

  Tft_UnitInfoDto.blank(){
    this.character_id = "null";
    this.name = "null";
    //this.chosen = "null";
    this.rarity = 0;
    this.tier = 0;
    this.items = [];
    this.isLoaded = false;
    statusCode = 0;
  }

  Tft_UnitInfoDto.status(int status){
    this.character_id = "null";
    this.name = "null";
    //this.chosen = "null";
    this.rarity = 0;
    this.tier = 0;
    this.items = [];
    this.isLoaded = false;
    statusCode = status;
  }
}

class Tft_TraitInfoDto extends RiotDto
{
  String name = "null";
  int numUnits = 0;
  int style = 0;
  int tierCurrent = 0;
  int tierTotal = 0;
  bool isLoaded = false;

  Tft_TraitInfoDto({
    required this.name,
    required this.numUnits,
    required this.style,
    required this.tierCurrent,
    required this.tierTotal,
    required this.isLoaded,
    required int status
  }){
    statusCode = status;
  }

  Tft_TraitInfoDto.blank(){
    name = "null";
    numUnits = 0;
    style = 0;
    tierCurrent = 0;
    tierTotal = 0;
    isLoaded = false;
    statusCode = 0;
  }

  Tft_TraitInfoDto.status(int status){
    name = "null";
    numUnits = 0;
    style = 0;
    tierCurrent = 0;
    tierTotal = 0;
    isLoaded = false;
    statusCode = 0;
    statusCode = status;
  }
}

class Tft_ParticipantDto extends RiotDto
{
  String puuid = "null";
  int level = 0;
  int placement = 0;
  List<Tft_TraitInfoDto> traits = <Tft_TraitInfoDto>[];
  List<Tft_UnitInfoDto> units = <Tft_UnitInfoDto>[];
  bool isLoaded = false;

  Tft_ParticipantDto({
    required this.puuid,
    required this.level,
    required this.placement,
    required this.traits,
    required this.units,
    required this.isLoaded,
    required int status
  }){
    statusCode = status;
  }

  Tft_ParticipantDto.blank(){
    this.puuid = "null";
    this.level = 0;
    this.placement = 0;
    this.traits = <Tft_TraitInfoDto>[];
    this.units = <Tft_UnitInfoDto>[];
    this.isLoaded = false;
    statusCode = 0;
  }

  Tft_ParticipantDto.status(int status){
    this.puuid = "null";
    this.level = 0;
    this.placement = 0;
    this.traits = <Tft_TraitInfoDto>[];
    this.units = <Tft_UnitInfoDto>[];
    this.isLoaded = false;
    statusCode = status;
  }
}

class Tft_MatchInfoDto extends RiotDto
{
  int gameDataTime = 0;
  double gameLength = 0;
  String gameType = "null";
  int queueId = 0;
  bool isLoaded = false;

  Tft_MatchInfoDto({
    required this.gameDataTime,
    required this.gameLength,
    required this.gameType,
    required this.queueId,
    required this.isLoaded,
    required int status,
  }){
    statusCode = status;
  }

  Tft_MatchInfoDto.blank(){
    this.gameDataTime = 0;
    this.gameLength = 0;
    this.gameType = "null";
    this.queueId = 0;
    this.isLoaded = false;
    statusCode = 0;
  }

  Tft_MatchInfoDto.status(int status){
    this.gameDataTime = 0;
    this.gameLength = 0;
    this.gameType = "null";
    this.queueId = 0;
    this.isLoaded = false;
    statusCode = status;
  }

}

class Tft_UserDto extends RiotDto
{
  String puuid = "null";
  String name = "null";
  String id = "null";
  int userLevel = 0;
  int profileIconId = 0;
  bool isLoaded = false;

  Tft_UserDto({
    required this.puuid,
    required this.name,
    required this.id,
    required this.userLevel,
    required this.profileIconId,
    required this.isLoaded,
    required int status
  }){
    statusCode = status;
  }

  Tft_UserDto.blank(){
    this.profileIconId = 0;
    this.name = "null";
    this.id = "null";
    this.puuid = "null";
    this.userLevel = 0;
    this.isLoaded = false;
    statusCode = 0;
  }

  Tft_UserDto.status(int status){
    this.profileIconId = 0;
    this.name = "null";
    this.id = "null";
    this.puuid = "null";
    this.userLevel = 0;
    this.isLoaded = false;
    statusCode = status;
  }


}


class Tft_MatchIdsDto extends RiotDto
{
  List<String> ids = [];

  Tft_MatchIdsDto({
   required this.ids,
   required status,
  }){
    statusCode = status;
  }

  Tft_MatchIdsDto.blank(){
    this.ids = [];
    statusCode = 0;
  }

  Tft_MatchIdsDto.status(int statusCode){
    this.ids = [];
    this.statusCode = statusCode;
  }
}


class Tft_MatchDto extends RiotDto
{
  Tft_MatchInfoDto matchinfoDto = Tft_MatchInfoDto.blank();
  String myPuuid = "null";
  Tft_ParticipantDto myParticipantDto = Tft_ParticipantDto.blank();
  List<Tft_ParticipantDto> participantDtos = <Tft_ParticipantDto>[];
  bool? isLoaded = false;

  Tft_MatchDto.blank(){
    this.matchinfoDto =Tft_MatchInfoDto.blank();
    this.myPuuid ="null";
    this.myParticipantDto = Tft_ParticipantDto.blank();
    this.participantDtos = <Tft_ParticipantDto>[];
    this.isLoaded = false;
    statusCode = 0;
  }

  Tft_MatchDto.status(int status){
    this.matchinfoDto =Tft_MatchInfoDto.blank();
    this.myPuuid ="null";
    this.myParticipantDto = Tft_ParticipantDto.blank();
    this.participantDtos = <Tft_ParticipantDto>[];
    this.isLoaded = false;
    statusCode = status;
  }

  Tft_MatchDto.makeByPuuid(
      Tft_MatchInfoDto infoDto_,
      List<Tft_ParticipantDto> participantDtos_,
      String myPuuid_,
      int status_
  )
  {
    this.matchinfoDto = infoDto_;
    this.participantDtos = participantDtos_;
    this.myPuuid = myPuuid_;
    statusCode = status_;
    for(int i = 0; i< participantDtos_.length; i++){
      if(participantDtos_[i].puuid == myPuuid){
        this.myParticipantDto = participantDtos_[i];
        isLoaded = true;
        return;
      }
    }
    print("Tft_MatchDto : Data Error : There is no matching puuid in the participants list");
    Tft_MatchDto.blank();
    return;
  }

  static List<Tft_MatchDto> makeList(int n){
    List<Tft_MatchDto> tmp = <Tft_MatchDto>[];
    for(int i = 0; i< n; i++)
      tmp.add(Tft_MatchDto.blank());
    return tmp;
  }
}

class Tft_MatchListDto extends RiotDto
{
  List<Tft_MatchDto> matches = <Tft_MatchDto>[];

  Tft_MatchListDto({
    required this.matches,
    required status
  }){
    statusCode = status;
  }

  Tft_MatchListDto.blank();

  Tft_MatchListDto.status(int status){
    statusCode = status;
  }

}

class Tft_LeagueEntryDto extends RiotDto
{
  String leagueId = "null";
  String summonerId = "null";
  String summonerName = "null";
  String queueType = "null";
  String tier = "null";
  String rank = "null";
  int leaguePoints = 0; //초고속 모드 포함 x
  //String? turboTier;
  //int? turboRating;
  int wins = 0;
  int losses = 0;
  bool isLoaded = false;
  //Tft_MiniSeriesDTO? miniSeries; // 초고속 모드 포함 x

  Tft_LeagueEntryDto({
    required this.leagueId,
    required this.summonerId,
    required this.summonerName,
    required this.queueType,
    required this.tier,
    required this.rank,
    //@required this.turboTier,
    //@required this.turboRating,
    required this.leaguePoints,
    required this.wins,
    required this.losses,
    required this.isLoaded,
    required int status,
    //@required this.miniSeries,
  }){
    statusCode = status;
  }

  Tft_LeagueEntryDto.blank(){
    this.leagueId = "null";
    this.summonerId = "null";
    this.summonerName = "null";
    this.queueType = "null";
    this.tier = "null";
    this.rank = "null";
    //this.turboTier = "null";
    //this.turboRating = 0;
    this.leaguePoints = 0;
    this.wins = 0;
    this.losses = 0;
    this.isLoaded = false;
    statusCode = 0;
    //this.miniSeries = Tft_MiniSeriesDTO.blank();
  }

  Tft_LeagueEntryDto.status(int status){
    this.leagueId = "null";
    this.summonerId = "null";
    this.summonerName = "null";
    this.queueType = "null";
    this.tier = "null";
    this.rank = "null";
    //this.turboTier = "null";
    //this.turboRating = 0;
    this.leaguePoints = 0;
    this.wins = 0;
    this.losses = 0;
    this.isLoaded = false;
    statusCode = status;
    //this.miniSeries = Tft_MiniSeriesDTO.blank();
  }


}

class Tft_TurboLeagueEntryDto extends RiotDto
{
  String queueType = "null";
  String ratedTier = "null";
  int ratedRating = 0;
  String summonerId = "null";
  String summonerName = "null";
  int wins = 0;
  int losses = 0;
  bool isLoaded = false;

  Tft_TurboLeagueEntryDto({
    required this.queueType,
    required this.ratedTier,
    required this.ratedRating,
    required this.summonerId,
    required this.summonerName,
    required this.wins,
    required this.losses,
    required this.isLoaded,
    required int status,
  }){
    statusCode = status;
  }

  Tft_TurboLeagueEntryDto.blank(){
    statusCode = 0;
  }

  Tft_TurboLeagueEntryDto.status(int status){
    statusCode = status;
  }

  Tft_TurboLeagueEntryDto.None(){

  }
}

class Tft_MiniSeriesDTO extends RiotDto
{
  String progress = "null";
  int target = 0;
  int wins = 0;
  int losses = 0;

  Tft_MiniSeriesDTO({
    required this.progress,
    required this.target,
    required this.wins,
    required this.losses,
    required int status,
  }){
    statusCode = status;
  }

  Tft_MiniSeriesDTO.blank(){
    this.progress = "null";
    this.target = 0;
    this.wins = 0;
    this.losses = 0;
    statusCode = 0;
  }

  Tft_MiniSeriesDTO.status(int status){
    this.progress = "null";
    this.target = 0;
    this.wins = 0;
    this.losses = 0;
    statusCode = status;
  }
}

// Data Container

// class StatusData<T>
// {
//   // 400	Bad request
//   // 401	Unauthorized
//   // 403	Forbidden
//   // 404	Data not found
//   // 405	Method not allowed
//   // 415	Unsupported media type
//   // 429	Rate limit exceeded
//   // 500	Internal server error
//   // 502	Bad gateway
//   // 503	Service unavailable
//   // 504	Gateway timeout
//
//   int? status = 0;
//   T? value;
//
//
//   StatusData({
//     @required this.status,
//     @required this.value
//   });
// }


