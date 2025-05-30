import 'package:flutter/material.dart';

const _tooltipWaitDuration = Duration(milliseconds: 300);

class FlowyTooltip extends StatelessWidget {
  const FlowyTooltip({
    super.key,
    this.message,
    this.richMessage,
    this.preferBelow,
    this.margin,
    this.verticalOffset,
    this.child,
  });

  final String? message;
  final InlineSpan? richMessage;
  final bool? preferBelow;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final double? verticalOffset;

  @override
  Widget build(BuildContext context) {
    if (message == null && richMessage == null) {
      return child ?? const SizedBox.shrink();
    }

    return Tooltip(
      margin: margin,
      verticalOffset: verticalOffset ?? 16.0,
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: context.tooltipBackgroundColor(),
        borderRadius: BorderRadius.circular(10.0),
      ),
      waitDuration: _tooltipWaitDuration,
      message: message,
      textStyle: message != null ? context.tooltipTextStyle() : null,
      richMessage: richMessage,
      preferBelow: preferBelow,
      child: child,
    );
  }
}

extension FlowyToolTipExtension on BuildContext {
  double tooltipFontSize() => 14.0;
  double tooltipHeight({double? fontSize}) =>
      20.0 / (fontSize ?? tooltipFontSize());
  Color tooltipFontColor() => Theme.of(this).brightness == Brightness.light
      ? Colors.white
      : Colors.black;

  TextStyle? tooltipTextStyle({Color? fontColor, double? fontSize}) {
    return Theme.of(this).textTheme.bodyMedium?.copyWith(
          color: fontColor ?? tooltipFontColor(),
          fontSize: fontSize ?? tooltipFontSize(),
          fontWeight: FontWeight.w400,
          height: tooltipHeight(fontSize: fontSize),
          leadingDistribution: TextLeadingDistribution.even,
        );
  }

  TextStyle? tooltipHintTextStyle({double? fontSize}) => tooltipTextStyle(
        fontColor: tooltipFontColor().withValues(alpha: 0.7),
        fontSize: fontSize,
      );

  Color tooltipBackgroundColor() =>
      Theme.of(this).brightness == Brightness.light
          ? const Color(0xFF1D2129)
          : const Color(0xE5E5E5E5);
}
