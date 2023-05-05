import 'package:RadioWave/models/radiom.dart';
import 'package:RadioWave/screen/loginPage.dart';
import 'package:RadioWave/widgets/radioGrid.dart';
import 'package:RadioWave/widgets/radioCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:RadioWave/providers/radioProvider.dart';
import 'package:RadioWave/services/auth.dart';
import 'package:RadioWave/style/app_style.dart';

class RadioScreen extends StatefulWidget {
  const RadioScreen({Key? key}) : super(key: key);

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  List<RadioCard> myRadioCards = [];
  List<RadioCard> filtredRadioCards = [];
  //List<String> radioTitles = [];

  @override
  void initState() {
    super.initState();
    _loadRadios();
  }

  setcards(List<RadioM> radios) {
    for (int i = 0; i < radios.length; i++) {
      myRadioCards.add(new RadioCard(radioData: radios[i]));
      //radioTitles.add(radios[i].desc);
    }

    filtredRadioCards = myRadioCards.toList();
  }

  Future<void> _loadRadios() async {
    final provider = Provider.of<RadioProvider>(context, listen: false);
    await provider.getAllRadio();

    await setcards(provider.radioMM);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int newPosition = 0;
    //myRadioCards.forEach((card) {});

    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Center(child: Text("Sign out ?")),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            child: Text("No"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          ElevatedButton(
                            child: Text("Yes"),
                            onPressed: () async {
                              await AuthService().signOut();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                  (route) => false);
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            }

            /* (() async {
              await AuthService().signOut();
              Navigator.pop(context);
            }) */
            ,
            icon: Icon(Icons.logout)),
        title: Row(
          children: [
            SizedBox(width: 30),
            Image.asset(
              'assets/utilities/RadioWaveLogo.png',
              height: 30,
            ),
            SizedBox(width: 10),
            Text("RadioWave"),
          ],
        ),
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
                          Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 40.0,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: 'Search',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 25.0)),
                              onChanged: ((text) => {
                                    if (text == null ||
                                        text.isEmpty ||
                                        text.length == 0)
                                      {
                                        filtredRadioCards =
                                            myRadioCards.toList(),
                                      }
                                    else
                                      {
                                        filtredRadioCards =
                                            myRadioCards.toList(),
                                        filtredRadioCards = filtredRadioCards
                                            .where((radio) => radio
                                                .radioData.tagline
                                                .startsWith(text))
                                            .toList()
                                      },
                                    setState(() {})
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  SizedBox(width: 8),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text(
                "Radio Stations",
                style: GoogleFonts.roboto(
                  color: AppStyle.bgColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: Column(children: [
                myRadioCards.isEmpty
                    ? Container(
                        child: Text(
                        "empty",
                        style: TextStyle(color: AppStyle.mainColor),
                      ))
                    : Expanded(child: Container(
                        child: Consumer<RadioProvider>(
                          builder: (context, provider, _) {
                            print("isLoading?: ${provider.isLoading}");
                            if (provider.isLoading) {
                              print("yeahh");
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return Center(
                                child: filtredRadioCards.isEmpty
                                    ? Center(
                                        child: Text(
                                        "Empty radio stations list",
                                        style: AppStyle.inf,
                                      ))
                                    : RadioGrid(myradios: filtredRadioCards),
                              );
                            }
                          },
                        ),
                      )),
              ]),
            ),
            Container(
                height: 50.0,
                decoration: BoxDecoration(color: Colors.transparent),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [],
                ))
          ],
        ),
      ),
    );
  }
}
