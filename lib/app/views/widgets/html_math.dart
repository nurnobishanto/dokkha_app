import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'mathml_converter.dart';

class MixedMathHtml extends StatefulWidget {
  final String html;
  final TextStyle? textStyle;

  const MixedMathHtml({super.key, required this.html, this.textStyle});

  @override
  State<MixedMathHtml> createState() => _MixedMathHtmlState();
}

class _MixedMathHtmlState extends State<MixedMathHtml> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final parts = _extractParts(widget.html);

    return Scrollbar(
      thickness: 5,
      trackVisibility: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: parts.map((part) {
            if (part['type'] == 'math') {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SizedBox(
                  height: 25,
                  width: 400,
                  child: ScrollbarTheme(
                    data: ScrollbarThemeData(
                      thumbColor: MaterialStateProperty.all(Colors.grey),
                      trackColor:
                          MaterialStateProperty.all(Colors.grey.shade300),
                      thickness: MaterialStateProperty.all(5),
                      radius: const Radius.circular(30),
                    ),
                    child: Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      thickness: 5,
                      trackVisibility: true,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        child: Math.tex(
                          mathmlToLatex(part['value']!),
                          mathStyle: MathStyle.text,
                          textStyle: widget.textStyle ??
                              const TextStyle(
                                  fontSize: 22, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return HtmlWidget(
                part['value']!,
                textStyle: widget.textStyle,
              );
            }
          }).toList(),
        ),
      ),
    );
  }

  List<Map<String, String>> _extractParts(String html) {
    final mathRegex = RegExp(r'<math.*?>.*?<\/math>', dotAll: true);
    final List<Map<String, String>> parts = [];
    int lastIndex = 0;

    for (final match in mathRegex.allMatches(html)) {
      if (match.start > lastIndex) {
        parts.add({
          'type': 'text',
          'value': html.substring(lastIndex, match.start),
        });
      }

      parts.add({
        'type': 'math',
        'value': match.group(0)!,
      });

      lastIndex = match.end;
    }

    if (lastIndex < html.length) {
      parts.add({
        'type': 'text',
        'value': html.substring(lastIndex),
      });
    }

    return parts;
  }
}
