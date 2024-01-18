import 'package:english_card_app/values/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../values/app_assets.dart';
import '../values/app_styles.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  double sliderValue = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor, //mau cua thanh appar
        elevation: 0, //giua thanh appbar co 1 duong gach phan cach, dung cai nay de xoa
        title: Text("Your control", style: AppStyles.h4.copyWith(color: AppColors.textColor, fontSize: 36),), // chinh font
        leading: InkWell( // 1 nut  bang icon
          onTap: (){
            Navigator.pop(context);
          },
          child: Image.asset(AppAssets.leftArrow),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Spacer(),
            Text('How much a number word at once', style: AppStyles.h4.copyWith(color: AppColors.lightGrey,fontSize: 18),),
            Spacer(),
            Text("${sliderValue.toInt()}", style: AppStyles.h1.copyWith(color: AppColors.primaryColor, fontSize: 150, fontWeight: FontWeight.bold,),),
            Slider(
                value: sliderValue,
                min: 5,
                max: 100,
                divisions: 95,
                activeColor: AppColors.primaryColor,
                inactiveColor: AppColors.primaryColor,
                onChanged: (value) {
                  print(value);
                  setState(() {
                    sliderValue = value;
                  });
                }),
            Container(
                alignment:  Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 32)
                ,child: Text("Size to set ", style: AppStyles.h5.copyWith(color: AppColors.textColor),)),
            Spacer(),
            Spacer(),
          Spacer(),
          ],
        ),
      ),
    );
  }
}
