import 'dart:async';

import 'package:conduite/components.dart';
import 'package:conduite/models.dart';
import 'package:conduite/store.dart';
import 'package:conduite/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class _ViewModel {
  final User user;
  final dispatch;

  _ViewModel({
    this.user,
    this.dispatch,
  });
}

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, dynamic>{};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: StoreConnector<AppState, _ViewModel>(
          converter: (store) => _ViewModel(
            user: store.state.auth.user,
            dispatch: store.dispatch,
          ),
          builder: (context, vm) {
            return Column(
              children: <Widget>[
                TextFormField(
                  onSaved: (value) => _formData.addAll({"image": value}),
                  decoration: InputDecoration(labelText: "Image URL"),
                  keyboardType: TextInputType.url,
                  initialValue: vm.user.image,
                ),
                SizedBox(height: 10),
                TextFormField(
                  onSaved: (value) => _formData.addAll({"username": value}),
                  decoration: InputDecoration(labelText: "Username"),
                  validator: (value) => value.isEmpty ? 'Required!' : null,
                  initialValue: vm.user.username,
                ),
                SizedBox(height: 10),
                TextFormField(
                  onSaved: (value) => _formData.addAll({"bio": value}),
                  decoration: InputDecoration(labelText: "Bio"),
                  keyboardType: TextInputType.multiline,
                  minLines: 5,
                  maxLines: null,
                  initialValue: vm.user.bio,
                ),
                SizedBox(height: 10),
                TextFormField(
                  onSaved: (value) => _formData.addAll({"email": value}),
                  decoration: InputDecoration(labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value.isEmpty ? 'Required!' : null,
                  initialValue: vm.user.email,
                ),
                SizedBox(height: 10),
                TextFormField(
                  onSaved: (value) => _formData.addAll({"password": value}),
                  decoration: InputDecoration(labelText: "Password"),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                SizedBox(height: 10),
                AsyncButton(
                  child: Text("Update Settings"),
                  textColor: Colors.white,
                  builder: (context) {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      final completer = new Completer();
                      _formData.removeWhere((key, value) => value.isEmpty);
                      vm.dispatch(updateUser(
                        context,
                        _formData,
                        completer,
                      ));
                      return completer.future;
                    }
                    return Future.error("Please complete all required fields");
                  },
                  onSuccess: (value) {
                    showSnackbar(context, Text(value));
                  },
                  onError: (e) {
                    showSnackbar(context, Text(e.message));
                  },
                ),
                RawButton(
                  onPressed: () {
                    vm.dispatch(logout(context));
                  },
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  textColor: Colors.red[800],
                  child: Text("Or click here to logout"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
