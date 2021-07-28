import 'package:consultation/screens/attachments_screen.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = '/registration';

  const RegistrationScreen({Key key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _form = GlobalKey<FormState>();
  TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final _officeFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _adharCartFocusNode = FocusNode();

  var initVar = {
    // 'image':''
    'name': '',
    'date': '',
    'address': '',
    'adhar_cart': '',
    'office': []
  };

  List<Text> cityList = [
    Text('Goa'),
    Text('new ..'),
    Text('Maharashtra'),
    Text('Delhi'),
  ];

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019, 8),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        _dateController.text = date;
      });
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    Navigator.of(context).pushNamed(AttachmentsScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(),
        actions: [
          IconButton(
            icon: Image.asset('assets/Images/logo.png'),
            onPressed: () {},
            iconSize: 70,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 700,
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPuk1ANhAl5pGnajh1J2Jk83E0kVXsJtUy7Q&usqp=CAU'),
                ),
              ),
              Form(
                key: _form,
                child: Expanded(
                  child: ListView(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Name'),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please fill your full name.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          initVar = {
                            // 'image':''
                            'name': value,
                            'date': initVar['date'],
                            'address': initVar['address'],
                            'adhar_cart': initVar['adhar_cart'],
                            'office': initVar['office']
                          };
                        },
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextFormField(
                            onSaved: (value) {
                              initVar = {
                                // 'image':''
                                'name': value,
                                'date': initVar['date'],
                                'address': initVar['address'],
                                'adhar_cart': initVar['adhar_cart'],
                                'office': initVar['office']
                              };
                            },
                            controller: _dateController,
                            decoration: InputDecoration(
                              labelText: "Date of Birth",
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            validator: (value) {
                              if (value.isEmpty) return "Please enter a date";
                              return null;
                            },
                          ),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Address'),
                        keyboardType: TextInputType.multiline,
                        focusNode: _addressFocusNode,
                        onSaved: (value) {
                          initVar = {
                            // 'image':''
                            'name': initVar['name'],
                            'date': initVar['date'],
                            'address': value,
                            'adhar_cart': initVar['adhar_cart'],
                            'office': initVar['office']
                          };
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter an address';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_adharCartFocusNode);
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Adhaar card'),
                        textInputAction: TextInputAction.next,
                        focusNode: _adharCartFocusNode,
                        onSaved: (value) {
                          initVar = {
                            // 'image':''
                            'name': initVar['name'],
                            'date': initVar['date'],
                            'address': initVar['address'],
                            'adhar_cart': value,
                            'office': initVar['office']
                          };
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Adhaar card No';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_officeFocusNode);
                        },
                      ),
                      MultiSelectInput(cityList: cityList)
                    ],
                  ),
                ),
              ),
              FlatButton(
                child: Text("Submit"),
                textColor: Colors.white,
                color: Colors.blueAccent,
                onPressed: () {
                  _saveForm();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MultiSelectInput extends StatefulWidget {
  const MultiSelectInput({
    Key key,
    @required this.cityList,
  }) : super(key: key);

  final List<Text> cityList;

  @override
  _MultiSelectInputState createState() => _MultiSelectInputState();
}

class _MultiSelectInputState extends State<MultiSelectInput> {
  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (RawKeyEvent event) {
        print(event);
      },
      child: ChipsInput(
        initialValue: [],
        decoration: InputDecoration(
          labelText: "Select Cities",
        ),
        maxChips: 4,
        findSuggestions: (String query) {
          if (query.length != 0) {
            var lowercaseQuery = query.toLowerCase();
            return widget.cityList.where((profile) {
              return profile.data.toLowerCase().contains(query.toLowerCase());
            }).toList(growable: false)
              ..sort((a, b) => a.data
                  .toLowerCase()
                  .indexOf(lowercaseQuery)
                  .compareTo(b.data.toLowerCase().indexOf(lowercaseQuery)));
          } else {
            return const <Text>[];
          }
        },
        onChanged: (data) {
          setState(() {
            print(data);
          });
        },
        allowChipEditing: true,
        chipBuilder: (context, state, profile) {
          return InputChip(
            key: ObjectKey(profile),
            label: profile,
            onDeleted: () => state.deleteChip(profile),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          );
        },
        suggestionBuilder: (context, state, profile) {
          return ListTile(
            key: ObjectKey(profile),
            title: profile,
            subtitle: profile,
            onTap: () => state.selectSuggestion(profile),
          );
        },
      ),
    );
  }
}
