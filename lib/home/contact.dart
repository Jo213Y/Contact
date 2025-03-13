import 'package:contact/data/contact_info.dart';
import 'package:flutter/material.dart';
import '../widgets/build_card.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: ContactInfo.contactInfos.length, // Corrected
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        mainAxisExtent: 300,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final contact = ContactInfo.contactInfos[index]; // Fetch contact data
        return CardWidget(
          contactInfo: contact,
          onDelete: () {
            ContactInfo.contactInfos.removeAt(index);
            setState(() {});
          },
        ); // Pass it correctly
      },
    );
  }
}
