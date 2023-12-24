import 'dart:typed_data';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  late YoutubeAPI yotPlayAI;
  late YoutubeAPI yotPlayDataSI;
  late YoutubeAPI yotPlayCoding;
  late YoutubeAPI yotPlayMC;
  late YoutubeAPI yotPlaySOM;
  late YoutubeAPI yotPlayAO;

  late YoutubeAPI ytApiVid;
  late YoutubeAPI ytApiVid2;
  late YoutubeAPI ytApiPlay;

  List<YouTubeVideo> playlists = [];
  List<YouTubeVideo> BroCode = [];
  List<YouTubeVideo> FreeCodeCamp = [];
  List<YouTubeVideo> CodeWithHarry = [];
  List<YouTubeVideo> CodeWithMosh = [];
  List<YouTubeVideo> Simplilearn = [];
  List<YouTubeVideo> ApnaCollege = [];

  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    ytApiVid = YoutubeAPI('AIzaSyDAJolBZlT2a1Tt_5nnDAvqEoI0VxL6Vj4',
        maxResults: 10, type: 'video');

    ytApiVid2 = YoutubeAPI('AIzaSyDAJolBZlT2a1Tt_5nnDAvqEoI0VxL6Vj4',
        maxResults: 10, type: 'video');

    callApi();
  }

  void callApi() async {
    try {
      playlists = await ytApiVid.search("Coding");
      BroCode = await ytApiVid.search("BroCode");
      FreeCodeCamp = await ytApiVid.search("FreeCodeCamp");
      CodeWithHarry = await ytApiVid.search("CodeWithHarry");
      CodeWithMosh = await ytApiVid.search("CodeWithMosh");
      Simplilearn = await ytApiVid.search("Simplilearn");
      ApnaCollege = await ytApiVid.search("ApnaCollege");
      
      setState(() {
        isLoaded = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Padding TopCards(String name, String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.20,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: MaterialButton(
          onPressed: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool IsPlaylist(String url) {
    if (url.contains('list=')) {
      return true;
    } else {
      return false;
    }
  }

  Padding VideoCard(YouTubeVideo video) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      child: MaterialButton(
        onPressed: () {},
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(video.url.toString().replaceAll(
                              'https://www.youtube.com/watch?v=',
                              'https://img.youtube.com/vi/') +
                          '/0.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.width * 0.02,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            video.title,
                            style: TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            video.channelTitle,
                            style: TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015,
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

    
Container ContentCreatorRow(String name, List<YouTubeVideo> youtubeVideos) {
  return Container(
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.13,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: Colors.white,
            ),
            child: MaterialButton(
              onPressed: () {
                print('Navigate to $name\'s YouTube channel');
                //TODO: Navigate to channel
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.amber,
                    backgroundImage: NetworkImage(
                      youtubeVideos.isNotEmpty
                          ? youtubeVideos[0].thumbnail.small.url.toString()
                          : '',
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          for (int i = 1; i < 9; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.13,
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: MaterialButton(
                  enableFeedback: false,
                  onPressed: () {
                    // TODO: Handle video tap
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.13,
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: youtubeVideos.isNotEmpty && i < youtubeVideos.length
                              ? Image.network(
                                  youtubeVideos[i].thumbnail.medium.url.toString(),
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                color: Colors.black,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                      strokeWidth: 2.0,
                                  ),
                                ),
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          color: Colors.black.withOpacity(0.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                youtubeVideos.isNotEmpty && i < youtubeVideos.length
                                    ? youtubeVideos[i].title
                                    : '',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Container(
            height: MediaQuery.of(context).size.height * 0.13,
            width: MediaQuery.of(context).size.width * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  'View More',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
        ],
      ),
    ),
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: CustomRefreshIndicator(
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 2));
              setState(() {
                callApi();
              });
            },
            builder: (BuildContext context, Widget child,
                IndicatorController controller) {
              return AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, _) {
                  return Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      if (!controller.isIdle)
                        Positioned(
                          top: 100.0 * controller.value,
                          child: SizedBox(
                            height: 30.0,
                            width: 30.0,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              value: controller.isLoading
                                  ? null
                                  : controller.value.clamp(1.0, 1.0),
                            ),
                          ),
                        ),
                      Transform.translate(
                        offset: Offset(0.0, 50.0 * controller.value),
                        child: Opacity(
                          opacity: controller.isLoading ? 0.0 : 1.0,
                          child: child,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.settings_outlined),
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Container(
                    child: Image(
                      image: AssetImage('Assets/Images/ImageStudy.png'),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          'Courses',
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Learn from the bests \ncontent creators 📚',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          TopCards('AI', "Assets/Images/Ai.jpg"),
                          TopCards(
                              "Machine Learning", "Assets/Images/Machine.jpg"),
                          TopCards("Data Science", "Assets/Images/dataS.jpg"),
                          TopCards("Coding", "Assets/Images/ProgB.jpg"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          'Popular Courses',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  ContentCreatorRow('BroCode', BroCode),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  ContentCreatorRow('FreeCodeCamp', FreeCodeCamp),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  ContentCreatorRow('CodeWithHarry', CodeWithHarry),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  ContentCreatorRow('CodeWithMosh', CodeWithMosh),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  ContentCreatorRow('Simplilearn', Simplilearn),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  ContentCreatorRow('ApnaCollege', ApnaCollege),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Coding Videos',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black,
                      ),
                      child: isLoaded
                          ? Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: playlists.length,
                                    itemBuilder: (context, index) {
                                      return VideoCard(playlists[index]);
                                    },
                                  ),
                                ),
                              ],
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orange[50],
                    ),
                    child: MaterialButton(
                      onPressed: () {
                      },
                      child: Text(
                        'View More',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
