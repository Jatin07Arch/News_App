import 'package:flutter/material.dart';
import 'package:latest_news_app/controller/fetchNews.dart';
import 'package:latest_news_app/model/newsArt.dart';
import 'package:latest_news_app/view/widget/NewsContainer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;

  late NewsArt newsArt;

  GetNews() async {
    newsArt = await FetchNews.fetchNews();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    GetNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Image.asset(
              "assets/images/logo.png",
              height: 70,
              fit: BoxFit.fill,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Color(0xFF7D1E1F),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
      body: PageView.builder(
        controller: PageController(initialPage: 0),
        scrollDirection: Axis.vertical,
        onPageChanged: (value) {
          setState(() {
            isLoading = true;
          });
          GetNews();
        },
        itemBuilder: (context, index) {
          return isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(
                          255, 125, 30, 31), // Custom color for the loader
                    ),
                  ),
                )
              : NewsContainer(
                  imgUrl: newsArt.imgUrl,
                  newsCnt: newsArt.newsCnt,
                  newsHead: newsArt.newsHead,
                  newsDes: newsArt.newsDes,
                  newsUrl: newsArt.newsUrl,
                );
        },
      ),
    );
  }
}
