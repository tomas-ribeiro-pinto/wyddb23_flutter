import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:story_time/story_page_view/story_page_view.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/api_constants.dart';
import 'package:wyddb23_flutter/APIs/WydAPI/api_service.dart';
import 'package:wyddb23_flutter/Components/wyd_resources.dart';


import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wyddb23_flutter/Stories/util/story_bars.dart';
import 'package:wyddb23_flutter/Stories/video.dart';

import '../APIs/WydAPI/Models/story_model.dart';
import 'video.dart';


class TopicModel {
  TopicModel(this.stories, this.topic, this.imageUrl);

  final List<StoryModel> stories;
  final String topic;
  final String imageUrl;
}

class StoryModel {
  StoryModel(this.assetUrl, this.isVideo);

  final String assetUrl;
  final int isVideo;
}

class StoryBar extends StatefulWidget {
  const StoryBar({Key? key}) : super(key: key);

  @override
  State<StoryBar> createState() => _StoryBarState();
}

class _StoryBarState extends State<StoryBar> {
  late List<Story>? _storyModel = null;
  late List<TopicModel> stories = [];

  @override
  void initState() {
    super.initState();
    _getStories();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getStories() async {
    _storyModel = (await WydApiService().getStories());
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
        getStoriesModel();
      }));
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width * 0.8,
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            if(stories != null)...
            {
              for(var user in stories!)...
              {
                getUserCircle(context, user),
              }
            }
          ],
        ),
      ),
    );
  }

  Container getUserCircle(BuildContext context, TopicModel user) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(left: screenSize.width * 0.05),
      child: IconButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenSize.width * 0.2),
          ),
        ),
        onPressed: () {
          HapticFeedback.heavyImpact();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StoryPage(startPage: stories!.indexOf(user), stories: stories)),
          );
        },
        icon: Container(
          height: screenSize.width * 0.16,
          width: screenSize.width * 0.16,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: /* user.topic == "SYM Day" ? */ Border.all(color: WydColors.yellow, width: 1.5) /* : null */,
            borderRadius: BorderRadius.circular(screenSize.width * 0.2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(screenSize.width * 0.2),
              child: CachedNetworkImage(
                imageUrl: user.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  void getStoriesModel() {
    List<TopicModel> users = [];
    for(Story topic in _storyModel!)
    {
      List<StoryModel> entries = [];
      var topicName = topic.title;
      var topicImage = ApiConstants.storage + topic.imageUrl;

      for(StoryElement story in topic.stories)
      {
        entries += [
          StoryModel(ApiConstants.storage + story.contentUrl, story.isVideo)
        ];
      }

      users.add(TopicModel(entries, topicName,topicImage));
    }
    stories = users;
  }
}

class StoryPage extends StatefulWidget {
  StoryPage({Key? key, required this.startPage, required this.stories}) : super(key: key);

  int startPage = 0;
  List<TopicModel> stories;

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  int currentStoryIndex = 0;
  late int currentPageIndex;
  int storyDuration = 10;

  List<Color> colors = [Colors.green, WydColors.red, WydColors.yellow];

  List<Widget> myStories = [];

  late List<TopicModel> stories;

  List<double> percentWatched = [];
  late Timer timer;
  bool pause = false;
  DateTime timestampDown = DateTime(0); 
  DateTime timestampUp = DateTime(0); 

  Offset delta = Offset.zero;

  bool skipForward = false;
  bool skipBackward = false;

  //Video Controller
  CachedVideoPlayerController controller = CachedVideoPlayerController.network("https://epinto.tech/storage/videos/sample.mp4"); // https://epinto.tech/storage/videos/lake.mp4
  double currentVolume = 1;


  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.startPage;
    stories = widget.stories;

    setStory();
  }

  void setStory()
  {
    // Cleaer any leftover bars
    percentWatched.clear();

    // initially, all stories haven't been watched yet
    for (int i = 0; i < stories[currentPageIndex].stories.length; i++) {
      percentWatched.add(0);
    }

    startStory();
  }

  void setOldPage()
  {
    timer.cancel();
    // Cleaer any leftover bars
    percentWatched.clear();

    // only amrk as unseen the last story
    for (int i = 0; i < stories[currentPageIndex].stories.length; i++) {
      if(i < stories[currentPageIndex].stories.length - 1)
        percentWatched.add(1);
      else
        percentWatched.add(0);
    }

    startStory();
  }

  void startStory()
  {
    controller.pause();
    if(stories[currentPageIndex].stories[currentStoryIndex].isVideo == 1)
    {
      var currentIndex = currentStoryIndex;
      controller = CachedVideoPlayerController.network(stories[currentPageIndex].stories[currentStoryIndex].assetUrl);
      controller.initialize().then((value) {
        if(currentStoryIndex == currentIndex)
        {
          controller.play();
          storyDuration = controller.value.duration.inSeconds;
          controller.setVolume(currentVolume);
          _startWatching(storyDuration);
          setState(() {
          });
        }
      });
    }
    else
    {
      controller.dispose();
      controller = CachedVideoPlayerController.network("https://epinto.tech/storage/videos/sample.mp4");
      storyDuration = 10;
      _startWatching(storyDuration);
    }
  }

  void _startWatching(int duration) {
    timer = Timer.periodic(Duration(milliseconds: duration), (timer) {
      setState(() {
        // Pause Story
        if(pause)
        {
          timer.cancel();
        }
        // only add 0.01 as long as it's below 1
        else if (percentWatched[currentStoryIndex] + 0.001 < 1) {
          percentWatched[currentStoryIndex] += 0.001;
        }
        // if adding 0.01 exceeds 1, set percentage to 1 and cancel timer
        else {
          percentWatched[currentStoryIndex] = 1;
          timer.cancel();

          // also go to next story as long as there are more stories to go through
          if (currentStoryIndex < stories[currentPageIndex].stories.length - 1) {
            currentStoryIndex++;

            // restart story timer
            startStory();
          }
          // Navigate to next Topic (Page)
          else if(currentPageIndex < stories.length - 1)
          {
            currentPageIndex++;
            currentStoryIndex = 0;
            setState(() {
              setStory();
            });
          }
          // if we are finishing the last story then return to homepage
          else {
            Navigator.pushNamed(context, "/home");
          }
        }
      });
    });
  }

  void _onClick(TapUpDetails details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;

    // user taps on first half of screen
    if (dx < screenWidth / 2) {
      setState(() {
        // as long as this isnt the first story
        if (currentStoryIndex > 0) {
          // set previous and curent story watched percentage back to 0
          percentWatched[currentStoryIndex - 1] = 0;
          percentWatched[currentStoryIndex] = 0;

          timer.cancel();
          // go to previous story
          currentStoryIndex--;
          startStory();
        }
        // Navigate to next Topic (Page)
        else if(currentPageIndex > 0 && currentStoryIndex == 0)
        {
          currentPageIndex--;
          currentStoryIndex = stories[currentPageIndex].stories.length - 1;
          setState(() {
            setOldPage();
          });
        }
      });
    }
    // user taps on second half of screen
    else {
      setState(() {
        // if there are more stories left
        if (currentStoryIndex < stories[currentPageIndex].stories.length - 1) {
          // finish current story
          percentWatched[currentStoryIndex] = 1;
          timer.cancel();
          // move to next story
          currentStoryIndex++;
          startStory();
        }
        // Navigate to next Topic (Page)
        else if(currentPageIndex < stories.length - 1)
        {
          currentPageIndex++;
          currentStoryIndex = 0;
          setState(() {
            setStory();
          });
        }
        // if user is on the last story, finish this story
        else {
          controller = CachedVideoPlayerController.network("https://epinto.tech/storage/videos/sample.mp4");
          percentWatched[currentStoryIndex] = 1;
        }
      });
    }
  }

  setStoryDuration(int seconds)
  {
    setState(() {
      storyDuration = seconds; 
    });
  }

  Future<void> initialiseVideo(String url) async
  {
    if(!controller.value.isInitialized)
    {
      controller = CachedVideoPlayerController.network(url);
      controller.initialize().then((value) {
        setState(() {
          controller.setVolume(currentVolume);
          controller.play();
          setStoryDuration(controller.value.duration.inSeconds);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    
    return DismissiblePage(
      backgroundColor: WydColors.green,
      onDismissed: () {
        controller.pause();
        timer.cancel();
        Navigator.of(context).pop();
      },
      direction: DismissiblePageDismissDirection.down,
      isFullScreen: true,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Listener(
          onPointerDown: (event) => {
            setState(() => timestampDown = DateTime.now()),
          },
          onPointerUp: (event) => {
            setState(() => timestampUp = DateTime.now()),
          },
          child: GestureDetector(
            onTapUp: (details) => {
              if(timestampUp.difference(timestampDown).inMilliseconds < 500)
              {
                _onClick(details),
              },
              timestampDown = DateTime(0),
              timestampUp = DateTime(0),
            },
            onLongPress: () => {
              setState(() => {
                pause = true,
                if(controller.value.isPlaying)
                  controller.pause()
              }),
            },
            onLongPressUp: () => {
              setState(() => {
                pause = false,
                if(controller.value.isInitialized)
                  controller.play(),
                _startWatching(storyDuration)
              }),
            },
            onHorizontalDragUpdate: (details) {
              delta = details.delta;
            },
            onHorizontalDragEnd:(details) => {
              if((delta.direction < pi/2 && delta.direction > -pi/2))
              {
                if(currentPageIndex != 0)
                {
                  timer.cancel(),
    
                  // Dragging to the right
                  currentPageIndex--,
                  currentStoryIndex = stories[currentPageIndex].stories.length - 1,
                  setState(() {
                    setOldPage();
                    skipBackward = true;
                    Future.delayed(Duration(milliseconds: 500)).then((_) {
                      setState(() {
                        skipBackward = false;
                      });
                    });
                  }),
                }
              }
              else
              {
                if(currentPageIndex < stories.length - 1)
                {
                  timer.cancel(),
    
                  // Dragging to the left
                  currentPageIndex++,
                  currentStoryIndex = 0,
                  setState(() {
                    setStory();
                    skipForward = true;
                    Future.delayed(Duration(milliseconds: 500)).then((_) {
                      setState(() {
                        skipForward = false;
                      });
                    });
                  }),
                }
                else
                {
                  Navigator.pushNamed(context, "/home")
                }
              }
            },
          child: Stack(
            children: [
            // story
            Container(
              child: stories[currentPageIndex].stories[currentStoryIndex].isVideo == 0
              ?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: stories[currentPageIndex].stories[currentStoryIndex].assetUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              )
              :
              VideoPage(controller: controller)),
              Container(
                color: Colors.black,
                height: screenSize.width * 0.35,
                child: Column(
                  children: [
                    // progress bar
                    Padding(
                      padding: EdgeInsets.only(top: screenSize.width * 0.15, left: 8, right: 8),
                      child: MyStoryBars(
                        percentWatched: percentWatched,
                        topicLength: stories[currentPageIndex].stories.length,
                        color: colors[currentPageIndex %3],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: screenSize.width * 0.03, left: 8, right: 8),
                          child: Row(
                            children: [
                              Container(
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(stories[currentPageIndex].imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                stories[currentPageIndex].topic,
                                style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                          Padding(
                            padding: EdgeInsets.only(top: screenSize.width * 0.025, right: 5),
                            child: Row(
                                children: [
                                                                IconButton(
                                  padding: EdgeInsets.only(right: 0),
                                  color: Colors.white,
                                  icon: currentVolume == 0
                                    ? const HeroIcon(HeroIcons.speakerXMark)
                                    : const HeroIcon(HeroIcons.speakerWave),
                                  onPressed: () {
                                    setState(() {
                                      currentVolume == 1
                                        ? controller.setVolume(0)
                                        : controller.setVolume(1);
                                      currentVolume == 1 
                                        ? currentVolume = 0 
                                        : currentVolume = 1;
                                    });
                                  },
                                ),
                                  Padding(
                                    padding: EdgeInsets.zero,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      color: Colors.white,
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        timer.cancel();
                                        controller.dispose();
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                          )
                      ],
                    ),
                  ],
                ),
              ),
              
              showSkipForward(screenSize),
              showSkipBackward(screenSize),
            ],
          ),
        ),
        ),
      ),
    );
  }

  Center showSkipForward(Size screenSize)
  {
    return Center(
      child: AnimatedOpacity(
        opacity: skipForward ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        // The green box must be a child of the AnimatedOpacity widget.
        child: Container(
          height: screenSize.width * 0.2,
          width: screenSize.width * 0.2,
          decoration: BoxDecoration(
            color: WydColors.green,
            borderRadius: BorderRadius.circular(screenSize.width * 0.2)
          ),
          child: HeroIcon(
            HeroIcons.forward,
            style: HeroIconStyle.solid,
            color: Colors.white,
            size: screenSize.width * 0.07,
          ),
        ),
      ),
    );
  }

  Center showSkipBackward(Size screenSize)
  {
    return Center(
      child: AnimatedOpacity(
        opacity: skipBackward ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        // The green box must be a child of the AnimatedOpacity widget.
        child: Container(
          height: screenSize.width * 0.2,
          width: screenSize.width * 0.2,
          decoration: BoxDecoration(
            color: WydColors.green,
            borderRadius: BorderRadius.circular(screenSize.width * 0.2)
          ),
          child: HeroIcon(
            HeroIcons.backward,
            style: HeroIconStyle.solid,
            color: Colors.white,
            size: screenSize.width * 0.07,
          ),
        ),
      ),
    );
  }
}

