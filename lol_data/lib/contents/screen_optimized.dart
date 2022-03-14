import 'package:flutter/material.dart';
import 'package:lol/contents/liner.dart';

class ScreenOptimized
{
  late final Liner _screenBase;
  late final double value;

  ScreenOptimized({
    required double maxScreen ,
    required double minScreen ,
    required double maxHeight ,
    required double minHeight ,
    required MediaQueryData screen,
    }){
      _screenBase = Liner(minScreen, minHeight, maxScreen, maxHeight);
      double result = 0;
      double h =
          (screen.size.height - screen.padding.top) /screen.size.width ;

      if(h > maxScreen)
        result = maxHeight;
      else if(h > minScreen)
        result = _screenBase.getFunctionValue(h);
      else
        result = minHeight;
      value = result;
    }

  ScreenOptimized.std({
    required double maxHeight ,
    required double minHeight ,
    required MediaQueryData screen,
  }){
    _screenBase = Liner((640/360), minHeight, (734/360), maxHeight);
    double result = 0;
    double h =
        (screen.size.height) / screen.size.width ;

    if(h > (734/360))
      result = maxHeight;
    else if(h > (640/360))
      result = _screenBase.getFunctionValue(h);
    else
      result = minHeight;
    value = result;
  }
}