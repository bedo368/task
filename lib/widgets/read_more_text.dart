import 'package:flutter/material.dart';

// ويدجت مخصص لعرض النص مع خيار "قراءة المزيد"
class ReadMoreText extends StatefulWidget {
  final String text; // The text to be displayed
  final int maxLines; // Maximum number of lines to display before truncating
  final TextStyle? style; // Style for the text
  final TextStyle? readmeStyle; // Style for the "Read more" text

  // Constructor
  // البناء
  const ReadMoreText({
    super.key,
    required this.text,
    this.maxLines = 2, // Default to 2 lines before truncating
    this.style = const TextStyle(), // Default to an empty text style
    this.readmeStyle = const TextStyle(), // Default to an empty text style
  });

  @override
  createState() => _ReadMoreTextState(); // Create state for the widget
  // إنشاء حالة للويدجت
}

// State class for ReadMoreText widget
// حالة الويدجت لـ ReadMoreText
class _ReadMoreTextState extends State<ReadMoreText> {
  late bool _isExpanded; // Flag to track if text is expanded
  // علم لتتبع حالة توسيع النص

  @override
  void initState() {
    super.initState();
    _isExpanded = false; // Set initial expansion state
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Text(
            widget.text, // Display the text
            style: widget.style, // Apply the specified text style
            softWrap: true,
            textAlign: TextAlign.start,
            overflow:
                _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            maxLines: _isExpanded
                ? null
                : widget.maxLines, // Truncate text if not expanded
          ),
        ),
        // Display "Read more" option if text exceeds maximum lines
        // عرض خيار "قراءة المزيد" إذا تجاوز النص الحد الأقصى للأسطر
        if (_getNumberOfLines(context, widget.text, widget.style!) >
            widget.maxLines)
          _buildReadMoreOption(context),
      ],
    );
  }

  // Function to build the "Read more" option
  // دالة لبناء خيار "قراءة المزيد"
  Widget _buildReadMoreOption(BuildContext context) {
    return Transform.translate(
      offset: Offset(
          !_isExpanded
              ? 0
              : -MediaQuery.of(context).size.width +
                  95 +
                  MediaQuery.of(context).size.width * .045,
          !_isExpanded ? -20 : 0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded; // Toggle text expansion
            });
          },
          child: Container(
            padding: const EdgeInsets.only(left: 5),
            color: Colors.white,
            child: Text(
              _isExpanded
                  ? 'Read less'
                  : '... Read more', // Display appropriate text based on expansion state
              style: widget.readmeStyle, // Apply the specified style
            ),
          ),
        ),
      ),
    );
  }

  // Function to calculate the number of lines in the text
  // الدالة لحساب عدد الأسطر في النص
  int _getNumberOfLines(
      BuildContext context, String textCalc, TextStyle textStyle) {
    // Create a TextPainter object
    // إنشاء كائن TextPainter
    final textPainter = TextPainter(
      text: TextSpan(
          text: textCalc,
          style: textStyle), // Use the same text style as your Text widget
      maxLines: 999, // A very high number of lines
      textDirection: TextDirection.ltr,
    );

    // Layout the text
    // تخطيط النص
    textPainter.layout(maxWidth: MediaQuery.of(context).size.width);

    // Return the actual number of lines
    // إرجاع عدد الأسطر الفعلي
    return textPainter.computeLineMetrics().length;
  }
}
