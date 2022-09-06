import 'package:covid_19/pages/admin/admin_home.dart';
import 'package:covid_19/pages/admin/register.dart';
import 'package:covid_19/pages/admin/registered_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class AdminRoot extends StatefulWidget {
  int navigateIndex;
  AdminRoot({Key? key, required this.navigateIndex}) : super(key: key);

  @override
  State<AdminRoot> createState() => _AdminRootState();
}

class _AdminRootState extends State<AdminRoot> {
  int pageIndex = 0;
//  navigateIndex == null ? int pageIndex = 0:pageIndex = navigateIndex;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const Register();
            }));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 36,
          ),
        ),
        bottomNavigationBar: getFooter(size),
        body: SafeArea(
          child: getBody(),
        ));
  }

  getBody() {
    List<Widget> pages = [
      const AdminHomeScreen(),
      const Center(
        child: Text(""),
      ),
      const RegisteredUserList(),
      // const Center(
      //   child: Text("Nothing yet"),
      // ),
      // const ProfileScreen(),
    ];
    return IndexedStack(
      index: widget.navigateIndex,
      children: pages,
    );
  }

  getFooter(size) {
    List bottomItems = [
      widget.navigateIndex == 0
          ? "images/svgs/home_active.svg"
          : "images/svgs/home.svg",
      widget.navigateIndex == 1
          ? "images/svgs/blank.svg"
          : "images/svgs/blank.svg",
      widget.navigateIndex == 2
          ? "images/svgs/account_active.svg"
          : "images/svgs/account.svg",
    ];

    return Container(
      width: double.infinity,
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            bottomItems.length,
            (index) {
              return InkWell(
                onTap: () {
                  selectedTab(index);
                },
                child: SizedBox(
                  width: size.width / 6,
                  child: SvgPicture.asset(
                    bottomItems[index],
                    width: 25,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      widget.navigateIndex = index;
    });
  }
}
