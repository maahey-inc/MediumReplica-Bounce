import 'package:flutter/material.dart';
import 'package:mediumreplica/Screens/articleScreen.dart';

class Article {
  String? logo, author, title, img, article;
  int? like;

  Article(
      {this.logo, this.author, this.title, this.img, this.like, this.article});
}

List<Article> getArticles() {
  return [
    Article(
      img:
          "https://images.unsplash.com/photo-1535295972055-1c762f4483e5?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGdpcmwlMjBpbiUyMGhvb2RpZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
      author: 'Arthur Conan Doyle',
      title: 'Flutter vs React',
      logo:
          'https://www.thedroidsonroids.com/wp-content/uploads/2019/06/flutter_blog-react-vs-flutter.png',
      like: 54,
    ),
    Article(
      img:
          "https://images.unsplash.com/photo-1535295972055-1c762f4483e5?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGdpcmwlMjBpbiUyMGhvb2RpZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
      author: 'Arthur Conan Doyle',
      title: 'Flutter vs React',
      logo:
          'https://www.thedroidsonroids.com/wp-content/uploads/2019/06/flutter_blog-react-vs-flutter.png',
      like: 54,
    ),
    Article(
      img:
          "https://images.unsplash.com/photo-1535295972055-1c762f4483e5?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGdpcmwlMjBpbiUyMGhvb2RpZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
      author: 'Arthur Conan Doyle',
      title: 'Flutter vs React',
      logo:
          'https://www.thedroidsonroids.com/wp-content/uploads/2019/06/flutter_blog-react-vs-flutter.png',
      like: 54,
    ),
    Article(
      img:
          "https://images.unsplash.com/photo-1535295972055-1c762f4483e5?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGdpcmwlMjBpbiUyMGhvb2RpZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
      author: 'Arthur Conan Doyle',
      title: 'Flutter vs React',
      logo:
          'https://www.thedroidsonroids.com/wp-content/uploads/2019/06/flutter_blog-react-vs-flutter.png',
      like: 54,
    ),
  ];
}

class StackArticle extends StatelessWidget {
  final String logo, author, title, img;
  final int like;

  const StackArticle(
      {Key? key,
      required this.logo,
      required this.author,
      required this.title,
      required this.img,
      required this.like})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleScreen(
                      img: img,
                      logo: logo,
                      author: author,
                      title: title,
                      like: like,
                      article:
                          "If you're reading this post, I bet you know or maybe even use VS Code. This fact alone tells us a lot about the VS Code's popularity. Millions of developers around the world from many different fields of software use this editor for their daily work. But why's that?\n\n In this article, I'd like to go over some of the most important reasons behind the VS Code's popularity. We all know that the general answer is '''because it's good''', but I'd like to go deeper than that. To explore what makes a really good code editor and how it's done! I think it's safe to say that VS Code is most popular among web developers. And it's not without a reason. The language that most web developers are accustomed to is - of course - JavaScript. And what's powering VS Code and with what does it integrate best? You guessed it, JavaScript! \n\nOn the inside, the VS Code is built using Electron - a framework for creating desktop apps with JavaScript with the help of Chromium and Node.js. Many web developers using VS Code are aware of and appreciate this fact. Not all do, mainly because of Electron apps notorious high memory usage and low performance, but there are still people who appreciate how meta this is - you write JavaScript in a JavaScript app!\n\nWithout a doubt, one of the biggest advantages of the VS Code is its simplicity. From the first steps to the UI to discovering new functionalities, everything in VS Code feels simple.",
                    )));
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                width: size.width * 0.7,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 4),
                      child: Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(logo), fit: BoxFit.fill),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              author,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.thumb_up,
                            size: 18,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              '$like',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(3),
                  image: DecorationImage(
                    image: NetworkImage(img),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
