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

import '../APIs/WydAPI/Models/story_model.dart';
import 'video.dart';


void main() {}

class UserModel {
  UserModel(this.stories, this.userName, this.imageUrl);

  final List<StoryModel> stories;
  final String userName;
  final String imageUrl;
}

class StoryModel {
  StoryModel(this.imageUrl, this.isVideo);

  final String imageUrl;
  final int isVideo;
}

class StoryBar extends StatefulWidget {
  const StoryBar({Key? key}) : super(key: key);

  @override
  State<StoryBar> createState() => _StoryBarState();
}

class _StoryBarState extends State<StoryBar> {
  late List<Story>? _storyModel = null;
  late List<UserModel>? stories = null;

  @override
  void initState() {
    super.initState();
    _getStories();
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

  Container getUserCircle(BuildContext context, UserModel user) {
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
            border: user.userName == "SYM Day" ? Border.all(color: WydColors.yellow, width: 1.5) : null,
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
    List<UserModel> users = [];
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

      users.add(UserModel(entries, topicName,topicImage));
    }
    stories = users;
  }
}

class StoryPage extends StatefulWidget {
  const StoryPage({Key? key, required this.startPage, required this.stories}) : super(key: key);

  final int startPage;
  final stories;

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;
  // Controller for the Video Story
  CachedVideoPlayerController? controller = CachedVideoPlayerController.network("");
  
  double currentVolume = 1;

  @override
  void initState() {
    super.initState();
    indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(
        IndicatorAnimationCommand(resume: true));
  }

  @override
  void dispose() {
    indicatorAnimationController.dispose();
    super.dispose();
  }

  setStoryDuration(int seconds)
  {
    indicatorAnimationController.value = IndicatorAnimationCommand(
      duration: Duration(seconds: seconds)
    );
  }

  late int currentPage = widget.startPage;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: WydColors.green,
      body: DismissiblePage(
        onDismissed: () {
          controller!.pause();
          controller!.dispose();
          Navigator.of(context).pop();
        },
        direction: DismissiblePageDismissDirection.down,
        child: Container(
          margin: EdgeInsets.only(top: WydResources.getResponsiveSmValue(screenSize, screenSize.width * 0.02, screenSize.width * 0.03, screenSize.width * 0.05, screenSize.width * 0.05)),
          child: StoryPageView(
            initialPage: widget.startPage,
            onPageForward: (newPageIndex) => {

            },
            onStoryIndexChanged: (int newStoryIndex, int newPage) async {
              if(controller!.value.isInitialized) 
              {
                controller!.dispose();
                controller = CachedVideoPlayerController.network("");
              }
              if(newPage != -1)
                currentPage = newPage;
                
              if (widget.stories[currentPage].stories[newStoryIndex].isVideo == 1) {
                controller = CachedVideoPlayerController.network("");
                await initialiseVideo(widget.stories[currentPage].stories[newStoryIndex].imageUrl);
              }
              else
              {
                setStoryDuration(10);
                controller = CachedVideoPlayerController.network("");
              }
            },
            onStoryPaused: () => {
              if(controller!.value.isInitialized)
              {
                controller!.pause()
              }
            },
            onStoryUnpaused: () => {
              if(controller!.value.isInitialized)
              {
                controller!.play()
              }
            },
            itemBuilder: (context, pageIndex, storyIndex) {
              final user = widget.stories[pageIndex];
              final story = user.stories[storyIndex];
              return Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      color: Colors.black
                    ),
                  ),
                  story.isVideo == 0
                  ?
                  Positioned.fill(
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: story.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                  :
                  VideoPage(controller: controller!),
                  Positioned(
                    child: Container(
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.black
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 44, left: 8),
                    child: Row(
                      children: [
                        Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(user.imageUrl),
                              fit: BoxFit.cover,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          user.userName,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            gestureItemBuilder: (context, pageIndex, storyIndex) {
              return Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Padding(
                            padding: EdgeInsets.zero,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              color: Colors.white,
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                controller!.dispose();
                                Navigator.pop(context);
                              },
                            ),
                          ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Container(
                            margin: EdgeInsets.only(right:40),
                            child: IconButton(
                              padding: EdgeInsets.only(right: 0),
                              color: Colors.white,
                              icon: currentVolume == 0
                                ? const HeroIcon(HeroIcons.speakerXMark)
                                : const HeroIcon(HeroIcons.speakerWave),
                              onPressed: () {
                                setState(() {
                                  currentVolume == 1
                                    ? controller!.setVolume(0)
                                    : controller!.setVolume(1);
                                  currentVolume == 1 
                                    ? currentVolume = 0 
                                    : currentVolume = 1;
                                });
                              },
                            ),
                          ),
                    ),
                  ),
              ]);
            },
            indicatorAnimationController: indicatorAnimationController,
            indicatorDuration: Duration(seconds: 10),
            pageLength: widget.stories.length,
            storyLength: (int pageIndex) {
              return widget.stories[pageIndex].stories.length;
            },
            onPageLimitReached: () => {
              controller!.dispose(),
              Navigator.pop(context)
            },
          ),
        ),
      ),
    );
  }

  Future<int> initialiseVideo(String url) async
  {
    if(!controller!.value.isInitialized)
    {
      controller = CachedVideoPlayerController.network(url);
      await controller!.initialize().then((value) {
        setState(() {
          controller!.setVolume(currentVolume);
          controller!.play();
        });
        setStoryDuration(controller!.value.duration.inSeconds);
      });
    }

      return controller!.value.duration.inSeconds;
  }
}
