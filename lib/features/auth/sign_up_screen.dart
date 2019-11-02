import 'package:conduite/components.dart';
import 'package:conduite/config.dart';
import 'package:conduite/features/auth/sign_in_screen.dart';
import 'package:conduite/store.dart';
import 'package:conduite/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreeState createState() => _SignUpScreeState();
}

class _SignUpScreeState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  String username;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text("Sign Up", style: Styles.appBarLight),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                onSaved: (value) => username = value,
                decoration: InputDecoration(labelText: "Username"),
                validator: (value) => value.isEmpty ? 'Required!' : null,
              ),
              SizedBox(height: 10),TextFormField(
                onSaved: (value) => email = value,
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value.isEmpty ? 'Required!' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                onSaved: (value) => password = value,
                decoration: InputDecoration(labelText: "Password"),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (value) => value.isEmpty ? 'Required!' : null,
              ),
              SizedBox(height: 5),
              Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: RawButton(
                      child: Text("Have an account?"),
                      textColor: ConduiteColors.green,
                      onPressed: () {
                        resetTo(context, SignInScreen());
                      },
                    ),
                  ),
                  StoreConnector<AppState, dynamic>(
                      converter: (store) => store.dispatch,
                      builder: (context, dispatch) {
                        return Flexible(
                          flex: 1,
                          child: Button(
                            child: Text("Sign Up"),
                            textColor: Colors.white,
                            onPressed: () {
                              dispatch();
                            },
                          ),
                        );
                      }
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
