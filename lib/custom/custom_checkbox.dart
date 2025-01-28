import 'package:flutter/material.dart';

import 'container_custom.dart';

class CustomCheckBox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color checkedIconColor;
  final Color checkedFillColor;
  final IconData checkedIcon;
  final Color uncheckedIconColor;
  final Color uncheckedFillColor;
  final IconData uncheckedIcon;
  final double? borderWidth;
  final double checkBoxSize;
  final bool shouldShowBorder;
  final Color? borderColor;
  final double? borderRadius;
  final double marginLeft;
  final double marginTop;
  final double marginRight;
  final double marginBottom;
  // final double?

  const CustomCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
    this.checkedIconColor = Colors.white,
    this.checkedFillColor = Colors.green,
    this.checkedIcon = Icons.check,
    this.uncheckedIconColor = Colors.white,
    this.uncheckedFillColor = Colors.white,
    this.uncheckedIcon = Icons.close,
    this.borderWidth,
    this.checkBoxSize = 24,
    this.shouldShowBorder = false,
    this.borderColor,
    this.borderRadius,
    this.marginLeft = 0,
    this.marginTop = 0,
    this.marginRight = 0,
    this.marginBottom = 0,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  late bool _checked;
  late CheckStatus _status;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(CustomCheckBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    _init();
  }

  void _init() {
    _checked = widget.value;
    if (_checked) {
      _status = CheckStatus.checked;
    } else {
      _status = CheckStatus.unchecked;
    }
  }

  Widget _buildIcon() {
    late Color fillColor;
    late Color iconColor;
    late IconData iconData;

    switch (_status) {
      case CheckStatus.checked:
        fillColor = widget.checkedFillColor;
        iconColor = widget.checkedIconColor;
        iconData = widget.checkedIcon;
        break;
      case CheckStatus.unchecked:
        fillColor = widget.uncheckedFillColor;
        iconColor = widget.uncheckedIconColor;
        iconData = widget.uncheckedIcon;
        break;
    }

    return ContainerCustom(
      callback: () => widget.onChanged(!_checked),
      width: widget.checkBoxSize,
      height: widget.checkBoxSize,
      marginLeft: widget.marginLeft,
      marginRight: widget.marginRight,
      marginTop: widget.marginTop,
      marginBottom: widget.marginBottom,
      bgColor: fillColor,
      borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius ?? 6)),
      border: Border.all(
        color: widget.shouldShowBorder
            ? (widget.borderColor ?? Colors.teal.withOpacity(0.6))
            : (!widget.value
                ? (widget.borderColor ?? Colors.teal.withOpacity(0.6))
                : Colors.transparent),
        width: widget.shouldShowBorder ? widget.borderWidth ?? 2.0 : 1.0,
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: widget.checkBoxSize - 5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildIcon();
  }
}

enum CheckStatus {
  checked,
  unchecked,
}
