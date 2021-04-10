import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

/// This is the main widget for this library.
///
/// it's light and effective to user
class TextLinkWidget extends StatelessWidget {
  /// your text that include link (it's required)
  final String text;

  /// custom char you need split depend on if u not passed we split by space
  final String splitChar;

  /// custom text style
  final TextStyle style;

  ///  custom text align (by default we use start alignment)
  final TextAlign textAlign;

  /// custom regular expression if you don't pass your expression we use the default expression
  final RegExp regExp;

  ///  custom text link color (by default we use blue color)
  final TextStyle textLinkStyle;

  TextLinkWidget({
    Key key,
    @required this.text,
    this.style,
    this.splitChar,
    this.regExp,
    this.textLinkStyle,
    this.textAlign,
  })  : assert(text != null),
        super(key: key);

  /// it's a function for check the link text
  bool _isLink(String input) {
    /// if you do not pass reg pattern you will use the default reg pattern
    final matcher = this.regExp ??
        RegExp(r"((https?:www\.)|(https?:\/\/)|(www\.))"
            r"[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]"
            r"{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");

    return matcher.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    final _style = this.style ?? Theme.of(context).textTheme.headline4;
    final _textAlign = this.textAlign ?? TextAlign.start;
    final words = text.split(this.splitChar ?? ' ');
    List<TextSpan> span = [];
    words.forEach((word) {
      span.add(_isLink(word)
          ? new LinkTextSpan(
              text: '$word ',
              url: word,
              style: textLinkStyle ?? _style.copyWith(color: Colors.blue),
            )
          : new TextSpan(text: '$word ', style: _style));
    });
    if (span.length > 0) {
      return new RichText(
        text: new TextSpan(text: '', children: span),
      );
    } else {
      return new Text(text, style: _style, textAlign: _textAlign);
    }
  }
}

class LinkTextSpan extends TextSpan {
  LinkTextSpan({TextStyle style, String url, String text})
      : super(
          style: style,
          text: text ?? url,
          recognizer: new TapGestureRecognizer()
            ..onTap = () async {
              try {
                if (url == null || url.isEmpty) {
                  print('The URL is $url is null or Empty');
                  return;
                }
                String trimmedUrl = url.toLowerCase().trim();
                bool isHttpsOrHttp = trimmedUrl.startsWith('https://') ||
                    trimmedUrl.startsWith('http://');
                if (!isHttpsOrHttp) url = 'http://' + url;
                if (await launcher.canLaunch(url)) {
                  print('The open URL is $url');
                  await launcher.launch(url);
                } else {
                  print('The URL is $url can not be opened');
                }
              } catch (e) {
                throw FormatException('An error was thrown $e');
              }
            },
        );
}
