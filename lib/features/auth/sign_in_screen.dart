import 'package:conduite/components.dart';
import 'package:conduite/config.dart';
import 'package:conduite/features/auth/sign_up_screen.dart';
import 'package:conduite/store.dart';
import 'package:conduite/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreeState createState() => _SignInScreeState();
}

class _SignInScreeState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text("Sign In", style: Styles.appBarLight),
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
                onSaved: (value) => _formData.addAll({"email": value}),
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value.isEmpty ? 'Required!' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                onSaved: (value) => _formData.addAll({"password": value}),
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
                      child: Text("Need an account?"),
                      textColor: ConduiteColors.green,
                      onPressed: () {
                        navigateTo(context, SignUpScreen());
                      },
                    ),
                  ),
                  StoreConnector<AppState, dynamic>(
                      converter: (store) => store.dispatch,
                      builder: (context, dispatch) {
                        return Flexible(
                          flex: 1,
                          child: Button(
                            child: Text("Sign In"),
                            textColor: Colors.white,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                dispatch(signIn(
                                  context,
                                  username: _formData['email'],
                                  password: _formData['password'],
                                ));
                              }
                            },
                          ),
                        );
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
