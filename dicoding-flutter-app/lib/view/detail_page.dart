import 'package:flutter/material.dart';

import '../model/google_office.dart';

class DetailPage extends StatelessWidget {
  final GoogleOffice googleOffice;
  final String googleOfficeId;

  DetailPage({super.key, required this.googleOfficeId})
      : googleOffice = listOfGoogleOffice.firstWhere(
          (office) => office.id == googleOfficeId,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(googleOffice.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                googleOffice.image,
                width: double.infinity,
                height: 240,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              googleOffice.name,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              googleOffice.address,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            _DetailItem(
              icon: Icons.public,
              label: 'Region',
              value: googleOffice.region,
            ),
            _DetailItem(
              icon: Icons.phone,
              label: 'Phone',
              value: googleOffice.phone,
            ),
            _DetailItem(
              icon: Icons.location_on,
              label: 'Latitude',
              value: googleOffice.lat.toString(),
            ),
            _DetailItem(
              icon: Icons.location_on_outlined,
              label: 'Longitude',
              value: googleOffice.lng.toString(),
            ),
            _DetailItem(
              icon: Icons.badge,
              label: 'Office ID',
              value: googleOffice.id,
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 2),
                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
