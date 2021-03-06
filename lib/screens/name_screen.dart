import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tinder/resources/dimens.dart';
import 'package:tinder/resources/strings.dart';
import 'package:tinder/resources/text_styles.dart';
import 'package:tinder/utils/view_utils.dart';
import 'package:tinder/view_model/registration_controller.dart';
import 'package:tinder/widgets/app_round_filled_button.dart';
import 'package:tinder/widgets/registration_app_bar.dart';
import 'package:tinder/widgets/registration_text_field.dart';
import 'package:tinder/widgets/screen_container.dart';

class NameScreen extends StatefulWidget {
  final VoidCallback onActionClicked;
  final VoidCallback onBackClicked;

  const NameScreen({Key key, this.onActionClicked, this.onBackClicked})
      : super(key: key);

  @override
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RegistrationController>(context, listen: false);
    return ScreenContainer(
      child: Column(
        children: <Widget>[
          RegistrationAppBar(
            onIconPressed: widget.onBackClicked,
            icon: Icons.close,
            title: Strings.nameTitle,
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: RegistrationTextField(
              textInputAction: TextInputAction.next,
              controller: _nameController,
              hint: Strings.nameFieldPlaceholder,
              onSubmitted: (_) {
                if (_nameController.text.isEmpty) {
                  Get.snackbar('Validation', Strings.fieldMustNotBeEmpty);
                  return;
                }
                model.name = _nameController.text;
                widget.onActionClicked();
              },
            ),
          ),
          SizedBox(height: 16),
          Text(Strings.nameDescription, style: UiTextStyles.fieldDescription),
          // Expanded(child: SizedBox()),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: Dimens.horizontalMarginButtonRegScreen),
              child: AppRoundFilledButton(
                onPressed: () {
                  if (_nameController.text.isEmpty) {
                    Get.snackbar('Validation', Strings.fieldMustNotBeEmpty);
                    return;
                  }
                  model.name = _nameController.text;
                  widget.onActionClicked();
                },
                text: Strings.next,
              ),
            ),
          ),
          SizedBox(height: Dimens.bottomMarginButtonRegScreen),
        ],
      ),
    );
  }
}
