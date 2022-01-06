import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:auto_size_text/auto_size_text.dart';

class InfoTextWidget extends StatelessWidget {
  const InfoTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AutoSizeText(
        AppLocalizations.of(context).infoText,
        style: Theme.of(context).textTheme.headline2,
        maxLines: 1,
      ),
    );
  }
}
