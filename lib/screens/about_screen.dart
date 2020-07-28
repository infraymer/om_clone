import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinder/resources/dimens.dart';
import 'package:tinder/resources/strings.dart';
import 'package:tinder/resources/text_styles.dart';
import 'package:tinder/utils/view_utils.dart';
import 'package:tinder/view_model/registration_controller.dart';
import 'package:tinder/widgets/app_round_button.dart';
import 'package:tinder/widgets/app_round_filled_button.dart';
import 'package:tinder/widgets/registration_app_bar.dart';
import 'package:tinder/widgets/registration_text_field.dart';
import 'package:tinder/widgets/screen_container.dart';

class AboutScreen extends StatefulWidget {
  final VoidCallback onActionClicked;
  final VoidCallback onBackClicked;

  const AboutScreen({Key key, this.onActionClicked, this.onBackClicked})
      : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final _aboutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      child: Column(
        children: <Widget>[
          RegistrationAppBar(
            onIconPressed: widget.onBackClicked,
            icon: Icons.keyboard_arrow_left,
            title: Strings.aboutTitle,
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: RegistrationTextField(
              textInputAction: TextInputAction.next,
              controller: _aboutController,
              hint: Strings.aboutFieldPlaceholder,
              onSubmitted: (_) => _onNext(context),
            ),
          ),
          SizedBox(height: 16),
          Text(Strings.aboutDescription, style: UiTextStyles.fieldDescription),
          SizedBox(height: 16),
          // Expanded(child: SizedBox()),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: Dimens.horizontalMarginButtonRegScreen),
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _aboutController,
              builder: (context, value, child) {
                if (value.text.isEmpty)
                  return AppRoundButton(
                    onPressed: () => _onNext(context),
                    text: Strings.skip,
                  );
                return AppRoundFilledButton(
                  onPressed: () => _onNext(context),
                  text: Strings.next,
                );
              },
            )
          ),
          SizedBox(height: Dimens.bottomMarginButtonRegScreen),
        ],
      ),
    );
  }

  void _onNext(BuildContext context) {
    closeKeyboard(context);
    final model = Provider.of<RegistrationController>(context, listen: false);
    model.schoolName = _aboutController.text;
    widget.onActionClicked();
  }
}
