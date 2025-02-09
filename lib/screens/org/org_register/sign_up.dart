import 'package:flutter/material.dart';
import 'package:kindred/services/firebase_services.dart';

const darkGreen = 0xFF667B68;
const mediumGreen = 0xFFA3B899;
const lightGreen = 0xFFDDE6D5;

class OrgSignUp extends StatefulWidget {
  const OrgSignUp({super.key});

  @override
  State<OrgSignUp> createState() => _SignUpState();
}

class _SignUpState extends State<OrgSignUp> {
  late TextEditingController _orgNameController;
  late TextEditingController _orgAddressController;
  late TextEditingController _zipCodeController;
  late TextEditingController _orgPhoneNumberController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  int _index = 0;

  @override
  void initState() {
    super.initState();
    _orgNameController = TextEditingController();
    _orgAddressController = TextEditingController();
    _zipCodeController = TextEditingController();
    _orgPhoneNumberController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _orgNameController.dispose();
    _orgAddressController.dispose();
    _zipCodeController.dispose();
    _orgPhoneNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.light(
          primary: Color(darkGreen), // Active step color
          onPrimary: Color(darkGreen), // Active step text color
          secondary: Color(mediumGreen), // Stepper line color
        ),
      ),
      child: Stepper(
        currentStep: _index,
        onStepCancel: () {
          if (_index > 0) {
            setState(() {
              _index -= 1;
            });
          }
        },
        onStepContinue: () {
          if (_index < 5) {
            setState(() {
              _index += 1;
            });
          } else {
            // Perform the sign-up action here
            print("Sign Up button pressed");

            // create org account
            try {
              print('account created');

              /*
                String orgName,
                String orgAddy,
                String orgZip,
                String orgPhone,
                String email,
                String password,
               */
              FirebaseServices().createOrg(
                _orgNameController.text,
                _orgAddressController.text,
                _zipCodeController.text,
                _orgPhoneNumberController.text,
                _emailController.text,
                _passwordController.text,
              );
              Navigator.pop(context);
            } catch (e) {
              print('creating org creation failed');
              print(e.toString());
            }
          }
        },
        onStepTapped: (int index) {
          setState(() {
            _index = index;
          });
        },
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: details.onStepContinue,
                child: Text(_index == 5 ? 'Sign Up' : 'Continue'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(darkGreen), // Button background color
                  foregroundColor: Color(lightGreen), // Button text color
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
              const SizedBox(width: 20),
              if (_index > 0)
                OutlinedButton(
                  onPressed: details.onStepCancel,
                  child: const Text('Back'),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(darkGreen)), // Border color
                    foregroundColor: Color(darkGreen), // Text color
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
            ],
          );
        },
        steps: <Step>[
          Step(
            title: const Text('Organization Name'),
            content: Container(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: width / 1.3,
                child: TextField(
                  controller: _orgNameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.business, color: Color(darkGreen)),
                    fillColor: Color(darkGreen),
                    labelText: 'Organization Name',
                    labelStyle: TextStyle(
                        color: Color(darkGreen)), // Changed label text color
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(darkGreen)), // Default border color
                    ),
                  ),
                ),
              ),
            ),
          ),
          Step(
            title: const Text('Address'),
            content: Container(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: width / 1.3,
                child: TextField(
                  controller: _orgAddressController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.house, color: Color(darkGreen)),
                    fillColor: Color(darkGreen),
                    labelText: 'Address',
                    labelStyle: TextStyle(
                        color: Color(darkGreen)), // Changed label text color
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(darkGreen)), // Default border color
                    ),
                  ),
                ),
              ),
            ),
          ),
          Step(
            title: const Text('Zip code'),
            content: Container(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: width / 1.3,
                child: TextField(
                  controller: _zipCodeController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.numbers, color: Color(darkGreen)),
                    fillColor: Color(darkGreen),
                    labelText: 'Zip code',
                    labelStyle: TextStyle(
                        color: Color(darkGreen)), // Changed label text color
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(darkGreen)), // Default border color
                    ),
                  ),
                ),
              ),
            ),
          ),
          Step(
            title: const Text('Phone Number'),
            content: Container(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: width / 1.3,
                child: TextField(
                  controller: _orgPhoneNumberController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone, color: Color(darkGreen)),
                    fillColor: Color(darkGreen),
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(
                        color: Color(darkGreen)), // Changed label text color
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(darkGreen)), // Default border color
                    ),
                  ),
                ),
              ),
            ),
          ),
          Step(
            title: const Text('Email'),
            content: Container(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: width / 1.3,
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.mail, color: Color(darkGreen)),
                    fillColor: Color(darkGreen),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        color: Color(darkGreen)), // Changed label text color
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(darkGreen)), // Default border color
                    ),
                  ),
                ),
              ),
            ),
          ),
          Step(
            title: const Text('Password'),
            content: Container(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: width / 1.3,
                child: TextField(
                  controller: _passwordController,
                  obscureText: showPassword,
                  decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.password, color: Color(darkGreen)),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: const Icon(Icons.remove_red_eye),
                    ),
                    fillColor: Color(darkGreen),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        color: Color(darkGreen)), // Changed label text color
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(darkGreen)), // Default border color
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
