import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const sxs = ['鼠', '牛', '虎', '兔', '龙', '蛇', '马', '羊', '猴', '鸡', '狗', '猪'];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String yearRowString(String sx, int year) {
    var strs = ['$sx：$year'];
    for (var i = 1; i < 6; i++) {
      final y = year + i * 12;
      strs.add(y.toString());
    }
    return strs.join('、');
  }

  @override
  Widget build(BuildContext context) {
    int year = 1948;

    List<Widget> rows = [];
    for (var element in sxs) {
      final row = Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 15,
        ),
        child: Text(
          yearRowString(element, year++),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
      rows.add(row);
    }

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 11),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rows,
          ),
          const Spacer(),
          const BottomBar(),
        ],
      ),
    );
  }
}

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedYear = 1949;
  final now = DateTime.now().year;

  String queryShengXiao(int year) {
    int idx = (year - 1949) % sxs.length;
    return sxs[idx];
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int year = 1949;

    List<int> years = [];
    List<Widget> children = [];
    while (year <= now) {
      years.add(year);
      children.add(Text('$year'));
      year++;
    }

    return SafeArea(
      child: SizedBox(
        height: 44,
        child: Row(
          children: [
            const SizedBox(width: 15),
            const Text('出生年份：'),
            TextButton(
              onPressed: () => _showDialog(
                CupertinoPicker(
                  itemExtent: 44,
                  onSelectedItemChanged: (idx) {
                    setState(() {
                      selectedYear = years[idx];
                    });
                  },
                  children: children,
                ),
              ),
              child: Text('$selectedYear'),
            ),
            TextButton(onPressed: () {}, child: const Text('查询')),
            Text(queryShengXiao(selectedYear)),
          ],
        ),
      ),
    );
  }
}
