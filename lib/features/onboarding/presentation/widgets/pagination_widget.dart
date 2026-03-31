import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:flutter/material.dart';

class PaginationWidget extends StatefulWidget {
  final int pageCount;
  final int initialPage;
  final Function(int) onPageChanged;
  final Color activeColor;
  final Color inactiveColor;
  final Color inactiveArrowColor;
  final Color activeBgButtonColor;

  const PaginationWidget({
    super.key,
    required this.pageCount,
    this.initialPage = 0,
    required this.onPageChanged,
    this.activeColor = StaticColor.primaryPink,
    this.inactiveColor = const Color(0xFFE5E7EB),
    this.activeBgButtonColor = const Color.fromARGB(255, 228, 228, 228),
    this.inactiveArrowColor = const Color.fromARGB(127, 255, 77, 110),
  });

  @override
  State<PaginationWidget> createState() => _PaginationState();
}

class _PaginationState extends State<PaginationWidget> {
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() => _currentPage--);
      widget.onPageChanged(_currentPage);
    }
  }

  void _nextPage() {
    if (_currentPage < widget.pageCount - 1) {
      setState(() => _currentPage++);
      widget.onPageChanged(_currentPage);
    }
  }

  void _goToPage(int page) {
    setState(() => _currentPage = page);
    widget.onPageChanged(_currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Previous arrow button
        GestureDetector(
          onTap: _previousPage,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPage == 0 ? null : widget.activeBgButtonColor,
            ),
            child: Center(
              child: Icon(
                Icons.arrow_back,
                color: _currentPage == 0
                    ? widget.inactiveArrowColor
                    : widget.activeColor,
                size: 24,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Page indicators
        ...List.generate(
          widget.pageCount,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () => _goToPage(index),
              child: Container(
                width: 48,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: _currentPage == index ? widget.activeColor : null,
                ),
                child: Center(
                  child: Text(
                    '${(index + 1).toString().padLeft(2, '0')}',
                    style: AppTypography.b2.copyWith(
                      color: _currentPage == index
                          ? StaticColor.surface
                          : StaticColor.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Next arrow button
        GestureDetector(
          onTap: _nextPage,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPage == widget.pageCount - 1
                  ? null
                  : widget.activeBgButtonColor,
            ),
            child: Center(
              child: Icon(
                Icons.arrow_forward,
                color: _currentPage == widget.pageCount - 1
                    ? widget.inactiveArrowColor
                    : widget.activeColor,
                size: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
