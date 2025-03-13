import 'package:contact/Core/animations.dart';
import 'package:contact/Core/colors.dart';
import 'package:contact/Core/img.dart';
import 'package:contact/data/contact_info.dart';
import 'package:contact/home/add_contact.dart';
import 'package:contact/home/contact.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class home extends StatefulWidget {
  static const route = "home";

  home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final List<String>  _notificationEmails = <String>[];

  @override
  Widget build(BuildContext context) {

    return Scaffold(


      appBar: AppBar(
        backgroundColor:Colors.transparent ,
        leading: Padding(
          padding: const EdgeInsets.only(left: 26),
          child: Image.asset(AppImg.routeLogo,
          ),
        ),
        leadingWidth: 150,
      ),



      body:
      Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            ContactInfo.contactInfos.isEmpty?buildNoContacts():buildShowContact(context),
            buildAddContacts(context),
          ],
        ),
      ),
    );
  }

  Stack buildShowContact(BuildContext context) {
    setState(() {

    });
    return Stack(
           children: [
             Contact(),
             buildDeleteContact(context)
           ],
         );
  }

///------------------------------------------------------------


  Widget buildAddContacts(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            backgroundColor: AppColors.darkBlue,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
            ),
            isScrollControlled: true, // Allow the bottom sheet to expand
            context: context,
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
              ),
              child: SingleChildScrollView( // Make the content scrollable
                child: AddContact(),
              ),
            ),
          );
        },
        backgroundColor: AppColors.gold,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildDeleteContact(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 64),
      child: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: ()  {
          },
          backgroundColor: AppColors.red,
          child: const Icon(Icons.delete, color: AppColors.lightBlue),
        ),
      ),
    );
  }

  Widget buildNoContacts() {
    return Column(
      children: [
        Lottie.asset(AppAnimations.home),
        const Align(
          alignment: Alignment.center,
          child: Text(
            "There is No Contacts Added Here",
            style: TextStyle(
              fontSize: 20,
              color: AppColors.gold,
            ),
          ),
        ),
      ],
    );
  }
}