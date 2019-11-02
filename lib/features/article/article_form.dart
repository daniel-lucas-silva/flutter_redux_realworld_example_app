import 'dart:async';

import 'package:conduite/components.dart';
import 'package:conduite/features/home/home_screen.dart';
import 'package:conduite/store.dart';
import 'package:conduite/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ArticleForm extends StatefulWidget {
  @override
  _ArticleFormState createState() => _ArticleFormState();
}

class _ArticleFormState extends State<ArticleForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, dynamic>{};
  final _tagController = TextEditingController();

  @override
  void dispose() {
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("New Post"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                onSaved: (value) => _formData.addAll({"title": value}),
                decoration: InputDecoration(labelText: "Article Title"),
                validator: (value) => value.length < 1
                    ? "title can't be blankis too short (minimum is 1 character)"
                    : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                onSaved: (value) => _formData.addAll({"description": value}),
                decoration: InputDecoration(
                  labelText: "What'a this article about?",
                ),
                validator: (value) => value.length < 1
                    ? "description can't be blankis too short (minimum is 1 character)"
                    : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                onSaved: (value) => _formData.addAll({"body": value}),
                decoration: InputDecoration(
                  labelText: "Write your article (in markdown)",
                ),
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: null,
                validator: (value) =>
                    value.isEmpty ? "body can't be blank" : null,
              ),
              SizedBox(height: 10),
              FormField<List<String>>(
                onSaved: (value) => _formData.addAll({"tagList": value}),
                initialValue: [],
                builder: (state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Enter tags",
                        ),
                        controller: _tagController,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (v) {
                          state.setState(() {
                            if (!state.value.contains(v)) {
                              state.value.add(v);
                              _tagController.clear();
                            }
                          });
                        },
                      ),
                      Wrap(
                        children: state.value.map<Chip>((v) {
                          return Chip(
                            label: Text(v),
                            onDeleted: () {
                              state.setState(() {
                                state.value.remove(v);
                              });
                            },
                          );
                        }).toList(),
                      )
                    ],
                  );
                },
              ),
              SizedBox(height: 10),
              StoreConnector<AppState, dynamic>(
                converter: (store) => store.dispatch,
                builder: (context, dispatch) {
                  return AsyncButton(
                    child: Text("Publish Article"),
                    textColor: Colors.white,
                    builder: (context) {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        final completer = new Completer();
                        _formData.removeWhere((key, value) => value.isEmpty);
                        dispatch(createArticle(
                          context,
                          completer,
                          title: _formData['title'],
                          description: _formData['description'],
                          body: _formData['body'],
                          tagList: _formData['tagList'],
                        ));
                        return completer.future;
                      }
                      return Future.error(
                        Exception("Please complete all required fields"),
                      );
                    },
                    onSuccess: (value) {
                      showSnackbar(context, Text(value));
                      resetTo(context, HomeScreen());
                    },
                    onError: (e) {
                      showSnackbar(context, Text(e.message));
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
