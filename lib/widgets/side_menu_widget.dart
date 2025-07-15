import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/data/side_menu_data.dart';
import 'package:urps_ordein/models/menu_model.dart';
import 'package:urps_ordein/routes/routes.dart';

class SideMenuWidget extends StatefulWidget {
  const SideMenuWidget({super.key});

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  final menuList = SideMenuData.menu;

  @override
  Widget build(BuildContext context) {
    final String location = routes.routerDelegate.currentConfiguration.uri
        .toString();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(1),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: menuList.length,
              itemBuilder: (context, index) =>
                  _buildMenuItem(menuList[index], location),
            ),
          ),
          const Spacer(),
          const LogoutButton(),
        ],
      ),
    );
  }

  Widget _buildMenuItem(MenuModel item, String location) {
    final bool isTile = item.children.isEmpty;

    final bool isSelected =
        location == item.route ||
        item.children.any((child) => location == child.route);

    return isTile
        ? _buildTile(item, isSelected)
        : _buildExpansionTile(item, isSelected, location);
  }

  Widget _buildTile(MenuModel item, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutExpo,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? selectionColor : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(
                    0.12,
                  ), // subtle but noticeable
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: const Offset(0, 6),
                ),
              ]
            : [],
      ),
      child: Material(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        child: ListTile(
          leading: TweenAnimationBuilder<Color?>(
            tween: ColorTween(
              begin: textColor,
              end: isSelected ? primaryColor : textColor,
            ),
            duration: const Duration(milliseconds: 500),
            builder: (context, color, _) => Icon(item.icon, color: color),
          ),
          title: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 100),
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
            child: Text(item.title),
          ),
          onTap: () {
            if (!isSelected) context.go(item.route);
          },
        ),
      ),
    );
  }

  Widget _buildExpansionTile(
    MenuModel parent,
    bool isSelected,
    String location,
  ) {
    final bool isExpanded = location.startsWith(parent.route);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutExpo,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? selectionColor : Colors.transparent,
        // borderRadius: BorderRadius.circular(8),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(
                    0.12,
                  ), // subtle but noticeable
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: const Offset(0, 6),
                ),
              ]
            : [],
      ),
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: Material(
          // borderRadius: BorderRadius.circular(8),
          color: cardBackgroundColor,
          child: ExpansionTile(
            leading: Icon(parent.icon, color: textColor),
            title: Text(
              parent.title,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            initiallyExpanded: isExpanded,
            children: parent.children.map((child) {
              final bool isSelected = location == child.route;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected ? selectionColor : Colors.transparent,
                  // borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  leading: TweenAnimationBuilder<Color?>(
                    tween: ColorTween(
                      begin: textColor,
                      end: isSelected ? primaryColor : textColor,
                    ),
                    duration: const Duration(milliseconds: 500),
                    builder: (context, color, _) {
                      return Icon(child.icon, color: color);
                    },
                  ),
                  title: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 100),
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                    child: Text(child.title),
                  ),
                  onTap: () {
                    if (!isSelected) context.go(child.route);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: () {
          // TODO: Implement logout logic
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.logout_rounded,
                color: _isHovered ? Colors.red : textColor,
              ),
            ),
            Text(
              'Logout',
              style: TextStyle(
                fontSize: 16,
                color: _isHovered ? Colors.red : textColor,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text('v1.0.0', style: TextStyle(color: secondaryColor)),
            ),
          ],
        ),
      ),
    );
  }
}
