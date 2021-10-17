import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediumreplica/Shared%20Prefrences/theme_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:zefyrka/zefyrka.dart';

class WrtieArticleScreen extends StatefulWidget {
  const WrtieArticleScreen({Key? key}) : super(key: key);

  @override
  _WrtieArticleScreenState createState() => _WrtieArticleScreenState();
}

class _WrtieArticleScreenState extends State<WrtieArticleScreen> {
  TextEditingController title = TextEditingController();

  TextEditingController tag1 = TextEditingController();
  TextEditingController tag2 = TextEditingController();
  TextEditingController tag3 = TextEditingController();
  TextEditingController tag4 = TextEditingController();
  TextEditingController tag5 = TextEditingController();

  final auth = FirebaseAuth.instance;
  User? currUser = FirebaseAuth.instance.currentUser;

  ZefyrController controller = ZefyrController();

  FocusNode fNode = FocusNode();

  final FirebaseStorage fstorage = FirebaseStorage.instance;
  late UploadTask uploadTask;

  File? img;
  String? url;

  Future<dynamic> getPermission() async {
    if (await Permission.storage.status.isDenied ||
        await Permission.photos.status.isDenied) {
      var storageStatus = Platform.isAndroid
          ? await Permission.storage.request()
          : await Permission.photos.request();
      if (storageStatus.isGranted) {
        getNewDp();
      }
    } else {
      getNewDp();
    }
  }

  Future<dynamic> getNewDp() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        img = File(image.path);
        uploadFile(img!);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fNode = FocusNode();

