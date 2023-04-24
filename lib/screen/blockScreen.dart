import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:the_notebook/models/blockModel.dart';
import 'package:the_notebook/providers/blockProvider.dart';
import 'package:the_notebook/style/app_style.dart';
import 'package:the_notebook/widgets/blocks/blockGrid.dart';
import 'package:the_notebook/widgets/blocks/block_card.dart';

class blockScreen extends StatefulWidget {
  const blockScreen({Key? key}) : super(key: key);

  @override
  State<blockScreen> createState() => _blockScreenState();
}

class _blockScreenState extends State<blockScreen> {
  List<blockCard> myBlockCards = [];
  List<blockCard> filtredBlockCards = [];

  @override
  void initState() {
    super.initState();
    _loadBlocks();
  }

  setcards(List<BlockModel> blocks) {
    for (int i = 0; i < blocks.length; i++) {
      myBlockCards.add(new blockCard(/*onTap: onTap,*/ blockData: blocks[i]));
    }

    filtredBlockCards = myBlockCards.toList();

    print("....**yoyoyoyoyoy**........");
    print(myBlockCards.length);
    print("....**yoyoyoyoyoy**........");
  }

  Future<void> _loadBlocks() async {
    final provider = Provider.of<blockProvider>(context, listen: false);
    await provider.getAllDocuments();

    print("....****........");
    print(provider.blocks.length);
    await setcards(provider.blocks);

    print(myBlockCards.length);
    print("....**yiyiyiyiyiy**........");
    print(myBlockCards);
    print("....**yiyiyiyiyiy**........");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //int newPosition = 0;
    print("a33333333333333333");
    print(myBlockCards);
    print(myBlockCards.isEmpty);
    print(myBlockCards.length);
    myBlockCards.forEach((card) {
      print(card.blockData.title);
    });

    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("FireNotes"),
        centerTitle: true,
        backgroundColor: AppStyle.accentColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(right: 10.0, left: 5.0),
              height: kToolbarHeight,
              decoration: BoxDecoration(
                  color: AppStyle.bgColor,
                  borderRadius: BorderRadius.circular(25)),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: AppStyle.bgColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          //SizedBox(width: 8),
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search',
                                border: InputBorder.none,
                              ),
                              onChanged: ((text) => {
                                    if (text == null ||
                                        text.isEmpty ||
                                        text.length == 0)
                                      {
                                        filtredBlockCards =
                                            myBlockCards.toList(),
                                      }
                                    else
                                      {
                                        filtredBlockCards =
                                            myBlockCards.toList(),
                                        filtredBlockCards = filtredBlockCards
                                            .where((block) => block
                                                .blockData.title
                                                .startsWith(text))
                                            .toList()
                                      },
                                    print("filtred list length"),
                                    print(filtredBlockCards.length),
                                    print("\n"),
                                    setState(() {})
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50'),
                  ),
                  SizedBox(width: 8),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text(
                "blockNotes",
                style: GoogleFonts.roboto(
                  color: AppStyle.bgColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: Column(children: [
                myBlockCards.isEmpty
                    ? Container(
                        child: Text(
                        "empty",
                        style: TextStyle(color: Colors.white),
                      ))
                    : Expanded(
                        child: Container(
                            child: blockGrid(myblocks: filtredBlockCards))),
              ]),
            ),
            Container(
                height: 50.0,
                decoration: BoxDecoration(color: Colors.transparent),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 20.0,
                    ),
                    IconButton(
                      icon: Image.asset('assets/utilities/add.png'),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Image.asset(
                        'assets/utilities/calendar.png',
                        width: 80.0,
                        height: 80.0,
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                  ],
                ))
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
