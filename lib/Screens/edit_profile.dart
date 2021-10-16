import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
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

  TextEditingController description = TextEditingController();

  final auth = FirebaseAuth.instance;
  String? userName = FirebaseAuth.instance.currentUser?.displayName;
  String? dp = FirebaseAuth.instance.currentUser?.photoURL;

  File? dpNew;

  bool permission = false;

  Future<dynamic> getPermission() async {
    if (await Permission.storage.status.isDenied ||
        await Permission.photos.status.isDenied) {
      var storageStatus = Platform.isAndroid
          ? await Permission.storage.request()
          : await Permission.photos.request();
      if (storageStatus.isGranted) {
        getNewDp();
      }
    }
  }

  Future<dynamic> getNewDp() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      dpNew = File(image!.path);
    });

    // Image.file(dpNew!, fit: BoxFit.cover);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      name.value = TextEditingValue(
        text: userName!,
        selection: TextSelection.fromPosition(
          TextPosition(offset: userName!.length),
        ),
      );
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
                    // FirebaseAuth.instance.currentUser
                    //     ?.updatePhotoURL('${dpNew!.path.characters}');
                    print('${dpNew!.path.characters}');
                  }
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: size.height * 0.08,
                  height: size.height * 0.08,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    // image: DecorationImage(
                    //      image: NetworkImage('$dp'), fit: BoxFit.fill),
                  ),
                  child: dpNew?.path == null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage('$dp'),
                          radius: 200.0,
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(dpNew!),
                          radius: 200.0,
                        ),
                ),
                GestureDetector(
                  onTap: () {
                    getNewDp();
                  },
                  child: Container(
                    width: size.width * 0.6,
                    child: Text(
                      'Edit Image',
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
                        controller: description,
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
}
