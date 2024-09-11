import 'package:flutter/material.dart';
import 'package:latest_news_app/view/detail_view.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsContainer extends StatelessWidget {
  String imgUrl;
  String newsHead;
  String newsDes;
  String newsUrl;
  String newsCnt;
  NewsContainer(
      {super.key,
      required this.imgUrl,
      required this.newsDes,
      required this.newsCnt,
      required this.newsHead,
      required this.newsUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                placeholder:
                    "assets/images/latest_news_logo.png",
                image: imgUrl,
                height: 250,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
                imageErrorBuilder: (context, error, stackTrace) {
                  // Fallback if network image fails
                  return Image.asset(
                    'assets/images/latest_news_logo.png',
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  );
                },
              )),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 10,
            ),
            Text(
              newsHead.length > 90
                  ? "${newsHead.substring(0, 90)}..."
                  : newsHead,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              newsDes,
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              newsCnt != "--"
                  ? (newsCnt.length > 250
                      ? newsCnt.substring(0, 250)
                      : newsCnt.length > 15
                          ? "${newsCnt.substring(0, newsCnt.length - 15)}..."
                          : newsCnt)
                  : newsCnt,
              style: TextStyle(fontSize: 16),
            ),
          ]),
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailViewScreen(newsUrl: newsUrl)));
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 125, 30, 31),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: Text("Read More")),
            ),
          ],
        ),
        Center(
            child: TextButton(
                onPressed: () async {
                  await launchUrl(Uri.parse("https://newsapi.org/"));
                },
                child: Text(
                  "News Provided By NewsAPI.org",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7D1E1F),
                  ),
                  textAlign: TextAlign.center,
                ))),
        SizedBox(
          height: 10,
        ),
      ]),
    );
  }
}
