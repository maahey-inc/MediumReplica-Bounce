import 'package:flutter/material.dart';
import 'package:mediumreplica/Shared%20Prefrences/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:quill_format/quill_format.dart';
import 'package:zefyrka/zefyrka.dart';

class WrtieArticleScreen extends StatefulWidget {
  const WrtieArticleScreen({Key? key}) : super(key: key);

  @override
  _WrtieArticleScreenState createState() => _WrtieArticleScreenState();
}

class _WrtieArticleScreenState extends State<WrtieArticleScreen> {
  ZefyrController controller = ZefyrController();

  FocusNode fNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final document = loadDocument();
    controller = ZefyrController(document);
    fNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    var theme = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {},
            child: Text('Publish'),
          )
        ],
        backgroundColor: theme.getTheme().backgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: ZefyrEditor(
                  controller: controller,
                  focusNode: fNode,
                  readOnly: false,
                ),
              ),
            ),
            Container(
              color: theme.getTheme().brightness == Brightness.dark
                  ? theme.getTheme().bottomAppBarColor
                  : Colors.grey[300],
              child: ZefyrToolbar.basic(
                hideStrikeThrough: true,
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }

  NotusDocument loadDocument() {
    final Delta delta = Delta()..insert("Zefyr Quick Start\n");
    return NotusDocument.fromDelta(delta);
  }
}
