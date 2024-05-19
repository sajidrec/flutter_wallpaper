import 'package:flutter/material.dart';

class CreateAppbar extends StatelessWidget implements PreferredSize {
  const CreateAppbar({
    super.key,
    required this.searchKeyword,
  });

  final String searchKeyword;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(searchKeyword),
      backgroundColor: Colors.grey.shade700,
      foregroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget get child => throw UnimplementedError();
}
