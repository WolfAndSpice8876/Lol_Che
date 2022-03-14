
import 'package:flutter/cupertino.dart';

int getCompleteItemNum(int num0_ , int num1_){
  int num0 = num0_ <= num1_ ? num0_ : num1_;
  int num1 = num0_ <= num1_ ? num1_ : num0_;

  int result = num0 * 10 + num1;

  switch(result){
    case 58: //연미복 상징
      result = 70;
      break;

    case 18: // 타격대 상징
      result = 71;
      break;

    case 48: // 마법 공학 상징
      result = 72;
      break;

    case 15 :// 밤의 끝자락
      result = 94;
      break;

    case 68 :// 돌연변이 상징
      result = 2190;
      break;

    default :
      break;
  }

  return result;
}