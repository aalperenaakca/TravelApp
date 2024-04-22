/*
import 'package:dropdown_search/dropdown_search.dart';
import 'package:gezi/data/dummy.dart';


DateTime? chosenDate;
  String selectedProvince = provinces[0];

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



Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: TextFormField(
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
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /* DropdownButton(
                    value: selectedProvince,
                    items: provinces
                        .map((province) => DropdownMenuItem(
                            value: province, child: Text(province.name)))
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        selectedProvince = value;
                      });
                    },
                  )*/
                  Expanded(
                    child: DropdownSearch<String>(
                      popupProps: const PopupProps.modalBottomSheet(
                        showSearchBox: true,
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
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
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
            ),*/