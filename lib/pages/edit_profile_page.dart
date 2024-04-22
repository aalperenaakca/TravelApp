import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:gezi/data/dummy.dart';
import 'package:gezi/pages/main_page.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  DateTime? chosenDate;
  String selectedProvince = provinces[0];
  final _formKey = GlobalKey<FormState>();
  final firstController = TextEditingController();
  final lastController = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> updateUser() {
    User user = FirebaseAuth.instance.currentUser!;
    setState(() {
      userName = firstController.text;
      userLastName = lastController.text;
      userBorn = DateFormat('dd.MM.yyyy').format(chosenDate!);
      userCity = selectedProvince;
    });
    return users
        .doc(user.uid)
        .set({
          "name": firstController.text,
          "lastname": lastController.text,
          "city": selectedProvince,
          "born": DateFormat('dd.MM.yyyy').format(chosenDate!),
        })
        .then((value) => debugPrint("User Updated"))
        .catchError((error) => debugPrint("Failed to add user: $error"));
  }

  void _datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 18, now.month, now.day);
    final pickedDate = await showDatePicker(
      locale: const Locale('tr', 'TR'),
      context: context,
      initialDate: firstDate,
      firstDate: DateTime(now.year - 118),
      lastDate: firstDate,
    );

    setState(() {
      chosenDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profili düzenle'),
        backgroundColor: Colors.orange[500],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: TextFormField(
                    controller: firstController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(60)),
                          borderSide: BorderSide(color: Colors.grey)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                      ),
                      labelText: 'İsim',
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.trim().isEmpty) {
                        return 'İsim boş bırakılamaz';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: lastController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(60)),
                          borderSide: BorderSide(color: Colors.grey)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                      ),
                      labelText: 'Soyisim',
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.trim().isEmpty) {
                        return 'Soyisim boş bırakılamaz';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: DropdownSearch<String>(
                          popupProps: const PopupProps.dialog(
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                              decoration: InputDecoration(
                                hintText: 'Buradan aratabilirsiniz',
                              ),
                            ),
                          ),
                          selectedItem: selectedProvince,
                          items: provinces,
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60)),
                                  borderSide: BorderSide(color: Colors.grey)),
                            ),
                          ),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              selectedProvince = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Icon(Icons.location_city),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: _datePicker,
                          child: Text(
                            chosenDate == null
                                ? 'Doğum tarihinizi girin'
                                : DateFormat('dd.MM.yyyy').format(chosenDate!),
                            style: const TextStyle(fontSize: 16),
                          )),
                      const SizedBox(width: 15),
                      IconButton(
                        onPressed: _datePicker,
                        icon: const Icon(Icons.calendar_month),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(60),
                          ),
                        ),
                        backgroundColor: Colors.orange[500],
                      ), //
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (chosenDate == null) {
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return const AlertDialog(
                                  title: Text(
                                    'Lütfen doğum tarihinizi girdiğinizden emin olun',
                                  ),
                                );
                              },
                            );
                          } else {
                            updateUser();
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: const Text(
                        'Profil bilgilerini güncelle',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
