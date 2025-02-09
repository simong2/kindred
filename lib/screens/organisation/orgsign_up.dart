import 'package:flutter/material.dart';
import 'package:kindred/screens/login.dart';

class OrgSignUp extends StatefulWidget {
  const OrgSignUp({super.key});

  @override
  State<OrgSignUp> createState() => _SignUpState();
}

class _SignUpState extends State<OrgSignUp> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Stepper(
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
            ),
            const SizedBox(width: 10),
            if (_index > 0)
              OutlinedButton(
                onPressed: details.onStepCancel,
                child: const Text('Back'),
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
                controller: _usernameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.business),
                  fillColor: Colors.white,
                  labelText: 'Organization Name',
                  border: OutlineInputBorder(),
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
                controller: _usernameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.house),
                  fillColor: Colors.white,
                  labelText: 'Address',
                  border: OutlineInputBorder(),
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
                controller: _usernameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  fillColor: Colors.white,
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
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
                controller: _usernameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  fillColor: Colors.white,
                  labelText: 'Email',
                  border: OutlineInputBorder(),
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
                controller: _usernameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  fillColor: Colors.white,
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ),
        Step(
          title: const Text('Reenter Password'),
          content: Container(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: width / 1.3,
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  fillColor: Colors.white,
                  labelText: 'Reenter Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
