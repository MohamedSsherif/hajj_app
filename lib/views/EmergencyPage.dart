// ignore: file_names
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyPage extends StatelessWidget {
  static const String id = 'EmergencyPage';

  const EmergencyPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Contacts'),
      ),

       body: EmergencyPageBody(),
    );
  }
}

class EmergencyPageBody extends StatelessWidget {
  final List<Map<String, dynamic>> emergencyContacts = [
    {'title': 'Ambulance', 'phoneNumber': '911', 'icon': Icons.local_hospital},
    {'title': 'Police', 'phoneNumber': '911', 'icon': Icons.local_police},
    {
      'title': 'Fire Extinguisher',
      'phoneNumber': '911',
      'icon': Icons.local_fire_department
    },
  ];

   EmergencyPageBody({super.key});

  Future<void> _launchCall(String number) async {
    final url = 'tel:$number';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: emergencyContacts.map((contact) {
            return EmergencyContactCard(
              title: contact['title'],
              phoneNumber: contact['phoneNumber'],
              icon: contact['icon'],
              onPressed: () {
                _launchCall(contact['phoneNumber']);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class EmergencyContactCard extends StatelessWidget {
  final String title;
  final String phoneNumber;
  final IconData icon;
  final Function() onPressed;

  const EmergencyContactCard({super.key, 
    required this.title,
    required this.phoneNumber,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(title),
        subtitle: Text('Call: $phoneNumber'),
        onTap: onPressed,
      ),
    );
  }
}