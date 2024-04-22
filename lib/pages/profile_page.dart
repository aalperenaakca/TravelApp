import 'package:flutter/material.dart';
import 'package:gezi/pages/edit_profile_page.dart';
import 'package:gezi/pages/main_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void goForw() async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const EditProfilePage()));
    setState(() {});
  }

  @override
  void initState() {
    Navigator.pop(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: Colors.orange[500],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, right: 280),
                    child: SizedBox(
                      height: 100,
                      width: 1000,
                      child: Image.asset('assets/images/anon-profile.jpg'),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(userName),
                    Text(userLastName),
                    Text(userCity),
                    Text(userBorn),
                  ],
                )
              ],
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(60),
                  ),
                ),
                backgroundColor: Colors.orange[500],
              ),
              label: const Text(
                'Profili düzenle',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              onPressed: () {
                goForw();
              },
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }
}
