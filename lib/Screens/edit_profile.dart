import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mediumreplica/Shared%20Prefrences/theme_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  TextEditingController bio = TextEditingController();

  final FirebaseStorage fstorage = FirebaseStorage.instance;
  late UploadTask uploadTask;

  final auth = FirebaseAuth.instance;
  String? userId = FirebaseAuth.instance.currentUser!.uid;
  String? userName = FirebaseAuth.instance.currentUser?.displayName;
  String? dp = FirebaseAuth.instance.currentUser?.photoURL;

  File? dpNew;

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
        dpNew = File(image.path);
        uploadFile(dpNew!);
      });
    }

    // Image.file(dpNew!, fit: BoxFit.cover);
  }

  @override
  void initState() {
    super.initState();
    String userBio = '';
    setState(() {
      FirebaseFirestore.instance
          .collection('users')
          .doc('$userId')
          .collection("Profile")
          .doc('$userId')
          .get()
          .then((DocumentSnapshot document) {
        setState(() {
          bio.text = document['bio'];
          print(userBio);
        });
        return userBio;
      });

      name.value = TextEditingValue(
        text: userName!,
        selection: TextSelection.fromPosition(
          TextPosition(offset: userName!.length),
        ),
      );

      bio.value = TextEditingValue(
        text: userBio,
        selection: TextSelection.fromPosition(
          TextPosition(offset: userBio.length),
        ),
      );

      userBio = bio.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var theme = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      backgroundColor: theme.getTheme().brightness == Brightness.dark
          ? Theme.of(context).backgroundColor
          : Colors.grey[100],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Edit your Profile'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  FirebaseAuth.instance.currentUser
                      ?.updateDisplayName(name.text);

                  if (dpNew?.path == null) {
                  } else {
                    FirebaseAuth.instance.currentUser?.updatePhotoURL('$dp');
                  }

                  FirebaseFirestore.instance
                      .collection('users')
                      .doc('$userId')
                      .collection("Profile")
                      .doc('$userId')
                      .update({
                    'name': name.text,
                    'bio': bio.text,
                  });
                });
                Navigator.pop(context);
              },
              icon: Icon(Icons.done)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: size.height * 0.1,
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage('$dp'), fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                GestureDetector(
                  onTap: () {
                    getPermission();
                  },
                  child: Container(
                    child: Text(
                      'Edit Profile Picture',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: size.height * 0.1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: name,
                        style: TextStyle(
                          color: theme.getTheme().brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor:
                            theme.getTheme().brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: TextStyle(
                            color:
                                theme.getTheme().brightness == Brightness.dark
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
                  Container(
                    height: size.height * 0.1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: bio,
                        maxLines: 3,
                        style: TextStyle(
                          color: theme.getTheme().brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                        keyboardType: TextInputType.multiline,
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor:
                            theme.getTheme().brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                        decoration: InputDecoration(
                          hintText: "Enter a Short Bio",
                          hintStyle: TextStyle(
                            color:
                                theme.getTheme().brightness == Brightness.dark
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> uploadFile(File image) async {
    String downloadURL;
    String filePath = "images/${auth.currentUser!.uid}";
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
        .doc('$userId')
        .collection("Profile");
    final String uid = auth.currentUser!.uid;

    String url = downloadURL;
    await users.doc('$userId').update({
      'dp': url,
    });
    final result = await users.doc(uid).get();
    setState(() {
      dp = url;
    });

    FirebaseAuth.instance.currentUser?.updatePhotoURL(url);
    print('$dp');
  }
}
