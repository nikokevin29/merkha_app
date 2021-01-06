part of 'pages.dart';

class MainTab extends StatefulWidget {
  @override
  _MainTabState createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  final List<String> images = [
    'https://images.unsplash.com/photo-1586882829491-b81178aa622e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586871608370-4adee64d1794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2862&q=80',
    'https://images.unsplash.com/photo-1586901533048-0e856dff2c0d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586902279476-3244d8d18285?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586943101559-4cdcf86a6f87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1556&q=80',
    'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              children: [
                Container(
                  //note: Greetings
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    YonoGreetings.showGreetings() +
                        " " +
                        (context.watch<UserCubit>().state as UserLoaded)
                            .user
                            .first_name, //First Name
                    style: blackTextFont.copyWith(fontSize: 24, fontWeight: FontWeight.w400),
                    maxLines: 1,
                    overflow: TextOverflow.clip
                  ),
                ),
                //here
                Container(
                  child: Column(
                    children: [
                      //note : Search Box
                      SizedBox(
                        height: 15,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(20.0),
                        elevation: 20,
                        child: TextFormField(
                          controller: null,
                          autofocus: false,
                          style: TextStyle(fontSize: 16.0, color: Color(0xFFbdc6cf)),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.search),
                            hintText: 'What are you looking for?',
                            contentPadding:
                                const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 14.0),
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
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      //Carousel
                      CarouselSlider.builder(
                        itemCount: 7,
                        options: CarouselOptions(
                          height: 200.0,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          enlargeCenterPage: true,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            child: Center(
                                child:
                                    Image.network(images[index], fit: BoxFit.cover, width: 1200)),
                          );
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        height: 100,
                        child:
                            BlocBuilder<UserInterestCubit, UserInterestState>(builder: (_, state) {
                          if (state is UserInterestLoaded) {
                            List<UserInterest> interest = state.userInterest;
                            return ListView.builder(
                                itemBuilder: (_, index) => Container(
                                    margin: EdgeInsets.only(
                                        left: (index == 0) ? defaultMargin : 0,
                                        right: (index == interest.length - 1) ? defaultMargin : 16),
                                    child: Wrap(children: [
                                      InterestCard(
                                        interest[index],
                                        onTap: () {
                                          // context
                                          //     .bloc<PageBloc>()
                                          //     .add(GoToMovieDetailPage(interest[index]));
                                          Get.to(CategoryPage(
                                            userInterest: interest[index],
                                          ));
                                        },
                                      ),
                                    ])),
                                itemCount: interest.length,
                                scrollDirection: Axis.horizontal);
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
