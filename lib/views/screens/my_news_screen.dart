import 'package:flutter/material.dart';
import 'package:frontliner/model/news_model.dart';
import 'package:frontliner/service/networking/api_handlers.dart';
import 'package:frontliner/views/screens/news_details_screen.dart';
import 'package:frontliner/views/styles/color.dart';
import 'package:frontliner/views/styles/textstyle.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:nb_utils/nb_utils.dart';

class MyNewsScreen extends StatefulWidget {
  @override
  _MyNewsState createState() => _MyNewsState();
}

class _MyNewsState extends State<MyNewsScreen> {
  bool isLoading = true;
  List<Article> articleList = <Article>[];

  @override
  void initState() {
    super.initState();
    fetchNewsData();
  }

  fetchNewsData() async {
    getNews().then((response) {
      (response["articles"] as List<dynamic>).forEach((element) => articleList.add(Article.fromJson(element)));
      setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Headlines"),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: kAccentColor,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: ListView.builder(
                itemCount: articleList.length,
                itemBuilder: (BuildContext context, int index) {
                  return NewsCard(
                    title: articleList[index].title,
                    imageUrl: articleList[index].urlToImage,
                    description: articleList[index].description,
                  ).onInkTap(() {
                    context.nextPage(NewsDetailsScreen(webViewLink: articleList[index].url,));
                  });
                }),
          ).visible(!isLoading),
          Container(color: kAccentColor.withOpacity(0.5), child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(kSecondaryColor),).center().visible(isLoading)).center(),
        ],
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;

  const NewsCard({this.title, this.imageUrl, this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: CustomTextStyle.headline6),
          Container(height: context.screenHeight * .30, child: Image.network(imageUrl, scale: 3, fit: BoxFit.fitWidth)).py8(),
          Text(description, style: CustomTextStyle.subtitle1, maxLines: 2),
        ],
      ).p(10).pOnly(bottom: 10),
    ).pOnly(bottom: 10);
  }
}
