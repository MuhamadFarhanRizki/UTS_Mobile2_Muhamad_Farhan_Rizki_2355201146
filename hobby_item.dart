import 'package:flutter/material.dart';

class HobbyItem extends StatelessWidget {
  final String hobby;
  final VoidCallback? onEdit;
  const HobbyItem({super.key, required this.hobby, this.onEdit});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
            child: Text(hobby[0].toUpperCase(),
                style: TextStyle(color: cs.onPrimary)),
            backgroundColor: cs.primary),
        title: Text(hobby),
        trailing: IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
      ),
    );
  }
}
