import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_app/data/model/user_model.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/controllers/auth_controller.dart';
import 'package:task_manager_app/ui/widgets/centered_Progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';
import 'package:task_manager_app/ui/widgets/tm_appbar.dart';

import '../widgets/photo_picker_field.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});
  static const String name = '/update-profile';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;
  bool _updateProfileInProgress = false;
  @override
  void initState() {
    super.initState();
    UserModel user = AuthController.userModel!;
    _emailTEController.text = user.email;
    _firstNameTEController.text = user.firstName;
    _lastNameTEController.text = user.lastName;
    _mobileTEController.text = user.mobile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(fromUpdateProfile: true),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Update Profile',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  PhotoPickerField(
                    onTap: _pickImage,
                    selectedPhoto: _selectedImage,
                  ),
                  TextFormField(
                    controller: _emailTEController,
                    decoration: InputDecoration(hintText: 'Email'),
                    enabled: false,
                  ),
                  TextFormField(
                    controller: _firstNameTEController,
                    decoration: InputDecoration(hintText: 'First Name'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your first name';
                      }
                    },
                  ),
                  TextFormField(
                    controller: _lastNameTEController,
                    decoration: InputDecoration(hintText: 'Last Name'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your last name';
                      }
                    },
                  ),
                  TextFormField(
                    controller: _mobileTEController,
                    decoration: InputDecoration(hintText: 'Mobile'),
                  ),
                  TextFormField(
                    controller: _passwordTEController,
                    decoration: InputDecoration(hintText: 'Password'),
                    validator: (String? value) {
                      if ((value != null && value.isNotEmpty) &&
                          value.length < 6) {
                        return 'Enter a password more than 6 letters';
                      }
                    },
                  ),
                  Visibility(
                    visible: _updateProfileInProgress == false,
                    replacement: CenteredProgressIndicator(),
                    child: FilledButton(
                      onPressed: _onTapUpdateButton,
                      child: Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapUpdateButton() {
    if (_formKey.currentState!.validate()) {
      _updateProfile();
    }
  }

  Future<void> _updateProfile() async {
    _updateProfileInProgress = true;
    setState(() {});
    final Map<String, dynamic> requestBody = {
      "email": _emailTEController.text,
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
    };

    if (_passwordTEController.text.isNotEmpty) {
      requestBody["password"] = _passwordTEController.text;
    }
    String? encodedPhoto;
    if (_selectedImage != null) {
      Uint8List bytes = await _selectedImage!.readAsBytes();
      encodedPhoto = base64Encode(bytes);
      requestBody["photo"] = encodedPhoto;
    }

    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.updateProfileUrl,
      body: requestBody,
    );
    _updateProfileInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      _passwordTEController.clear();

      UserModel model = UserModel(
        id: AuthController.userModel!.id,
        email: _emailTEController.text,
        firstName: _firstNameTEController.text.trim(),
        lastName: _lastNameTEController.text.trim(),
        mobile: _mobileTEController.text.trim(),
        photo: encodedPhoto ?? AuthController.userModel!.photo,
      );
      await AuthController.updateUserData(model);

      showSnackBarMessage(context, 'Profile has been updated');
    } else {
      showSnackBarMessage(context, 'Profile update failed');
    }
  }

  Future<void> _pickImage() async {
    XFile? pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    _selectedImage = pickedImage;
    setState(() {});
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
