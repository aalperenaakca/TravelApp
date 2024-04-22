import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:gezi/models/place.dart';
import 'package:gezi/pages/log_in_page.dart';
import 'package:gezi/pages/profile_page.dart';
import 'package:gezi/widgets/chat_widget.dart';
import 'package:gezi/widgets/guide_widget.dart';
import 'package:gezi/widgets/main_widget.dart';
import 'package:gezi/widgets/traveller_widget.dart';

User user = FirebaseAuth.instance.currentUser!;
List<Place> placesList = [];

String userName = "Anonim";
String userLastName = "Anonim";
String userBorn = "Bilinmiyor";
String userCity = "Bilinmiyor";
Map<String, dynamic>? userMap;

CollectionReference users = FirebaseFirestore.instance.collection('users');

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isAnon = true;

  Future getUserData() async {
    try {
      users
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          debugPrint('Document data: ${documentSnapshot.data()}');
          userMap = documentSnapshot.data() as Map<String, dynamic>;
          if (userMap != null) {
            setState(() {
              userName = userMap!['name'];
              userLastName = userMap!['lastname'];
              userBorn = userMap!['born'];
              userCity = userMap!['city'];
              if (userName != "Anonim") {
                isAnon = false;
              }
            });
          }
        } else {
          debugPrint('Document does not exist on the database');
        }
      });
    } catch (e) {
      debugPrint("Error - $e");
      return e;
    }
  }

  Future getPlacesData() async {
    try {
      FirebaseFirestore.instance
          .collection('places')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          placesList.add(Place(owner: doc["owner"], province: doc["province"]));
          debugPrint(doc["owner"]);
        });
      });
    } catch (e) {
      debugPrint("Error - $e");
      return e;
    }
  }

  Future<void> signUserOut() async {
    isAnon = true;
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => const LogInPage()),
        (route) => false);
  }

  @override
  void initState() {
    getUserData();
    getPlacesData();
    super.initState();
  }

  int _selectedIndex = 0;
  void selectPage(int index) {
    if (isAnon && index != 0) {
      showDialog(
        context: context,
        builder: (ctx) {
          return const AlertDialog(
            title: Text(
              'Profil bilgilerinizi tamamlamadan uygulamada gezinemezsiniz',
            ),
          );
        },
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const MainWidget();
    Text titleText = const Text('Selam');

    if (_selectedIndex == 1) {
      activePage = const TravellerWidget();
      titleText = const Text('Gezgin');
    } else if (_selectedIndex == 2) {
      activePage = const GuideWidget();
      titleText = const Text('Rehber');
    } else if (_selectedIndex == 3) {
      activePage = const ChatWidget();
      titleText = const Text('Sohbet');
    }

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => const ProfilePage()));
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.person)),
            IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
          ],
          title: titleText,
          backgroundColor: Colors.orange[500],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          backgroundColor: Colors.orange[500],
          selectedFontSize: 15,
          unselectedFontSize: 15,
          type: BottomNavigationBarType.fixed,
          onTap: selectPage,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: 'Ana',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Gezgin',
              icon: Icon(Icons.backpack),
            ),
            BottomNavigationBarItem(
              label: 'Rehber',
              icon: Icon(Icons.psychology_alt_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Sohbet',
              icon: Icon(Icons.chat),
            ),
          ],
        ),
        body: activePage);
  }
}
