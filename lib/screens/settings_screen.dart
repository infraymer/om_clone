import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:provider/provider.dart';
import 'package:tinder/model/gender.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/resources/images.dart';
import 'package:tinder/view_model/auth_view_model.dart';
import 'package:tinder/view_model/settings_view_model.dart';
import 'package:tinder/widgets/circle_container.dart';
import 'package:tinder/widgets/dialog/dialogs.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<SettingsViewModel>();
    if (model.saved) Navigator.pop(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _AppBar(),
            if (model.isLoading) _Loading(),
            if (model.error != null) _Error(),
            if (model.user != null && model.error == null && !model.isLoading)
              _Content(),
          ],
        ),
      ),
    );
  }
}

class _Error extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SettingsViewModel>(context, listen: false);
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(model.error ?? ''),
            SizedBox(height: 16),
            RaisedButton(
              child: Text('Refresh'),
              onPressed: () => model.fetchData(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Center(child: CircularProgressIndicator()));
  }
}

class _Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<SettingsViewModel>();
    return Expanded(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 20),
          GestureDetector(
            onTap: () => model.onDoneClicked(),
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Done'),
            ),
          ),
          _Avatar(),
          // _Switch(),
          SizedBox(height: 30),
//          _Bio(),
//          SizedBox(height: 20),
          _Description(),
          SizedBox(height: 20),
          _Divider(),
          SizedBox(height: 20),
          _MaximumDistance(),
          _AgeRange(),
          SizedBox(height: 10),
          _SelectorButton(
            title: 'Show Me',
            value: model.gender.name,
            onTap: () async {
              final gender = await Dialogs.showGenderDialog(context);
              if (gender == null) return;
              model.setGender(gender);
            },
          ),
          _SelectorButton(title: 'Privacy Policy'),
          _SelectorButton(title: 'Terms of Service'),
          SizedBox(height: 20),
          _LogOutButton(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.black12),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SvgPicture.asset(
                  AppImages.logoDark,
                  height: 26,
                ),
                Opacity(
                  opacity: 0,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.settings, color: Colors.black12),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: AppColors.divider,
            height: 2,
          )
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SettingsViewModel>(context, listen: false);
    final user = model.user;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IntrinsicHeight(
          child: IntrinsicWidth(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(500),
                  child: Image.network(
                    user.imgs.firstOrNull ?? '',
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CircleContainer(
                    transform: Matrix4.translationValues(10.0, 10.0, 0.0),
                    size: 40,
                    color: AppColors.main,
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Switch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerRight,
      child: Switch(
        onChanged: (v) {},
        value: true,
      ),
    );
  }
}

class _Bio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<SettingsViewModel>(context, listen: false).user;
    return GestureDetector(
      onTap: () {
        Dialogs.showBioDialog(context);
      },
      child: Container(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text('BIO'),
            CircleContainer(
              size: 20,
              margin: EdgeInsets.only(left: 80),
              color: AppColors.main,
              padding: EdgeInsets.all(4),
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SettingsViewModel>(context, listen: false);
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            focusNode.requestFocus();
          },
          child: Container(
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text('BIO'),
                CircleContainer(
                  size: 20,
                  margin: EdgeInsets.only(left: 80),
                  color: AppColors.main,
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 60),
          child: TextField(
            controller: TextEditingController(text: model.about),
            focusNode: focusNode,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            onChanged: (value) {
              model.about = value;
            },
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      color: AppColors.divider,
    );
  }
}

class _SliderTitle extends StatelessWidget {
  final String text;

  const _SliderTitle({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text ?? '',
        style: TextStyle(),
      ),
    );
  }
}

class _MaximumDistance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<SettingsViewModel>();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SliderTitle(text: 'Maximum Distance'),
          Row(
            children: [
              Expanded(child: _Slider()),
              SizedBox(width: 8),
              Text('${model.distance} km')
            ],
          )
        ],
      ),
    );
  }
}

class _AgeRange extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<SettingsViewModel>();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SliderTitle(text: 'Age Range'),
          Row(
            children: [
              Expanded(child: _SliderDouble()),
              SizedBox(width: 8),
              Text('${model.minAge}-${model.maxAge}')
            ],
          )
        ],
      ),
    );
  }
}

class _Slider extends StatefulWidget {
  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<_Slider> {
  double _value = 3;
  SettingsViewModel model;

  @override
  void initState() {
    super.initState();
    model = context.read<SettingsViewModel>();
    _value = model.distance.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSlider(
      values: [_value],
      max: 100,
      min: 2,
      handler: _handlerSlider,
      trackBar: _trackBar,
      onDragging: (handlerIndex, lowerValue, upperValue) {
        _value = lowerValue;
        model?.distance = lowerValue.toInt();
        setState(() {});
      },
      onDragCompleted: (handlerIndex, lowerValue, upperValue) {
        model.update();
      },
    );
  }
}

class _SliderDouble extends StatefulWidget {
  @override
  _SliderDoubleState createState() => _SliderDoubleState();
}

class _SliderDoubleState extends State<_SliderDouble> {
  double _value = 18;
  double _valueUpper = 50;
  SettingsViewModel model;

  @override
  void initState() {
    super.initState();
    model = context.read<SettingsViewModel>();
    _value = model.minAge.toDouble();
    _valueUpper = model.maxAge.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSlider(
      values: [_value, _valueUpper],
      max: 99,
      min: 18,
      rangeSlider: true,
      handler: _handlerSlider,
      rightHandler: _handlerSlider,
      trackBar: _trackBar,
      onDragging: (handlerIndex, lowerValue, upperValue) {
        _value = lowerValue;
        _valueUpper = upperValue;
        model?.minAge = lowerValue.toInt();
        model?.maxAge = upperValue.toInt();
        setState(() {});
      },
      onDragCompleted: (handlerIndex, lowerValue, upperValue) {
        model.update();
      },
    );
  }
}

final _trackBar = FlutterSliderTrackBar(
  activeTrackBarHeight: 2,
  inactiveTrackBarHeight: 2,
  inactiveTrackBar: BoxDecoration(
    color: Colors.cyan[900],
  ),
  activeTrackBar: BoxDecoration(
    color: Colors.cyan,
  ),
);

final _handlerSlider = FlutterSliderHandler(
  child: Material(
    type: MaterialType.canvas,
    borderRadius: BorderRadius.circular(60),
    elevation: 0,
    child: Container(
      padding: EdgeInsets.all(0),
      child: ClipOval(
        child: Container(
          color: Colors.white,
        ),
      ),
    ),
  ),
);

class _SelectorButton extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  const _SelectorButton({Key key, this.value, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Material(
        color: AppColors.bgSelectorButton,
        child: InkWell(
          onTap: onTap ?? () {},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title ?? '', style: style),
                Row(
                  children: [
                    Text((value ?? '').toUpperCase(), style: style),
                    SizedBox(width: 4),
                    Icon(Icons.keyboard_arrow_right),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LogOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Material(
        color: AppColors.bgSelectorButton,
        child: InkWell(
          onTap: () {
            Provider.of<AuthViewModel>(context, listen: false)?.logOut();
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Center(child: Text('Logout', style: style)),
          ),
        ),
      ),
    );
  }
}
