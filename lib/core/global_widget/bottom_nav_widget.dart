import 'package:flutter/material.dart';

class BottomNavItemData {
  const BottomNavItemData({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({
    super.key,
    required this.selectedIndex,
    this.onItemTap,
    this.activeColor = const Color(0xFFFF4D6D),
    this.inactiveColor = const Color(0xFF8E8E8E),
    this.backgroundColor = const Color(0xFFFAFAFA),
    this.borderColor = const Color(0xFFE0E0E0),
    this.height = 70,
  });

  final int selectedIndex;
  final ValueChanged<int>? onItemTap;
  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;
  final Color borderColor;
  final double height;

  static const List<BottomNavItemData> items = [
    BottomNavItemData(icon: Icons.home_rounded, label: 'Beranda'),
    BottomNavItemData(icon: Icons.history, label: 'Riwayat'),
    BottomNavItemData(icon: Icons.support_agent_rounded, label: 'Konseling'),
    BottomNavItemData(icon: Icons.person_rounded, label: 'Profil'),
  ];

  @override
  Widget build(BuildContext context) {
    final safeBottom = MediaQuery.of(context).padding.bottom;

    return Container(
      height: height + safeBottom,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(top: BorderSide(color: borderColor, width: 1)),
      ),
      padding: EdgeInsets.only(bottom: safeBottom),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length, (index) {
          return Expanded(
            child: _NavItem(
              data: items[index],
              isActive: selectedIndex == index,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              onTap: () => onItemTap?.call(index),
            ),
          );
        }),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.data,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  final BottomNavItemData data;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? activeColor : inactiveColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(data.icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              data.label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
