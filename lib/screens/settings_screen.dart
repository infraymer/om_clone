import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:tinder/model/gender.dart';
import 'package:tinder/photo/model/app_photo.dart';
import 'package:tinder/photo/view/ui/screen/photo_screen.dart';
import 'package:tinder/resources/colors.dart';
import 'package:tinder/resources/images.dart';
import 'package:tinder/view_model/auth_controller.dart';
import 'package:tinder/view_model/settings_controller.dart';
import 'package:tinder/widgets/app_photo.dart';
import 'package:tinder/widgets/circle_container.dart';
import 'package:tinder/widgets/dialog/dialogs.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                _AppBar(),
                _Content(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Error extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SettingsController>(context, listen: false);
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

class GetVersionAppInfo extends StatefulWidget {
  @override
  _GetVersionAppInfoState createState() => _GetVersionAppInfoState();
}

class _GetVersionAppInfoState extends State<GetVersionAppInfo> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Image(
            image: AssetImage('assets/icons/fire-icon-png-25.jpg'),
            repeat: ImageRepeat.noRepeat,
            width: 40.0,
            height: 40.0,
          ),
          Text('Version ${_packageInfo.version}'),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = SettingsController.to;
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              '${model.user.name}, ${model.user.age}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          _Description(),
          SizedBox(height: 20),
          _Divider(),
          SizedBox(height: 20),
          _MaximumDistance(),
          _AgeRange(),
          SizedBox(height: 10),
          Obx(
            () => _SelectorButton(
              title: 'Show Me',
              value: model.gender.value.name,
              onTap: () async {
                final gender = await Dialogs.showGenderDialog(context);
                if (gender == null) return;
                model.setGender(gender);
              },
            ),
          ),
          _SelectorButton(
            title: 'Privacy Policy',
            onTap: () {
              model.launchUrl('https://onematch.app/privacy-policy.html');
            },
          ),
          _SelectorButton(
              title: 'Terms of Service',
              onTap: () {
                model.launchUrl('https://onematch.app/terms-conditions.html');
              }),
          SizedBox(height: 20),
          _RemoveUserButton(),
          SizedBox(height: 20),
          _LogOutButton(),
          GetVersionAppInfo(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = SettingsController.to;
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
                Obx(
                  () => Opacity(
                    opacity: model.isLoading.value ? 1 : 0,
                    child: Container(
                      margin: EdgeInsets.only(right: 16),
                      alignment: Alignment.centerRight,
                      width: 24,
                      height: 24,
                      child: FittedBox(
                        child: CircularProgressIndicator(),
                      ),
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
    final model = SettingsController.to;
    final user = model.user;
    return GestureDetector(
      onTap: _onChangePhoto,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IntrinsicHeight(
            child: IntrinsicWidth(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(500),
                    child: Container(
                      color: Colors.grey,
                      child: GetX<SettingsController>(
                        builder: (_) =>
                            SettingsController.to.photos.value.isEmpty
                                ? Image.network(
                                    user.imgs.firstOrNull ?? '',
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  )
                                : Container(
                                    width: 100,
                                    height: 100,
                                    child: AppImageWidget(
                                      image: SettingsController
                                          .to.photos.firstOrNull,
                                    ),
                                  ),
                      ),
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
      ),
    );
  }

  _onChangePhoto() async {
    List<AppPhoto> currentImages =
        SettingsController.to.user.imgs.map((e) => AppPhoto(url: e)).toList();
    currentImages = SettingsController.to.photos.isNotEmpty
        ? SettingsController.to.photos.value
        : currentImages;
    final List<AppPhoto> images =
        await Get.to(PhotoScreen(initPhotos: currentImages));
    if (images == null) return;
    SettingsController.to.photos.value = images;
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
    final data = Provider.of<SettingsController>(context, listen: false).user;
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
    final model = SettingsController.to;
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
            textCapitalization: TextCapitalization.sentences,
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
    final model = SettingsController.to;
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
              Obx(() => Text('${model.distance.value} km')),
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
    final model = SettingsController.to;
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
              Obx(() => Text('${model.minAge.value}-${model.maxAge.value}')),
            ],
          )
        ],
      ),
    );
  }
}

class _Slider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => FlutterSlider(
          values: [SettingsController.to.distance.value.toDouble()],
          max: 100,
          min: 2,
          handler: _handlerSlider,
          trackBar: _trackBar,
          onDragCompleted: (handlerIndex, lowerValue, upperValue) {
            SettingsController.to.distance.value = lowerValue.toInt();
          },
        ));
  }
}

class _SliderDouble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FlutterSlider(
        values: [
          SettingsController.to.minAge.value.toDouble(),
          SettingsController.to.maxAge.value.toDouble(),
        ],
        max: 99,
        min: 18,
        rangeSlider: true,
        handler: _handlerSlider,
        rightHandler: _handlerSlider,
        trackBar: _trackBar,
        onDragCompleted: (handlerIndex, lowerValue, upperValue) {
          SettingsController.to.minAge.value = lowerValue.toInt();
          SettingsController.to.maxAge.value = upperValue.toInt();
        },
      ),
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

class _RemoveUserButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Material(
        color: AppColors.bgSelectorButton,
        child: InkWell(
          onTap: () {
            Get.defaultDialog(
              title: 'Do you want delete account?',
              content: SizedBox(),
              buttonColor: Colors.white,
              onConfirm: () async {
                Get..back();
                await AuthController.to.removeUser();
                Get..back();
              },
              onCancel: () {},
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Center(child: Text('Delete account', style: style)),
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
            Get.defaultDialog(
              title: 'Do you want log out?',
              content: SizedBox(),
              buttonColor: Colors.white,
              onConfirm: () async {
                Get..back();
                await AuthController.to.logOut();
                Get..back();
              },
              onCancel: () {},
            );
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
