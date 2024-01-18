import 'package:english_card_app/pages/home_page.dart';
import 'package:english_card_app/values/app_assets.dart';
import 'package:english_card_app/values/app_colors.dart';
import 'package:english_card_app/values/app_styles.dart';
import 'package:flutter/material.dart';
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor, // mau nen
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16), // cach le 16
        child: Column(
          children: [
            Expanded(child:Container(
              alignment: Alignment.centerLeft,// dua UI ve ben trai
              child: Text("Welcom to",style: AppStyles.h3,), // font duoc dinh nghia o class san
            )),
            Expanded(child:Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // mở rộng theo chiều dọc của trục chéo để đảm bảo chúng có cùng chiều cao. cho 2 chu co kt  o nhu nhau
                children: [
                  Text("English", style: AppStyles.h2.copyWith(color: AppColors.blackGrey, fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.only(right: 8), // cho chu lai gan ben trai 8
                    child: Text("Qoutes", style: AppStyles.h4.copyWith(height: 0.5) // cho chu qoutes len tren 0.5
                      , textAlign: TextAlign.right,),
                  ) // dua chu qoutes sang ben phai
                ],
              ),
            )),
            Expanded(child: Padding(
              padding: const EdgeInsets.only(bottom: 72),
              child: RawMaterialButton(
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomePage()), (route) => false); // tao nut chuyen tranag khi chuyenn xong khonng quay lai duoc
                },
                shape: const CircleBorder(), // chinh nut thanh hinh tron
                fillColor: AppColors.lighBlue, // them mau cho nut
                child: Image.asset(AppAssets.rightArrow), // them anh  chonut
              ),
            ))
          ],
        ),
      ),
    );
  }
}
