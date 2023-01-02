// ignore_for_file: deprecated_member_use
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopmobile/ui/features/chat/screens/profile_screen.dart';
import '../pages/CallsPage.dart';
import '../pages/ContactsPage.dart';
import '../pages/MeesagesPage.dart';
import '../pages/NotificationPage.dart';
import '../theme.dart';
import 'package:shopmobile/ui/features/chat/app.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> pageTitle = ValueNotifier("Messages");

  final List pages = [
    MessagesPage(),
    const NotificationPage(),
    const CallsPage(),
   const ContactsPage()
  ];

  final List titles = const ["Messages", "Notification", "Calls", "Contacts"];

  void _onChangesNavigationSelected(i) {
    pageTitle.value = titles[i];
    pageIndex.value = i;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: ValueListenableBuilder(
          valueListenable: pageTitle,
          builder: (context, String value, child) => Text(value),
        ),
        leadingWidth: 54,
        // leading: Align(
        //   alignment: Alignment.centerRight,
        //   child: IconBackground(
        //     icon: Icons.search,
        //     onTap: () {},
        //   ),
        // ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Hero(
              tag: "hero-profile-picture",
              child: Avatar.small(
                url: context.currentUserImage,
                onTap: () {
                  Navigator.of(context).push(ProfileScreen.route);
                },
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: _onChangesNavigationSelected,
      ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (context, int value, child) => pages[value],
      ),
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({
    required this.onItemSelected,
    Key? key,
  }) : super(key: key);
  final ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;

  void handleSelected(int i) {
    setState(() {
      selectedIndex = i;
    });
    widget.onItemSelected(i);
  }

  @override
  Widget build(BuildContext context) {
    var britness = Theme.of(context).brightness;
    return Card(
      color: (britness == Brightness.light ? Colors.transparent : null),
      margin: EdgeInsets.zero,
      elevation: 0,
      child: SafeArea(
          top: false,
          bottom: true,
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _BottomNavigationBarItem(
                  isSelected: (selectedIndex == 0),
                  index: 0,
                  onTap: handleSelected,
                  icon: CupertinoIcons.bubble_left_bubble_right_fill,
                  lable: "Messages",
                ),
                _BottomNavigationBarItem(
                  isSelected: (selectedIndex == 1),
                  index: 1,
                  onTap: handleSelected,
                  icon: CupertinoIcons.bell_solid,
                  lable: "Notifications",
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GlowingActionButton(
                    onPressed: () {

                      showDialog(









                        context: context,


                        builder: (BuildContext context) => const Dialog(
                          child: AspectRatio(
                            aspectRatio: 8 / 7,
                            child: ContactsPage(),
                          ),
                        ),
                      );
                    },
                    icon: CupertinoIcons.add,
                    color: AppColors.secondary,
                  ),
                ),
                _BottomNavigationBarItem(
                  isSelected: (selectedIndex == 2),
                  index: 2,
                  onTap: handleSelected,
                  icon: CupertinoIcons.phone_fill,
                  lable: "Calls",
                ),
                _BottomNavigationBarItem(
                  isSelected: (selectedIndex == 3),
                  index: 3,
                  onTap: handleSelected,
                  icon: CupertinoIcons.person_2_fill,
                  lable: "Contacts",
                ),
              ],
            ),
          )),
    );
  }
}

class _BottomNavigationBarItem extends StatelessWidget {
  const _BottomNavigationBarItem(
      {Key? key,
      required this.icon,
      required this.lable,
      required this.index,
      required this.onTap,
      this.isSelected = false})
      : super(key: key);
  final IconData icon;
  final String lable;
  final int index;
  final ValueChanged<int> onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.secondary : null,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(lable,
                style: isSelected
                    ? const TextStyle(
                        fontSize: 11,
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold)
                    : const TextStyle(fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
