import 'package:english_card_app/models/english_today.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../values/app_assets.dart';
import '../values/app_colors.dart';
import '../values/app_styles.dart';

class AllWordPage extends StatelessWidget {
  final List<EnglishToday> words;
  const AllWordPage({Key? key, required this.words}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      backgroundColor: AppColors.secondColor, //mau cua thanh appar
      elevation: 0, //giua thanh appbar co 1 duong gach phan cach, dung cai nay de xoa
      title: Text("English today", style: AppStyles.h4.copyWith(color: AppColors.textColor, fontSize: 36),), // chinh font
      leading: InkWell( // 1 nut  bang icon
        onTap: (){
          Navigator.pop(context);
        },
        child: Image.asset(AppAssets.leftArrow),
      ),
    ),
    body: Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: GridView.count(
        crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: words.map((e) => Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Text(e.noun ?? "",
        style:
        AppStyles.h3.copyWith(shadows :[
          BoxShadow(
            color: Colors.black38,
            offset: Offset(3, 6),
            blurRadius: 6,
          )
        ])
          , maxLines: 1, overflow: TextOverflow.fade,),
      )).toList(),),
    ),
    );
  }
}
