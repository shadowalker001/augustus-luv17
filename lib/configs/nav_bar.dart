import 'package:flutter/material.dart';
import 'package:luvit/configs/model.dart';
import 'package:luvit/configs/theme.dart';

class NavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTap;

  const NavBar({
    super.key,
    required this.pageIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0.0,
      child: ClipRRect(
        // borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            border: Border(
              top: BorderSide(width: 1, color: Colors.grey),
            ),
          ),
          height: 60,
          child: Row(
            children: [
              navItem(
                '홈',
                imageFileLoc: CommonAssets.home,
                // Icons.home_filled,
                pageIndex == 0,
                onTap: () => onTap(0),
              ),
              navItem(
                '스팟',
                imageFileLoc: CommonAssets.location,
                // Icons.location_on_outlined,
                pageIndex == 1,
                onTap: () => onTap(1),
              ),
              const SizedBox(width: 80),
              navItem(
                '채팅',
                imageFileLoc: CommonAssets.message,
                // Icons.message,
                pageIndex == 2,
                onTap: () => onTap(2),
              ),
              navItem(
                '마이',
                imageFileLoc: CommonAssets.user,
                // Icons.person_2_outlined,
                pageIndex == 3,
                onTap: () => onTap(3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget navItem(
    // IconData icon,
    String text,
    bool selected, {
    required String imageFileLoc,
    Function()? onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(
            //   icon,
            //   color: selected
            //       ? CustomTheme.appColor
            //       : Colors.white.withOpacity(0.4),
            // ),
            ImageIcon(
              AssetImage(imageFileLoc),
              color: selected
                  ? CustomTheme.appColor
                  : Colors.white.withOpacity(0.4),
            ),
            Text(
              text,
              style: TextStyle(
                color: selected
                    ? CustomTheme.appColor
                    : Colors.white.withOpacity(0.4),
              ),
            )
          ],
        ),
      ),
    );
  }
}
