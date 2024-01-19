import 'dart:math';

import 'package:english_card_app/packages/quote/quote.dart';
import 'package:english_card_app/pages/all_word_page.dart';
import 'package:english_card_app/values/app_assets.dart';
import 'package:english_card_app/values/app_colors.dart';
import 'package:english_card_app/values/app_styles.dart';
import 'package:english_card_app/widgets/app_buttom.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import '../models/english_today.dart';
import '../packages/quote/qoute_model.dart';
import 'control_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // tra ve vi tri hien tai cua the
  PageController _pageController = PageController(); // là một lớp được sử dụng để kiểm soát các trang trong một PageView. PageView
  List<EnglishToday> words = [];
  String quote = Quotes().getRandom().content!;// chu o tren cung
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>(); // 1 key de xa dinh state


  List<int> fixeListRandom({int len  = 1, int max = 120, int min = 1}){ // ham random cac tu tieng anh trong thu vien
    if(len > max || len < min){
      return [];
    }
    List<int> newList = [];
    Random random = Random();
    int count = 1;
    while(count < len){
      int val = random.nextInt(max);
      if(newList.contains(val)) continue;
      else{
        newList.add(val);
        count++;
      }
    }
    return newList;
  }

  getEnglishToday(){
    List<String> newlist = [];
    List<int> rans = fixeListRandom(len: 10, max: nouns.length );
    rans.forEach((element) {
      newlist.add(nouns[element]);
    });
    words = newlist.map((e) => getQuote(e)).toList(); // chuyen ve dang Englishtoday
  }

  EnglishToday getQuote(String noun){ // lay cac tu ra
    Quote? quote = Quotes().getByWord(noun);
    return EnglishToday(
      noun: noun,  quote: quote?.content,id: quote?.id,
    );
  }
  @override
  void initState() {
    getEnglishToday();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // lay kich thuoc man hinh
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.secondColor, // mau nen
      appBar: AppBar(
        backgroundColor: AppColors.secondColor, //mau cua thanh appar
        elevation: 0, //giua thanh appbar co 1 duong gach phan cach, dung cai nay de xoa
        title: Text("English today", style: AppStyles.h4.copyWith(color: AppColors.textColor, fontSize: 36),), // chinh font
        leading: InkWell( // 1 nut  bang icon
          onTap: (){
            _scaffoldKey.currentState?.openDrawer(); // dien key tai day -> cho phep mo drawer len
          },
          child: Image.asset(AppAssets.menu),
        ),
      ),

      body: Container( // phan than
        width: double.infinity, //  set chieu rong full
        child: Column(
          children: [
            Container(
              height: size.height * 1 / 10, // phan chu nay  chiem 1 / 10 man hinh
                padding: EdgeInsets.all(16),
                alignment: Alignment.centerLeft,  // can  trai
                child: Text('"$quote"', style: AppStyles.h5.copyWith(fontSize: 12, color: AppColors.textColor),)),
            Container(
              height: size.height * 2 / 3,
              margin: EdgeInsets.symmetric(horizontal: 24), // dung magen de taokhoang cach cua wedget hien tai voi xung  qunah no
              child: PageView.builder( // 1 view co the vuot qua
                  itemCount:  6, // toi da 5 t// rag
                  controller: _pageController,
                  onPageChanged: (index){
                    setState(() {
                      _currentIndex = index; // khi the thay doi thi thanh o duoi cung thay doi theo
                    });
                  },
                  itemBuilder: (context, index){
                    // tach chu
                    String word = (words[index].noun != null) ? words[index].noun! : '';
                    String firstLetter = word.substring(0, 1);
                    String lastLetter = word.substring(1, word.length);

                    String quoteDefault = "If you’re good at something, never do it for free."; //noi dung
                    String quote = words[index].quote != null ? words[index].quote! : quoteDefault ;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration( // lop dinh nghia cac thuoc tinh trang tri
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    child: Column(// phan than cua man hinh con
                      crossAxisAlignment: CrossAxisAlignment.start, // dua chu sang ben phai
                      children: [
                          Container(child: Image.asset(AppAssets.heart), alignment: Alignment.centerRight,), // set trai tim ve ben phai
                        RichText(
                          maxLines: 1, // gioi han max 1 dong
                          overflow: TextOverflow.ellipsis, // xu ly khi tran chu
                      textAlign: TextAlign.start, // luon dio  vao ben trai
                          text: TextSpan(text: firstLetter, style: TextStyle(
                          fontSize: 89,fontFamily: FontFamily.sen,
                          shadows: [
                            BoxShadow(
                              color: Colors.black38,
                              offset: Offset(3, 6), // tao do bong
                              blurRadius: 6
                            )
                          ]
                        ), children: [TextSpan(text: lastLetter, style: TextStyle(
                            fontSize: 56,fontFamily: FontFamily.sen,
                            shadows: [
                              BoxShadow(
                                  color: Colors.black38,
                                  offset: Offset(3, 6), // tao do bong
                                  blurRadius: 6
                              )
                            ]
                        )),
                        ]),),
                        Padding( //noi dung
                          padding: const EdgeInsets.only(top: 24),
                          child: Text('"$quote"',style: AppStyles.h4.copyWith(letterSpacing: 1, color: AppColors.textColor,
                              overflow: TextOverflow.fade// dãn chu
                          ),),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),

          // goi ham  indencator
        _currentIndex >= 5 // neu nhieu hon 5 goi ham show more
            ? buildShowMore()
            : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                height: size.height * 1 / 11,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  alignment: Alignment.center,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(), // khong  cho vuot
                    itemCount: 5,
                    itemBuilder: (context, index){
                      return buildIndicator(index == _currentIndex, size);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:AppColors.primaryColor,
        onPressed: (){
          setState(() {
            getEnglishToday();
          });
        },
        child: Image.asset(AppAssets.exchange),
      ),
      drawer: Drawer(child: Container( color: AppColors.lighBlue, // thanh menu truot
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 16),
              child: Text("You mind", style: AppStyles.h3.copyWith(color: AppColors.textColor),),
            ),

            // tao 2 nut
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: AppButton(label: "Your control",  onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ControlPage()));
              }),),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: AppButton(label: "Favorites", onTap: (){print("Your=");}),
            ),
          ],
        ), ),), // set mau khi an dau 3 soc ben trai
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: isActive ? size.width * 1 / 5 : 24,
      decoration: BoxDecoration(
          color: isActive ? AppColors.lighBlue : AppColors.lightGrey,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
                color: Colors.black38, offset: Offset(2, 3), blurRadius: 3)
          ]),
    );
  }
  Widget buildShowMore(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      alignment: Alignment.centerLeft,
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        elevation: 4,
        color: AppColors.primaryColor,
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) => AllWordPage(words: this.words,)));
          },
          splashColor:Colors.black38,
          borderRadius: BorderRadius.all(Radius.circular(24)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text("Show more", style: AppStyles.h5,),
          ),
        ),
      ),
    );
  }
}
