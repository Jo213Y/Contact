import 'package:contact/Core/colors.dart';
import 'package:contact/data/contact_info.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final ContactInfo contactInfo;
  void Function() onDelete;// Make it non-nullable

  CardWidget({super.key,required this.onDelete, required this.contactInfo}); // Require it in constructor

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 177,
      height: 286,
      decoration: const BoxDecoration(
        color: AppColors.gold,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Container(
                height: 177,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(contactInfo.photo.toString()), // Fixed
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
              ),
              SizedBox(
                height: 177,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.gold,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        contactInfo.name??'',
                        style: const TextStyle(
                          height: 2,
                          color: AppColors.darkBlue,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          buildEmail(),
          buildPhoneNumber(),
          buildDelete(),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Padding buildEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(Icons.email, color: AppColors.darkBlue, size: 20),
          const SizedBox(width: 10),
          Text(contactInfo.email??'', style: const TextStyle(color: AppColors.darkBlue, fontSize: 15)),
        ],
      ),
    );
  }

  Padding buildPhoneNumber() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(Icons.phone_in_talk, color: AppColors.darkBlue, size: 20),
          const SizedBox(width: 10),
          Text(contactInfo.phoneNumber??'', style: const TextStyle(color: AppColors.darkBlue, fontSize: 15)),
        ],
      ),
    );
  }

  SizedBox buildDelete() {
    return SizedBox(
      width: 160,
      height: 40,
      child: ElevatedButton(
        onPressed: onDelete,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.red,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete, color: AppColors.white, size: 20),
            SizedBox(width: 5),
            Text("Delete", style: TextStyle(color: AppColors.white, fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
