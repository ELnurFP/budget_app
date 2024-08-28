import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_budget_app/budget_app.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({
    super.key,
    required this.text,
    this.onTap,
    this.leading,
    this.trailing,
    this.iconSpacing = 8.0,
    this.busy = false,
    this.disabled = false,
    this.color,
  }) : _isOutlined = false;

  const StyledButton.outlined({
    super.key,
    required this.text,
    this.onTap,
    this.leading,
    this.trailing,
    this.iconSpacing = 8.0,
    this.busy = false,
    this.disabled = false,
    this.color,
  }) : _isOutlined = true;

  final String text;
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? trailing;
  final double iconSpacing;
  final bool busy;
  final bool disabled;
  final Color? color;

  final bool _isOutlined;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: disabled || busy,
      child: FilledButton.tonal(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          overlayColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          fixedSize: Size(context.width, 48.0),
          side: _isOutlined
              ? const BorderSide(
                  color: blue,
                  width: 1.0,
                )
              : null,
          backgroundColor: color ??
              (_isOutlined
                  ? Colors.transparent
                  : disabled
                      ? primary.withOpacity(.5)
                      : primary),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Builder(
          builder: (context) {
            if (busy) {
              return const CupertinoActivityIndicator(
                color: Colors.white,
              );
            }

            final textWidget = Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                height: 28.0 / 14.0,
                color: _isOutlined ? blue : Colors.white,
                fontWeight: FontWeight.w500,
              ),
            );

            if (leading == null && trailing == null) {
              return textWidget;
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leading != null) leading!,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: iconSpacing),
                  child: textWidget,
                ),
                if (trailing != null) trailing!,
              ],
            );
          },
        ),
      ),
    );
  }
}
