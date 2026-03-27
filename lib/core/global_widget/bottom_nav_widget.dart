import 'package:flutter/material.dart';

class BottomNavItemData {
  const BottomNavItemData({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({
    super.key,
    required this.items,
    required this.selectedIndex,
    this.onItemTap,
    this.onCenterTap,
    this.centerIcon = Icons.health_and_safety_outlined,
    this.centerLabel = 'Catat Gejala',
    this.activeColor = const Color(0xFFFF4D6D),
    this.inactiveColor = const Color(0xFF8E8E8E),
    this.backgroundColor = const Color(0xFFFAFAFA),
    this.borderColor = const Color(0xFFE0E0E0),
    this.height = 80,
  }) : assert(
         items.length == 4,
         'BottomNavWidget expects exactly 4 items (2 left, 2 right).',
       );

  final List<BottomNavItemData> items;
  final int selectedIndex;
  final ValueChanged<int>? onItemTap;
  final VoidCallback? onCenterTap;
  final IconData centerIcon;
  final String centerLabel;
  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;
  final Color borderColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    final safeBottom = MediaQuery.of(context).padding.bottom;

    return SizedBox(
      height: height + safeBottom,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background with curved cut-out
          Positioned.fill(
            child: CustomPaint(
              painter: _CurvedNavPainter(
                backgroundColor: backgroundColor,
                borderColor: borderColor,
              ),
            ),
          ),
          // Navigation items
          Positioned(
            left: 0,
            right: 0,
            bottom: safeBottom,
            child: SizedBox(
              height: height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left items
                  Expanded(
                    child: _NavItem(
                      data: items[0],
                      isActive: selectedIndex == 0,
                      activeColor: activeColor,
                      inactiveColor: inactiveColor,
                      onTap: () => onItemTap?.call(0),
                    ),
                  ),
                  Expanded(
                    child: _NavItem(
                      data: items[1],
                      isActive: selectedIndex == 1,
                      activeColor: activeColor,
                      inactiveColor: inactiveColor,
                      onTap: () => onItemTap?.call(1),
                    ),
                  ),
                  // Center space for floating button
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Text(
                        centerLabel,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: inactiveColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                  // Right items
                  Expanded(
                    child: _NavItem(
                      data: items[2],
                      isActive: selectedIndex == 2,
                      activeColor: activeColor,
                      inactiveColor: inactiveColor,
                      onTap: () => onItemTap?.call(2),
                    ),
                  ),
                  Expanded(
                    child: _NavItem(
                      data: items[3],
                      isActive: selectedIndex == 3,
                      activeColor: activeColor,
                      inactiveColor: inactiveColor,
                      onTap: () => onItemTap?.call(3),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Center floating button
          Positioned(
            top: -22,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: onCenterTap,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: activeColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 4,
                    ),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: activeColor.withOpacity(0.3),
                    //     blurRadius: 12,
                    //     offset: const Offset(0, 6),
                    //   ),
                    // ],
                  ),
                  child: Icon(
                    centerIcon,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
          ),
        ],
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
            Icon(
              data.icon,
              color: color,
              size: 24,
            ),
            const SizedBox(height: 6),
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

class _CurvedNavPainter extends CustomPainter {
  const _CurvedNavPainter({
    required this.backgroundColor,
    required this.borderColor,
  });

  final Color backgroundColor;
  final Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = backgroundColor;

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = borderColor;

    final centerX = size.width / 2;
    const bumpRadius = 56.0;
    const bumpHeight = 26.0;

    final path = Path()
      // Top left corner
      //..moveTo(0, cornerRadius)
      //..quadraticBezierTo(0, 0, cornerRadius, 0)
      // Top line to bump start
      ..lineTo(centerX - bumpRadius, 0)
      // Left side of bump
      ..cubicTo(
        centerX - bumpRadius * 0.6,
        0,
        centerX - bumpRadius * 0.5,
        -bumpHeight,
        centerX,
        -bumpHeight,
      )
      // Right side of bump
      ..cubicTo(
        centerX + bumpRadius * 0.5,
        -bumpHeight,
        centerX + bumpRadius * 0.6,
        0,
        centerX + bumpRadius,
        0,
      )
      // Top line to top right corner
      ..lineTo(size.width, 0)
      // Right edge
      ..lineTo(size.width, size.height)
      // Bottom edge
      ..lineTo(0, size.height)
      // Close path
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _CurvedNavPainter oldDelegate) {
    return oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.borderColor != borderColor;
  }
}