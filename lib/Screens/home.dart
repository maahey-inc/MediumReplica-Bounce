import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mediumreplica/Models/articles.dart';
import 'package:mediumreplica/Screens/articleScreen.dart';
import 'package:mediumreplica/Widgets/bottom_navbar.dart';
import 'package:mediumreplica/Shared%20Prefrences/theme_manager.dart';
import 'package:mediumreplica/Widgets/card.dart';
import 'package:provider/provider.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String themeTest = 'light';

  List<String> tags = [
    'Mobile Apps',
    'iOS',
    'Andoid',
    'macOS',
    'Money',
    'News',
    'Education',
    'Data Science',
    'Art',
    'Science',
  ];

  final List<Widget> getArticles = [
    StackArticle(
      logo:
          "https://images.unsplash.com/photo-1535295972055-1c762f4483e5?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGdpcmwlMjBpbiUyMGhvb2RpZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
      author: 'Arthur Conan Doyle',
      title: 'Flutter vs React',
      img:
          'https://www.thedroidsonroids.com/wp-content/uploads/2019/06/flutter_blog-react-vs-flutter.png',
      like: 54,
    ),
    StackArticle(
      logo:
          "https://images.unsplash.com/photo-1535295972055-1c762f4483e5?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGdpcmwlMjBpbiUyMGhvb2RpZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
      author: 'Arthur Conan Doyle',
      title: 'Flutter vs React',
      img:
          'https://www.thedroidsonroids.com/wp-content/uploads/2019/06/flutter_blog-react-vs-flutter.png',
      like: 54,
    ),
    StackArticle(
      logo:
          "https://images.unsplash.com/photo-1535295972055-1c762f4483e5?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGdpcmwlMjBpbiUyMGhvb2RpZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
      author: 'Arthur Conan Doyle',
      title: 'Flutter vs React',
      img:
          'https://www.thedroidsonroids.com/wp-content/uploads/2019/06/flutter_blog-react-vs-flutter.png',
      like: 54,
    ),
    StackArticle(
      logo:
          "https://images.unsplash.com/photo-1535295972055-1c762f4483e5?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGdpcmwlMjBpbiUyMGhvb2RpZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
      author: 'Arthur Conan Doyle',
      title: 'Flutter vs React',
      img:
          'https://www.thedroidsonroids.com/wp-content/uploads/2019/06/flutter_blog-react-vs-flutter.png',
      like: 54,
    ),
    StackArticle(
      logo:
          "https://images.unsplash.com/photo-1535295972055-1c762f4483e5?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGdpcmwlMjBpbiUyMGhvb2RpZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
      author: 'Arthur Conan Doyle',
      title: 'Flutter vs React',
      img:
          'https://www.thedroidsonroids.com/wp-content/uploads/2019/06/flutter_blog-react-vs-flutter.png',
      like: 54,
    ),
    StackArticle(
      logo:
          "https://images.unsplash.com/photo-1535295972055-1c762f4483e5?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGdpcmwlMjBpbiUyMGhvb2RpZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
      author: 'Arthur Conan Doyle',
      title: 'Flutter vs React',
      img:
          'https://www.thedroidsonroids.com/wp-content/uploads/2019/06/flutter_blog-react-vs-flutter.png',
      like: 54,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeNotifier>(context);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.getTheme().brightness == Brightness.dark
          ? Theme.of(context).backgroundColor
          : Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(8, 0, 0, 8),
                height: size.height * 0.1,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: size.width * 0.9,
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
              ),
              //tags
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  height: size.height * 0.05,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: tags.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black12
                                    : Colors.grey[600],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Center(
                              child: Text(
                                tags[index],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ArticleScreen()));

                        //theme test
                        if (themeTest == 'light') {
                          theme.setDarkMode();
                          print('dark');
                          setState(() {
                            themeTest = 'dark';
                          });
                        } else if (themeTest == 'dark') {
                          theme.setLightMode();
                          print('light');
                          setState(() {
                            themeTest = 'light';
                          });
                        }
                      },
                      child: Text(
                        'TOP STORIES',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    PopupMenuButton(
                      icon: Icon(Icons.keyboard_arrow_down),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            value: 'videos',
                            child: Text('Videos Only'),
                          ),
                          PopupMenuItem(
                            value: 'articles',
                            child: Text('Articles Only'),
                          )
                        ];
                      },
                      onSelected: (String value) =>
                          actionPopUpItemSelected(value),
                    ),
                  ],
                ),
              ),

              //articles list
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ArticleScreen(
                                img:
                                    'https://images.unsplash.com/photo-1587620962725-abab7fe55159?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=2000&fit=max&ixid=eyJhcHBfaWQiOjExNzczfQ',
                                logo:
                                    'https://images.weserv.nl/?url=https://areknawo.com/content/images/2020/06/logo-circle-small.png&w=120&h=120&output=webp',
                                author: 'Arek Nawo',
                                title: 'Why VS Code is so popular?',
                                like: 982,
                                article:
                                    "If you're reading this post, I bet you know or maybe even use VS Code. This fact alone tells us a lot about the VS Code's popularity. Millions of developers around the world from many different fields of software use this editor for their daily work. But why's that?\n\n In this article, I'd like to go over some of the most important reasons behind the VS Code's popularity. We all know that the general answer is '''because it's good''', but I'd like to go deeper than that. To explore what makes a really good code editor and how it's done! I think it's safe to say that VS Code is most popular among web developers. And it's not without a reason. The language that most web developers are accustomed to is - of course - JavaScript. And what's powering VS Code and with what does it integrate best? You guessed it, JavaScript! \n\nOn the inside, the VS Code is built using Electron - a framework for creating desktop apps with JavaScript with the help of Chromium and Node.js. Many web developers using VS Code are aware of and appreciate this fact. Not all do, mainly because of Electron apps notorious high memory usage and low performance, but there are still people who appreciate how meta this is - you write JavaScript in a JavaScript app!\n\nWithout a doubt, one of the biggest advantages of the VS Code is its simplicity. From the first steps to the UI to discovering new functionalities, everything in VS Code feels simple.",
                              )));
                },
                child: MyCard(
                  img:
                      'https://images.unsplash.com/photo-1587620962725-abab7fe55159?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=2000&fit=max&ixid=eyJhcHBfaWQiOjExNzczfQ',
                  logo:
                      'https://images.weserv.nl/?url=https://areknawo.com/content/images/2020/06/logo-circle-small.png&w=120&h=120&output=webp',
                  author: 'Arek Nawo',
                  title: 'Why VS Code is so popular?',
                  like: 982,
                  article:
                      "If you're reading this post, I bet you know or maybe even use VS Code. This fact alone tells us a lot about the VS Code's popularity. Millions of developers around the world from many different fields of software use this editor for their daily work. But why's that? In this article, I'd like to go over some of the most important reasons behind the VS Code's popularity. We all know that the general answer is '''because it's good''', but I'd like to go deeper than that. To explore what makes a really good code editor and how it's done! I think it's safe to say that VS Code is most popular among web developers. And it's not without a reason. The language that most web developers are accustomed to is - of course - JavaScript. And what's powering VS Code and with what does it integrate best? You guessed it, JavaScript! On the inside, the VS Code is built using Electron - a framework for creating desktop apps with JavaScript with the help of Chromium and Node.js. Many web developers using VS Code are aware of and appreciate this fact. Not all do, mainly because of Electron apps notorious high memory usage and low performance, but there are still people who appreciate how meta this is - you write JavaScript in a JavaScript app!",
                ),
              ),

              Container(
                height: size.height * 0.34,
                child: StackedCardCarousel(
                  initialOffset: 10,
                  spaceBetweenItems: 110,
                  items: getArticles,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        foregroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        overlayOpacity: 0.4,
        spacing: 12,
        spaceBetweenChildren: 8,
        children: [
          SpeedDialChild(
            backgroundColor: theme.getTheme().brightness == Brightness.dark
                ? Colors.black87
                : Colors.grey[350],
            child: Icon(Icons.sort),
            label: 'Sort',
          ),
          SpeedDialChild(
              backgroundColor: theme.getTheme().brightness == Brightness.dark
                  ? Colors.black87
                  : Colors.grey[350],
              child: Icon(Icons.refresh),
              label: 'Refresh',
              onTap: () {
                setState(() {
                  // HomeScreen();
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomeScreen()));
                });
              }),
        ],
      ),
    );
  }

  void actionPopUpItemSelected(String choice) {
    if (choice == 'videos') {
      print('Videos');
    } else if (choice == 'articles') {
      print('Articles');
    }
  }
}
