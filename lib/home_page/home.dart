import 'package:ai_bot/home_page/main_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class myHomePage extends StatefulWidget {
  const myHomePage({super.key});

  @override
  State<myHomePage> createState() => _myHomePageState();
}

class _myHomePageState extends State<myHomePage> {
  bool onTap = true;
  int mySlideIndex = 0;
  @override
  Widget build(BuildContext context) {
    final _pageController = PageController(initialPage: 0);
    final _textController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(50, 49, 49, 1),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-100,
            child: CarouselSlider(
                items: [
                Container(
                  width: double.infinity,
                color: const Color.fromRGBO(50, 49, 49, 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Dynamo',style: GoogleFonts.roboto(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(.8),
                      letterSpacing: 1.6
                    ),
                    ),
                    Text(
                      'Powered by gemini pro',style: GoogleFonts.roboto(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(.8),
                        letterSpacing: 1.4
                    ),
                    ),
                    const SizedBox(height:250,),
                  ],
                ),
              ),
                Container(
                  color: const Color.fromRGBO(50, 49, 49, 1),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Get started',style: GoogleFonts.roboto(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(.8),
                            letterSpacing: 1.5
                        ),
                        ),
                        const SizedBox(height:255,),
                      ],
                    ),
                  ),
                ),
                  Container(
                    color: const Color.fromRGBO(50, 49, 49, 1),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                            child: Text('Hello , ',
                            style: GoogleFonts.roboto(
                              color: Colors.white.withOpacity(.8),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.3
                            ),),
                          ),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width-50,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.8),
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: TextField(
                              controller:_textController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(borderSide: BorderSide.none),
                                hintText: 'What Should we call you?',
                                prefixIcon: const Icon(Icons.supervised_user_circle),
                                suffixIcon: IconButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> mainPage(user: _textController.text.trim(),)
                                  ));
                                },
                                  icon: const Icon(Icons.send_rounded,size: 22,),),
                                hintStyle: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height:255,),
                        ],
                      ),
                    ),
                  ),
            ], options: CarouselOptions(
              height: 800,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              autoPlay: onTap,
                onPageChanged: (index,reason)=>setState(() {
                  onTap = (index==2) ? false : true;
                  mySlideIndex = index;
                }),
              autoPlayInterval: const Duration(seconds: 4),
            ),),
          ),
          AnimatedSmoothIndicator(activeIndex: mySlideIndex,
            count: 3,
            effect: const SwapEffect(
              dotHeight: 12,
              dotWidth: 12
            ),

          ),
        ],

      ),
    );
  }
}
