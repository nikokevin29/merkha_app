import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_greetings/flutter_greetings.dart';
import 'package:merkha_app/shared/shared.dart';

class MainTab extends StatefulWidget {
  @override
  _MainTabState createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              //note: Image
              Container(
                height: MediaQuery.of(context).size.height * 0.21,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/example1.png"),
                  ),
                ),
              ),
              //note: Greetings
              Container(
                margin: EdgeInsets.only(top: 50),
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 2 * defaultMargin,
                  child: Row(
                    children: [
                      Text(
                        YonoGreetings.showGreetings() + " ",
                        style: blackTextFont.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                      Text(
                        "Owen",
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: blackTextFont.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.11,
            ),
            child: ListView(
              padding:
                  EdgeInsets.only(left: defaultMargin, right: defaultMargin),
              children: [
                //note : Search Box
                TextField(
                  controller: null,
                  autofocus: false,
                  style: TextStyle(fontSize: 16.0, color: Color(0xFFbdc6cf)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search),
                    hintText: 'What are you looking for?',
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 14.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 150.0,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 2),
                  ),
                  items: [1, 2, 3, 4, 5].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 1.0),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Center(
                            child: Text(
                              'text $i',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
