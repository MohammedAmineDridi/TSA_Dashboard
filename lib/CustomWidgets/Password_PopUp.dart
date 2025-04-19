import 'package:dashboard/DashboardMainScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../Utils/helpers.dart';
class PasswordPopup extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();

  PasswordPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Image.asset(
          'assets/logo/TSA_logo.png',
          width: 300,
          height: 300,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Welcome to Tunisian Space Agency's Model Rocket Dashboard, Please Set your password here",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (passwordController.text == dotenv.env['PASSWORD']) {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const DashboardMainScreen(),
              ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Incorrect password!')),
              );
            }
          },
          child: const Text('Submit',style:TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
