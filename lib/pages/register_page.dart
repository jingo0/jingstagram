import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  double? _deviceHeight, _deviceWidth;
  String? _name, _email, _password;
  File? _image;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _titleWidget(),
            _profileImageWidget(),
            _registerForm(),
            _registerButton(),
          ],
        ),
      ),
    )));
  }

  Widget _titleWidget() {
    return const Text(
      "Jingstagram",
      style: TextStyle(
          color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
    );
  }

  Widget _registerButton() {
    return MaterialButton(
      onPressed: _registerUser,
      minWidth: _deviceWidth! * 0.7,
      height: _deviceHeight! * 0.06,
      color: Colors.red,
      child: const Text(
        "Register",
        style: TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _registerForm() {
    return Container(
        height: _deviceHeight! * 0.30,
        child: Form(
            key: _registerFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _nameTextField(),
                _emailTextField(),
                _passwordTextField(),
              ],
            )));
  }

  Widget _nameTextField() {
    return TextFormField(
      decoration: const InputDecoration(hintText: "Name..."),
      validator: (value) {
        return value!.isNotEmpty ? null : "Please enter valid name";
      },
      onSaved: (value) {
        setState(() {
          _name = value;
        });
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(hintText: "Password..."),
      onSaved: (value) {
        setState(() {
          _password = value;
        });
      },
      validator: (value) {
        bool result = value!.length > 6;
        return result
            ? null
            : "Please enter a password with length grater than 6";
      },
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(hintText: "Email..."),
      onSaved: (value) {
        setState(() {
          _email = value;
        });
      },
      validator: (value) {
        bool result = value!.contains(
          RegExp(
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"),
        );
        return result ? null : "Please enter a valid email";
      },
    );
  }

  void _registerUser() {
    print(_registerFormKey.currentState!.validate());

    if (_registerFormKey.currentState!.validate() && _image != null) {
      _registerFormKey.currentState!.save();
    }
  }

  Widget _profileImageWidget() {
    var _imageProvider = _image != null
        ? FileImage(_image!)
        : const NetworkImage('https://i.pravatar.cc/300');
    return GestureDetector(
      onTap: () {
        FilePicker.platform.pickFiles(type: FileType.image).then((result) {
          if (result == null) {
            const NetworkImage('https://i.pravatar.cc/300');
          } else {
            setState(() {
              _image = result.files.first.path as File?;
            });
          }
        });
      },
      child: Container(
        height: _deviceHeight! * 0.15,
        width: _deviceHeight! * 0.15,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: _imageProvider as ImageProvider)),
      ),
    );
  }
}
