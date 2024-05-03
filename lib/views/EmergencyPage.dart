import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyPage extends StatelessWidget {
  static const String id = 'EmergencyPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Contacts'),
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

  Future<void> _launchCall(String number) async {
    final url = 'tel:$number';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: EdgeInsets.all(20.0),
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

  EmergencyContactCard({
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