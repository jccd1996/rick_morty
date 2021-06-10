import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var _textController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test yours libraries here'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: TextFormField(
            controller: _textController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.search,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onFieldSubmitted: (value) {
              if (value == '') {
                _focusNode.requestFocus();
              }
            },
          ),
        ),
      ),
    );
  }
}
