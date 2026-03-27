import 'package:flutter/material.dart';

enum AppInputFieldState { none, normal, success, error }

enum AppInputStatusState { none, normal, success, error }

class AppInputField extends StatefulWidget {
  const AppInputField({
    super.key,
    required this.label,
    this.hintText = 'Textfield',
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onTap,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.leading,
    this.trailing,
    this.statusText,
    this.state = AppInputFieldState.normal,
    this.statusState,
    this.enableStatusIcon = true,
    this.hideHintOnFocus = false,
    this.height = 48,
    this.width = double.infinity,
    this.borderRadius = 24,
  });

  final String label;
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final Widget? leading;
  final Widget? trailing;
  final String? statusText;
  final AppInputFieldState state;
  final AppInputStatusState? statusState;
  final bool enableStatusIcon;
  final bool hideHintOnFocus;
  final double height;
  final double width;
  final double borderRadius;

  @override
  State<AppInputField> createState() => _AppInputFieldState();
}

class _AppInputFieldState extends State<AppInputField> {
  static const Color _defaultColor = Color(0xFF8F8F8F);
  static const Color _filledColor = Color(0xFF202020);
  static const Color _successColor = Color(0xFF2AC680);
  static const Color _errorColor = Color(0xFFFF4B6E);

  late FocusNode _focusNode;
  late bool _ownsFocusNode;
  String _internalValue = '';

  bool get _isFocused => _focusNode.hasFocus;

  bool get _hasValue {
    if (widget.controller != null) {
      return widget.controller!.text.trim().isNotEmpty;
    }
    return _internalValue.trim().isNotEmpty;
  }

  Color _resolvedOutlineColor() {
    switch (widget.state) {
      case AppInputFieldState.success:
        return _successColor;
      case AppInputFieldState.error:
        return _errorColor;
      case AppInputFieldState.normal:
        
          return _filledColor;
        
        // return _defaultColor;
      case AppInputFieldState.none:
        return _defaultColor;
    }
  }

  Color _resolvedHintColor() {
    switch (widget.state) {
      case AppInputFieldState.success:
      case AppInputFieldState.error:
      case AppInputFieldState.none:
        return _defaultColor;
      case AppInputFieldState.normal:
        return _isFocused ? _filledColor : _defaultColor;
    }
  }

  Color _resolvedStatusColor() {
    switch (_effectiveStatusState) {
      case AppInputStatusState.success:
        return _successColor;
      case AppInputStatusState.error:
        return _errorColor;
      case AppInputStatusState.normal:
        return _defaultColor;
      case AppInputStatusState.none:
        return _defaultColor;
    }
  }

  Widget _defaultStatusIcon(Color color) {
    switch (_effectiveStatusState) {
      case AppInputStatusState.success:
        return Icon(Icons.check, size: 16, color: color);
      case AppInputStatusState.error:
        return Icon(Icons.warning_rounded, size: 16, color: color);
      case AppInputStatusState.normal:
        return const SizedBox.shrink();
      case AppInputStatusState.none:
        return const SizedBox.shrink();
    }
  }

  AppInputStatusState get _effectiveStatusState {
    if (widget.statusState != null) {
      return widget.statusState!;
    }

    switch (widget.state) {
      case AppInputFieldState.success:
        return AppInputStatusState.success;
      case AppInputFieldState.error:
        return AppInputStatusState.error;
      case AppInputFieldState.normal:
        return AppInputStatusState.normal;
      case AppInputFieldState.none:
        return AppInputStatusState.none;
    }
  }

  void _handleFocusChange() {
    if (mounted) {
      setState(() {});
    }
  }

  void _handleControllerChange() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _ownsFocusNode = widget.focusNode == null;
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
    widget.controller?.addListener(_handleControllerChange);
  }

  @override
  void didUpdateWidget(covariant AppInputField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.focusNode != widget.focusNode) {
      oldWidget.focusNode?.removeListener(_handleFocusChange);
      if (_ownsFocusNode) {
        _focusNode.dispose();
      }
      _ownsFocusNode = widget.focusNode == null;
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_handleFocusChange);
    }

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChange);
      widget.controller?.addListener(_handleControllerChange);
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChange);
    _focusNode.removeListener(_handleFocusChange);
    if (_ownsFocusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color outlineColor = _resolvedOutlineColor();
    final Color statusColor = _resolvedStatusColor();
    final Color hintColor = _resolvedHintColor();
    final OutlineInputBorder baseOutlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide(color: outlineColor, width: 1),
    );
    final bool showStatusIcon =
        widget.enableStatusIcon &&
        (_effectiveStatusState == AppInputStatusState.success ||
            _effectiveStatusState == AppInputStatusState.error);

    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: widget.height,
            child: TextFormField(
              controller: widget.controller,
              focusNode: _focusNode,
              onChanged: (value) {
                widget.onChanged?.call(value);
                if (widget.controller == null) {
                  setState(() {
                    _internalValue = value;
                  });
                }
              },
              onTap: widget.onTap,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              validator: widget.validator,
              obscureText: widget.obscureText,
              enabled: widget.enabled,
              readOnly: widget.readOnly,
              decoration: InputDecoration(
                hintText: widget.hideHintOnFocus && _isFocused
                    ? null
                    : widget.hintText,
                hintStyle: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: hintColor),
                prefixIcon: widget.leading == null
                    ? Icon(Icons.arrow_forward, color: outlineColor, size: 24)
                    : IconTheme.merge(
                        data: IconThemeData(color: outlineColor),
                        child: widget.leading!,
                      ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: widget.trailing == null
                      ? null
                      : IconTheme.merge(
                          data: IconThemeData(color: outlineColor),
                          child: widget.trailing!,
                        ),
                ),
                suffixIconColor: outlineColor,
                isDense: true,
                contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                border: baseOutlineBorder,
                enabledBorder: baseOutlineBorder,
                disabledBorder: baseOutlineBorder,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(color: outlineColor, width: 1.6),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: const BorderSide(color: _errorColor),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: const BorderSide(color: _errorColor, width: 1.6),
                ),
              ),
            ),
          ),
          if (widget.statusText != null &&
              widget.statusText!.trim().isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showStatusIcon) ...[
                  _defaultStatusIcon(statusColor),
                  const SizedBox(width: 6),
                ],
                Expanded(
                  child: Text(
                    widget.statusText!,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
