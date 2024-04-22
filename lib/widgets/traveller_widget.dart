import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gezi/data/dummy.dart';
import 'package:gezi/pages/main_page.dart';

class TravellerWidget extends StatefulWidget {
  const TravellerWidget({super.key});

  @override
  State<TravellerWidget> createState() => TravellerWidgetState();
}

class TravellerWidgetState extends State<TravellerWidget> {
  bool isSelected = false;
  bool current = true;

  String selectedProvince = provinces[0];

  void check() {
    for (int i = 0; i < placesList.length; i++) {
      if (placesList[i].province == selectedProvince) {
        current = false;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //child: Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
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
                      //selectedItem: selectedProvince,
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
                          isSelected = true;
                          current = true;
                          check();
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Icon(Icons.location_city),
                ],
              ),
            ),
            if (isSelected)
              if (current)
                const Text('Seçtiğiniz şehirde bir ilan bulunamadı')
              else
                for (int i = 0; i < placesList.length; i++)
                  if (placesList[i].province == selectedProvince)
                    Card(
                      margin: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 50,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 120,
                            width: 100,
                            child: Image.asset(
                              'assets/images/anon-profile.jpg',
                            ),
                          ),
                          Text(selectedProvince),
                          const SizedBox(width: 30),
                          Text(placesList[i].owner),
                          const SizedBox(height: 30),
                        ],
                      ),
                    )
                  else
                    const SizedBox(height: 0, width: 0)
            else
              const Text('Devam etmek için bir şehir seç')
          ],
        ),
      ),
      //),
    );
  }
}