    loadDocument().then((doc) {
      setState(() {
        controller = ZefyrController(doc);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var theme = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              if (title.text.isNotEmpty && img != null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        title: Text('Add upto 5 tags'),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              width: size.width * 0.1,
                              child: TextField(
                                controller: tag1,
                                decoration: InputDecoration(hintText: 'Tag1'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              width: size.width * 0.1,
                              child: TextField(
                                controller: tag2,
                                decoration: InputDecoration(hintText: 'Tag2'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              width: size.width * 0.1,
                              child: TextField(
                                controller: tag3,
                                decoration: InputDecoration(hintText: 'Tag3'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              width: size.width * 0.1,
                              child: TextField(
                                controller: tag4,
                                decoration: InputDecoration(hintText: 'Tag4'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              width: size.width * 0.1,
                              child: TextField(
                                controller: tag5,
                                decoration: InputDecoration(hintText: 'Tag5'),
                              ),
                            ),
                          ),
                          SimpleDialogOption(
                            onPressed: () async {
                              await saveDocument(context);

                              await saveTags(context);
                              Navigator.pop(context);

                              Navigator.pop(context);
                            },
                            child: Text(
                              'Done',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              } else {
                if (title.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Add Title to your Article')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Add image to your Article')));
                }
              }
            },
            child: Text(
              'Publish',
              style: TextStyle(color: Colors.blue),
            ),
          )
        ],
        backgroundColor: theme.getTheme().backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: theme.getTheme().brightness == Brightness.dark
                      ? theme.getTheme().backgroundColor
                      : Colors.grey[350],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    controller: title,
                    maxLines: 2,
                    style: TextStyle(
                      color: theme.getTheme().brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: theme.getTheme().brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Add Title of Article here.",
                      hintStyle: TextStyle(
                        color: theme.getTheme().brightness == Brightness.dark
                            ? Colors.white54
                            : Colors.black54,
                      ),
                    ),
                    onChanged: (text) async {
                      setState(() {
                        // searchKey = text.substring(0, 1).toUpperCase() +
                        //     text.substring(1).toLowerCase();
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: InkWell(
                  onTap: () {
                    getPermission();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: img == null
                          ? Center(
                              child: Text(
                              'Add image to your article',
                              style: TextStyle(
                                color: theme.getTheme().brightness ==
                                        Brightness.dark
                                    ? Colors.white54
                                    : Colors.black54,
                              ),
                            ))
                          : Image.file(img!, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              Container(
                // height: size.height * 0.5,
                child: ZefyrEditor(
                  controller: controller,
                  focusNode: fNode,
                  readOnly: false,
                  // embedBuilder: ZefyrEditorEmbedBuilder(widget.filesystemRepo),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: theme.getTheme().brightness == Brightness.dark
            ? theme.getTheme().bottomAppBarColor
            : Colors.grey[300],
        child: ZefyrToolbar.basic(
          hideStrikeThrough: true,
          controller: controller,
        ),
      ),
    );
  }

  Future<void> saveDocument(BuildContext context) async {
    final contents = jsonEncode(controller.document);
    if (title.text.isNotEmpty && contents.trim().isNotEmpty && img != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc('${currUser!.uid}')
          .collection("Articles")
          .add({
        'article': contents,
        'title': title.text,
        'tags': FieldValue.arrayUnion(
            [tag1.text, tag2.text, tag3.text, tag4.text, tag5.text]),
        'likes': 0,
        'img': url,
        'time': DateFormat("MM-d-yyyy hh:mm a").format(DateTime.now()),
        'uid': '${currUser!.uid}',
        'author': '${currUser!.displayName}',
        'dp': '${currUser!.photoURL}',
      });

      // });
    } else {
      if (title.text.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Add Title to your Article')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Add something to your Article')));
      }
    }
  }

  Future<void> saveTags(BuildContext context) async {
    final contents = jsonEncode(controller.document);

    List<dynamic> tagsText = [];

    if (tag1.text.length > 0) {
      tagsText.add(tag1);
    }
    if (tag2.text.length > 0) {
      tagsText.add(tag2);
    }
    if (tag3.text.length > 0) {
      tagsText.add(tag3);
    }
    if (tag4.text.length > 0) {
      tagsText.add(tag4);
    }
    if (tag5.text.length > 0) {
      tagsText.add(tag5);
    }

    for (var i = 0; i < tagsText.length; i++) {
      print(tagsText[i]);
      await FirebaseFirestore.instance
          .collection('tags')
          .doc(tagsText[i].text)
          .set({'tag': tagsText[i].text});

      await FirebaseFirestore.instance
          .collection('tags')
          .doc(tagsText[i].text)
          .collection("Articles")
          .add({
        'article': contents,
        'title': title.text,
        'likes': 0,
        'img': url,
        'time': DateFormat("MM-d-yyyy hh:mm a").format(DateTime.now()),
        'uid': '${currUser!.uid}',
        'author': '${currUser!.displayName}',
        'dp': '${currUser!.photoURL}',
      });
    }
  }

  Future loadDocument() async {
    final file = File(Directory.systemTemp.path + "/quick_start.json");

    if (await file.exists()) {
      final contents = await file.readAsString();
      return NotusDocument.fromJson(jsonDecode(contents));
    }
    // final Delta delta = Delta().insert("Zefyr Quick Start\n");
    // return NotusDocument.fromDelta(delta);
  }

  Future<String?> uploadFile(File image) async {
    String downloadURL;
    String filePath = "article/${img!.path}";
    setState(() {
      uploadTask = fstorage.ref().child(filePath).putFile(image);
    });
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    downloadURL = imageUrl.toString();

    uploadToFirebase(downloadURL);
  }

  Future uploadToFirebase(downloadURL) async {
    final CollectionReference users = FirebaseFirestore.instance
        .collection('users')
        .doc('${currUser!.uid}')
        .collection("Profile");
    final String uid = auth.currentUser!.uid;

    setState(() {
      url = downloadURL;
    });

    // await users.doc('${currUser!.uid}').update({
    //   'dp': url,
    // });
    final result = await users.doc(uid).get();

    // FirebaseAuth.instance.currentUser?.updatePhotoURL(url);
    print('$img');
  }
}
