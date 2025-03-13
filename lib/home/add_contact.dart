import 'dart:io';
import 'package:contact/Core/animations.dart';
import 'package:contact/Core/colors.dart';
import 'package:contact/data/contact_info.dart';
import 'package:country_phone_validator/country_phone_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class AddContact extends StatefulWidget {

  const AddContact({ super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _showImagePickerDialog() {
    _pickImage(ImageSource.gallery);

  }

  void _saveContact() {
    if (_formKey.currentState!.validate()) {
      ContactInfo newContact = ContactInfo(
        _image,
        usernameController.text,
        emailController.text,
        numberController.text,
      );

        ContactInfo.contactInfos.add(newContact);




      usernameController.clear();
      emailController.clear();
      numberController.clear();
      setState(() {
        _image = null;
      });
Navigator.pop(context);
setState(() {

});
      print(
          "Contact saved: ${newContact.name}, ${newContact.email}, ${newContact.phoneNumber}");
    } else {
      print("Form is invalid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            buildInfo(),
            buildTextField("Enter User Name", usernameController,
                TextInputType.text, "Please enter a username"),
            buildTextField("Enter User Email", emailController,
                TextInputType.emailAddress, "Please enter a valid email",
                isEmail: true),
            buildTextField("Enter User Phone", numberController,
                TextInputType.phone, "Invalid phone number",
                isPhone: true),
            buildButton(),
          ],
        ),
      ),
    );
  }

  Widget buildInfo() {
    return Row(
      children: [
        buildPicture(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildUserInfoText(usernameController.text, "User Name"),
              buildDivider(),
              buildUserInfoText(emailController.text, "example@email.com"),
              buildDivider(),
              buildUserInfoText("+20${numberController.text}", "Number"),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildUserInfoText(String value, String placeholder) {
    return Text(
      value.isEmpty ? placeholder : value,
      style: const TextStyle(color: AppColors.gold, fontSize: 16),
    );
  }

  Widget buildDivider() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: const Divider(
        color: AppColors.gold,
        height: 1,
        thickness: 1,
      ),
    );
  }

  Widget buildTextField(
    String hint,
    TextEditingController controller,
    TextInputType type,
    String errorMessage, {
    bool isEmail = false,
    bool isPhone = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        style: const TextStyle(color: AppColors.lightBlue),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.lightBlue),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.gold, width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.gold, width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return errorMessage;
          if (isEmail) {
            final emailRegex =
                RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
            if (!emailRegex.hasMatch(value))
              return "Please enter a valid email address";
          }
          if (isPhone && !CountryUtils.validatePhoneNumber(value, "+20")) {
            return "Invalid phone number";
          }
          return null;
        },
      ),
    );
  }

  Widget buildButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: _saveContact,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.gold,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Text("Save Contact",
              style: TextStyle(color: AppColors.darkBlue, fontSize: 18)),
        ),
      ),
    );
  }

  Widget buildPicture() {
    return GestureDetector(
      onTap: _showImagePickerDialog,
      child: Container(
        width: 143,
        height: 143,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.transparent,
          border: Border.all(color: AppColors.gold, width: 3),
          borderRadius: BorderRadius.circular(28),
        ),
        child: _image == null
            ? Lottie.asset(AppAnimations.add)
            : ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.file(_image!, fit: BoxFit.cover),
              ),
      ),
    );
  }
}
