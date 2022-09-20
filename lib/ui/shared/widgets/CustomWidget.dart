import 'package:flutter/material.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeSvg.dart';

class CommonWidget{



   getItem({current,index,iconPath}){
    return  BottomNavigationBarItem(
      backgroundColor: Colors.white,
      icon: Container(
        decoration: BoxDecoration(
          color: current  !=index ? ColorManager.parent :ColorManager.primaryGreen ,
          borderRadius: BorderRadius.all(
              Radius.circular(6.0) //                 <--- border radius here
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: CustomSvgAssets(
            color: current != index ?ColorManager.lightGrey :ColorManager.white ,
            path: iconPath,
          ),
        ),
      ),
      label: '',
      // backgroundColor: Colors.purple,
    );
  }
}