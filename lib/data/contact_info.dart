import 'dart:io';

class ContactInfo {
 File? photo;
 String? name;
 String? email;
 String? phoneNumber;

 ContactInfo(
     this.photo,
     this.name,
     this.email,
     this.phoneNumber,
     );

 static List<ContactInfo> contactInfos = [];
}