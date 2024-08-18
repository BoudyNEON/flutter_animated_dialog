import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

import 'model/list_data_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showPerformance = false;

  void onSettingCallback() {
    setState(() {
      showPerformance = !showPerformance;
    });
  }

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Animated Dialog Example';
    return MaterialApp(
      title: appTitle,
      showPerformanceOverlay: showPerformance,
      home: MyHomePage(
        title: appTitle,
        onSetting: onSettingCallback,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final VoidCallback onSetting;

  const MyHomePage({
    required this.title,
    required this.onSetting,
  });

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedIndexText = '';
  int selectIdx = 0;
  String singleSelectedIndexText = '';
  int selectIndex = 0;
  String multiSelectedIndexesText = '';
  List<int> selectedIndexes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: widget.onSetting,
          ),
        ],
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          children: [
            _buildHeader('General dialog'),
            _buildListTile('Default', () => _showDialog(context)),
            _buildDivider(),
            _buildListTile('Fade', () => _showDialog(context, DialogTransitionType.fade)),
            _buildDivider(),
            _buildListTile('Slide from top', () => _showDialog(context, DialogTransitionType.slideFromTop)),
            _buildDivider(),
            _buildListTile(
                'Slide from top and fade', () => _showDialog(context, DialogTransitionType.slideFromTopFade)),
            _buildDivider(),
            _buildListTile('Slide from bottom', () => _showDialog(context, DialogTransitionType.slideFromBottom)),
            _buildDivider(),
            _buildListTile(
                'Slide from bottom and fade', () => _showDialog(context, DialogTransitionType.slideFromBottomFade)),
            _buildDivider(),
            _buildListTile('Slide from left', () => _showDialog(context, DialogTransitionType.slideFromLeft)),
            _buildDivider(),
            _buildListTile(
                'Slide from left and fade', () => _showDialog(context, DialogTransitionType.slideFromLeftFade)),
            _buildDivider(),
            _buildListTile('Slide from right', () => _showDialog(context, DialogTransitionType.slideFromRight)),
            _buildDivider(),
            _buildListTile(
                'Slide from right and fade', () => _showDialog(context, DialogTransitionType.slideFromRightFade)),
            _buildDivider(),
            _buildListTile('Scale', () => _showDialog(context, DialogTransitionType.scale)),
            _buildDivider(),
            _buildListTile('Fade scale', () => _showDialog(context, DialogTransitionType.fadeScale)),
            _buildDivider(),
            _buildListTile('Scale rotate', () => _showDialog(context, DialogTransitionType.scaleRotate)),
            _buildDivider(),
            _buildListTile('Rotate', () => _showDialog(context, DialogTransitionType.rotate)),
            _buildDivider(),
            _buildListTile('Fade rotate', () => _showDialog(context, DialogTransitionType.fadeRotate)),
            _buildDivider(),
            _buildListTile('Rotate 3D', () => _showDialog(context, DialogTransitionType.rotate3D)),
            _buildDivider(),
            _buildListTile('Size', () => _showDialog(context, DialogTransitionType.size)),
            _buildDivider(),
            _buildListTile('Size fade', () => _showDialog(context, DialogTransitionType.sizeFade)),
            _buildDivider(),
            _buildListTile('No animation', () => _showDialog(context, DialogTransitionType.none)),
            _buildDivider(),
            _buildHeader('Classic dialog widget'),
            _buildListTile('General dialog', () => _showDialog(context, DialogTransitionType.size, Curves.linear)),
            _buildDivider(),
            _buildListTile('List dialog ${_formattedIndexText(selectedIndexText)}', () async {
              int? index = await _showListDialog(context);
              setState(() {
                selectIdx = index ?? selectIdx;
                selectedIndexText = '$selectIdx';
              });
            }),
            _buildDivider(),
            _buildListTile('List single select${_formattedIndexText(singleSelectedIndexText)}', () async {
              int? index = await _showSingleSelectListDialog(context);
              setState(() {
                selectIndex = index ?? selectIndex;
                singleSelectedIndexText = '$selectIndex';
              });
            }),
            _buildDivider(),
            _buildListTile('List multiple select${_formattedIndexText(multiSelectedIndexesText)}', () async {
              List<int>? indexes = await _showMultiSelectListDialog(context);
              setState(() {
                selectedIndexes = indexes ?? selectedIndexes;
                multiSelectedIndexesText = selectedIndexes.isNotEmpty ? selectedIndexes.toString() : '';
              });
            }),
            _buildDivider(),
            _buildListTile('Custom dialog', () => _showCustomDialog(context)),
            _buildDivider(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String text) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.only(left: 15.0),
      height: 35.0,
      alignment: Alignment.centerLeft,
      child: Text(text),
      color: const Color(0xFFDDDDDD),
    );
  }

  Widget _buildListTile(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(height: 0.5);
  }

  String _formattedIndexText(String text) {
    return text.isNotEmpty ? '(index: $text)' : '';
  }

  Future<void> _showDialog(BuildContext context,
      [DialogTransitionType type = DialogTransitionType.none, Curve curve = Curves.fastOutSlowIn]) {
    return showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ClassicGeneralDialogWidget(
          titleText: 'Title',
          contentText: 'content',
          onPositiveClick: () => Navigator.of(context).pop(),
          onNegativeClick: () => Navigator.of(context).pop(),
        );
      },
      animationType: type,
      curve: curve,
      duration: Duration(seconds: 1),
    );
  }

  Future<int?> _showListDialog(BuildContext context) {
    return showAnimatedDialog<int>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ClassicListDialogWidget<ListDataModel>(
          titleText: 'Title',
          dataList: List.generate(2, (index) => ListDataModel(name: 'Name$index', value: 'Value$index')),
          onPositiveClick: () => Navigator.of(context).pop(),
          onNegativeClick: () => Navigator.of(context).pop(),
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.linear,
    );
  }

  Future<int?> _showSingleSelectListDialog(BuildContext context) {
    return showAnimatedDialog<int>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ClassicListDialogWidget<ListDataModel>(
          titleText: 'Title',
          listType: ListType.singleSelect,
          activeColor: Colors.red,
          selectedIndex: selectIndex,
          dataList: List.generate(20, (index) => ListDataModel(name: 'Name$index', value: 'Value$index')),
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.linear,
    );
  }

  Future<List<int>?> _showMultiSelectListDialog(BuildContext context) {
    return showAnimatedDialog<List<int>>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ClassicListDialogWidget<ListDataModel>(
          titleText: 'Title',
          listType: ListType.multiSelect,
          selectedIndexes: selectedIndexes,
          activeColor: Colors.green,
          dataList: List.generate(20, (index) => ListDataModel(name: 'Name$index', value: 'Value$index')),
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.linear,
    );
  }

  void _showCustomDialog(BuildContext context) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: ListBody(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                width: 200.0,
                child: FlutterLogo(size: 150.0),
              ),
            ],
          ),
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.linear,
    );
  }
}
