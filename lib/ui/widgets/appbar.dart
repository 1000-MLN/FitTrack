import 'package:fit_track/ui/widgets/final_custom_icons_icons.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget appBarCustom(BuildContext context, String title, {List<Widget>? actions}) {
  return AppBar(
      leading: Container(
        padding: const EdgeInsets.only(left: 10, top: 16),
        alignment: Alignment.centerLeft,
        child: IconButton(
          icon: const Icon(FinalCustomIcons.back),
          onPressed: () {
            Navigator.of(context).pop(); 
          },
        ),
      ),
      backgroundColor: Colors.transparent,
      title: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
         title,
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: const Color(0xFFC5AEF6)),
        ),
      ),
      actions: actions ?? [],
      
      );
}
