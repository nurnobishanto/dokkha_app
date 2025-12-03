import 'package:xml/xml.dart';

String mathmlToLatex(String mathml) {
  if (mathml.trim().isEmpty) return '';

  try {
    final document = XmlDocument.parse(mathml);
    final mathElement = document.findAllElements('math').firstOrNull;
    if (mathElement == null) return r'Invalid MathML';

    return _convertNode(mathElement).trim();
  } catch (e) {
    return 'Error';
  }
}

String _convertNode(XmlNode node) {
  if (node is XmlText) {
    final t = node.text.trim();
    return t.isNotEmpty ? escapeText(t) : '';
  }
  if (node is! XmlElement) return '';

  final tag = node.localName;
  final children = node.children;

  switch (tag) {
    case 'math':
    case 'mrow':
    case 'mstyle':
    case 'semantics':
      if (_isFencedGroup(node)) {
        final inner = node.children
            .whereType<XmlElement>()
            .where((e) => e.localName != 'mo')
            .map(_convertNode)
            .join();
        return '\\left($inner\\right)';
      }
      return children.map(_convertNode).join();

    case 'mi':
      final text = children.map(_convertNode).join().trim();
      return text.length <= 2 ? text : '\\mathrm{$text}';

    case 'mn':
      return children.map(_convertNode).join();

    case 'mo':
      final op = children.map(_convertNode).join().trim();
      return _formatOperator(op);

    case 'mfrac':
      final n = _getChild(node, 0);
      final d = _getChild(node, 1);
      return '\\frac{${_convertNode(n)}}{${_convertNode(d)}}';

    case 'msup':
      final base = _getChild(node, 0);
      final sup = _getChild(node, 1);
      return '{${_convertNode(base)}}^{${_convertNode(sup)}}';

    case 'msub':
      final base = _getChild(node, 0);
      final sub = _getChild(node, 1);
      return '{${_convertNode(base)}}_{${_convertNode(sub)}}';

    case 'msubsup':
      final base = _getChild(node, 0);
      final sub = _getChild(node, 1);
      final sup = _getChild(node, 2);
      return '{${_convertNode(base)}}_{${_convertNode(sub)}}^{${_convertNode(sup)}}';

    case 'munderover':
      final op = _getChild(node, 0);
      final under = _getChild(node, 1);
      final over = _getChild(node, 2);
      final opText = _convertNode(op);
      return '${opText}_{${_convertNode(under)}}^{${_convertNode(over)}}';

    case 'munder':
      final base = _getChild(node, 0);
      final under = _getChild(node, 1);
      final baseText = _convertNode(base);
      if (baseText == 'lim') {
        return '\\lim_{${_convertNode(under)}}';
      }
      return '\\underset{${_convertNode(under)}}{${baseText}}';

    case 'mover':
      final base = _getChild(node, 0);
      final over = _getChild(node, 1);
      return '\\overset{${_convertNode(over)}}{${_convertNode(base)}}';

    case 'msqrt':
      return '\\sqrt{${children.map(_convertNode).join()}}';

    case 'mroot':
      final base = _getChild(node, 0);
      final index = _getChild(node, 1);
      return '\\sqrt[${_convertNode(index)}]{${_convertNode(base)}}';

    case 'mtable':
      final rows = node.children
          .whereType<XmlElement>()
          .where((e) => e.localName == 'mtr');
      final latexRows = rows.map((row) {
        final cells = row.children
            .whereType<XmlElement>()
            .where((e) => e.localName == 'mtd');
        return cells.map((c) => _convertNode(c)).join(' & ');
      }).join(' \\\\ ');
      final parent = node.parentElement;
      final isBinomial = parent?.localName == 'mrow' &&
          parent?.children
                  .whereType<XmlElement>()
                  .any((e) => e.localName == 'mo' && _convertNode(e) == '(') ==
              true;
      return isBinomial
          ? '\\binom{$latexRows}'
          : '\\begin{matrix}$latexRows\\end{matrix}';

    case 'mtr':
    case 'mtd':
      return children.map(_convertNode).join();

    case 'mtext':
      return '\\text{${children.map(_convertNode).join()}}';

    default:
      return children.map(_convertNode).join();
  }
}

// Helpers
XmlNode _getChild(XmlElement el, int index) =>
    el.children.whereType<XmlElement>().toList()[index];

String _formatOperator(String op) {
  if (['-', '−', '–', '−', '−'].contains(op.trim())) {
    return ' - ';
  }
  return switch (op) {
    '+' => ' + ',
    // '-' => ' - ',
    '×' => '\\times ',
    '·' => '\\cdot ',
    '÷' => '\\div ',
    '±' => '\\pm ',
    '=' => ' = ',
    '→' => '\\to ',
    '(' => '\\left(',
    ')' => '\\right)',
    '[' => '\\left[',
    ']' => '\\right]',
    '{' => '\\left\\{',
    '}' => '\\right\\}',
    '|' => '\\left|',
    _ => op,
  };
}

bool _isFencedGroup(XmlElement el) {
  if (el.localName != 'mrow') return false;
  final moList = el.children
      .whereType<XmlElement>()
      .where((e) => e.localName == 'mo')
      .toList();
  if (moList.length < 2) return false;
  final first = moList.first.innerText.trim();
  final last = moList.last.innerText.trim();
  return (first == '(' && last == ')') ||
      (first == '[' && last == ']') ||
      (first == '{' && last == '}');
}

String escapeText(String s) {
  return s
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&', r'\&')
      .replaceAll('%', r'\%')
      .replaceAll('\$', r'\$')
      .replaceAll('#', r'\#')
      .replaceAll('_', r'\_')
      .replaceAll('{', r'\{')
      .replaceAll('}', r'\}')
      .replaceAll('~', r'\~{}')
      .replaceAll('^', r'\^{}');
}
