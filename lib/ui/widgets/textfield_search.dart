
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

typedef OnTap = void Function(int index, String value);
typedef SubmitResults = void Function(
    String searchText, List<String> searchResults);

///Class for adding AutoSearchInput to your project
class AdvancedTextField extends StatefulWidget {
  ///List of data that can be searched through for the results
  final List<String> data;

  ///The max number of elements to be displayed when the TextField is clicked
  final int maxElementsToDisplay;

  ///The color of text which actually appears in the results for which the text
  ///is typed
  final Color? selectedTextColor;

  ///The color of text which actually appears in the results for the
  ///remaining text
  final Color? unSelectedTextColor;

  ///Color of the border when the TextField is enabled
  final Color? enabledBorderColor;

  ///Color of the border when the TextField is disabled
  final Color? disabledBorderColor;

  ///Color of the border when the TextField is being integrated with
  final Color? focusedBorderColor;

  ///Color of the cursor
  final Color? cursorColor;

  ///Border Radius of the TextField and the resultant elements
  final double borderRadius;

  ///Font Size for both the text in the TextField and the results
  final double fontSize;

  ///Height of a single item in the resultant list
  final double singleItemHeight;

  ///Number of items to be shown when the TextField is tapped
  final int itemsShownAtStart;

  ///Hint text to show inside the TextField
  final String hintText;

  ///Boolean to set autoCorrect
  final bool autoCorrect;

  ///Boolean to set whether the TextField is enabled
  final bool enabled;

  ///onSubmitted function
  final SubmitResults? onSubmitted;

  ///Function to call when a certain item is clicked
  /// Takes in a parameter of the item which was clicked
  final OnTap onItemTap;

  /// Callback to be called when the user clears his search
  final Function onSearchClear;
  /// Function to be called on editing the text field
  final SubmitResults? onEditingProgress;

  /// Text Inout Background Color
  final Color? inputTextFieldBgColor;

  ///List Background Color
  final Color searchResultsBgColor;

  final SearchMode searchMode;

  final bool caseSensitive;

  final int minLettersForSearch;

  final Color borderColor;

  final Color hintTextColor;

  final bool clearSearchEnabled;

  final bool showListOfResults;

  final bool hideHintOnTextInputFocus;

  final double verticalPadding;

  final double horizontalPadding;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final bool autoFocus;

  const AdvancedTextField({
    this.autoFocus=false,
    required this.controller,
    required this.textInputAction,
    required this.data,
    required this.maxElementsToDisplay,
    required this.onItemTap,
    required this.onSearchClear,
    this.selectedTextColor=const Color(0xFF3363D9),
    this.unSelectedTextColor=Colors.black54,
    this.enabledBorderColor=Colors.transparent,
    this.disabledBorderColor=Colors.transparent,
    this.focusedBorderColor=Colors.blue,
    this.cursorColor=Colors.blueGrey,
    this.borderRadius = 12.0,
    this.fontSize = 14.0,
    this.singleItemHeight = 50.0,
    this.itemsShownAtStart = 10,
    this.hintText = '',
    this.autoCorrect = false,
    this.enabled = true,
    this.onSubmitted,
    this.onEditingProgress,
    this.inputTextFieldBgColor=Colors.white10,
    this.searchResultsBgColor = const Color(0xFAFAFA),
    this.searchMode = SearchMode.CONTAINS,
    this.caseSensitive = false,
    this.minLettersForSearch = 0,
    this.borderColor = Colors.transparent,
    this.hintTextColor = Colors.grey,
    this.clearSearchEnabled = true,
    this.showListOfResults = true,
    this.hideHintOnTextInputFocus = true,
    this.verticalPadding = 10,
    this.horizontalPadding = 10,
  }) : assert(data != null, maxElementsToDisplay != null);

  @override
  _AdvancedTextFieldState createState() => _AdvancedTextFieldState();
}

class _AdvancedTextFieldState extends State<AdvancedTextField> {
  List<String> results = [];
  bool isItemClicked = false;
  String lastSubmittedText = "";
  String? hintText;

  late final TextEditingController controller ;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    controller..addListener(onSearchTextChanges);

    hintText = widget.hintText;

    var keyboardVisibilityController = KeyboardVisibilityController();

    // Subscribe
    keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        if (!visible) {
          if (controller.text != null) {
            sendSubmitResults(controller.text);
          }
          FocusScope.of(context).unfocus();
          if (widget.hideHintOnTextInputFocus) {
            setState(() {
              hintText = widget.hintText;
            });
          }
        } else {
          if (widget.hideHintOnTextInputFocus) {
            setState(() {
              hintText = "";
            });
          }
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _getRichText(String result) {
    String textSelected = "";
    String textBefore = "";
    String textAfter = "";
    try {
      String lowerCaseResult =
      widget.caseSensitive ? result : result.toLowerCase();
      String lowerCaseSearchText = widget.caseSensitive
          ? controller.text
          : controller.text.toLowerCase();
      textSelected = result.substring(
          lowerCaseResult.indexOf(lowerCaseSearchText),
          lowerCaseResult.indexOf(lowerCaseSearchText) +
              lowerCaseSearchText.length);
      String loserCaseTextSelected =
      widget.caseSensitive ? textSelected : textSelected.toLowerCase();
      textBefore =
          result.substring(0, lowerCaseResult.indexOf(loserCaseTextSelected));
      if (lowerCaseResult.indexOf(loserCaseTextSelected) + textSelected.length <
          result.length) {
        textAfter = result.substring(
            lowerCaseResult.indexOf(loserCaseTextSelected) +
                textSelected.length,
            result.length);
      }
    } catch (e) {
      print(e.toString());
    }
    return Container(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: controller.text.length > 0
            ? TextSpan(
          children: [
            if (controller.text.length > 0)
              TextSpan(
                text: textBefore,
                style: TextStyle(
                  fontSize: widget.fontSize,
                  color: widget.unSelectedTextColor != null
                      ? widget.unSelectedTextColor
                      : Colors.grey[400],
                ),
              ),
            TextSpan(
              text: textSelected,
              style: TextStyle(
                fontSize: widget.fontSize,
                color: widget.selectedTextColor != null
                    ? widget.selectedTextColor
                    : Colors.black,
              ),
            ),
            TextSpan(
              text: textAfter,
              style: TextStyle(
                fontSize: widget.fontSize,
                color: widget.unSelectedTextColor != null
                    ? widget.unSelectedTextColor
                    : Colors.grey[400],
              ),
            )
          ],
        )
            : TextSpan(
          text: result,
          style: TextStyle(
            fontSize: widget.fontSize,
            color: widget.unSelectedTextColor != null
                ? widget.unSelectedTextColor
                : Colors.grey[400],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLtr = Directionality.of(context) == TextDirection.ltr;
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.inputTextFieldBgColor,
              borderRadius: results.length == 0 || isItemClicked
                  ? BorderRadius.all(
                Radius.circular(widget.borderRadius),
              )
                  : BorderRadius.only(
                topLeft: Radius.circular(widget.borderRadius),
                topRight: Radius.circular(widget.borderRadius),
              ),
            ),
            child: Stack(
              children: [
                TextField(
                  autofocus: widget.autoFocus,
                  textInputAction:widget.textInputAction ,
                  autocorrect: widget.autoCorrect,
                  enabled: widget.enabled,
                  onEditingComplete: () {
                    sendSubmitResults(controller.text);
                    FocusScope.of(context).unfocus();
                  },
                  onSubmitted: (value) {
                    FocusScope.of(context).unfocus();
                  },
                  onTap: () {
                    setState(() {
                      isItemClicked = false;
                    });
                  },
                  controller: controller,
                  decoration: InputDecoration.collapsed(
                    hintText: hintText,
                    hintStyle: TextStyle(
                      color: widget.hintTextColor,),
                  ),
                  style: TextStyle(
                    fontSize: widget.fontSize,
                  ),
                  cursorColor: widget.cursorColor != null
                      ? widget.cursorColor
                      : Colors.grey[600],
                ),
                widget.clearSearchEnabled &&
                    controller.text.length > 0
                    ? Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  left: 0,
                  child: Align(
                    alignment: isLtr
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        if (controller.text.length == 0)
                          return;
                        setState(() {
                          controller.clear();
                          widget.onSearchClear();
                          isItemClicked = true;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.close,
                          size: 20,
                          color: controller.text.length == 0
                              ? Colors.grey[300]
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                )
                    : Container()
              ],
            ),
          ),
          if (!isItemClicked && widget.showListOfResults)
            Container(
              height: results.length * widget.singleItemHeight,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      String value = results[index];
                      widget.onItemTap(widget.data.indexOf(value), value);
                      controller.text = value;
                      controller.selection =
                          TextSelection.fromPosition(
                            TextPosition(
                              offset: value.length,
                            ),
                          );
                      setState(() {
                        isItemClicked = true;
                      });
                    },
                    child: Container(
                      height: widget.singleItemHeight,
                      padding: const EdgeInsets.all(8.0),
                      child: _getRichText(results[index]),
                      // decoration: ShapeDecoration(
                      //   color: widget.searchResultsBgColor,
                      //   // shape: CustomRoundedRectangleBorder(
                      //   //   borderRadius: BorderRadius.only(
                      //   //     bottomLeft: Radius.circular(
                      //   //       index == (results.length - 1)
                      //   //           ? widget.borderRadius
                      //   //           : 0.0,
                      //   //     ),
                      //   //     bottomRight: Radius.circular(
                      //   //       index == (results.length - 1)
                      //   //           ? widget.borderRadius
                      //   //           : 0.0,
                      //   //     ),
                      //   //   ),
                      //   //   leftSide: BorderSide(color: widget.borderColor),
                      //   //   bottomLeftCornerSide:
                      //   //   BorderSide(color: widget.borderColor),
                      //   //   rightSide: BorderSide(color: widget.borderColor),
                      //   //   bottomRightCornerSide:
                      //   //   BorderSide(color: widget.borderColor),
                      //   //   bottomSide: BorderSide(color: widget.borderColor),
                      //   // ),
                      // ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  void onSearchTextChanges() {
    if (lastSubmittedText == controller.text &&
        isItemClicked == true) {
      setState(() {
        isItemClicked = false;
      });
      return;
    }
    setState(() {
      isItemClicked = false;
    });
    if (controller.text.length < widget.minLettersForSearch) {
      setState(() {
        results = [];
      });
    } else {
      String searchText = widget.caseSensitive
          ? controller.text
          : controller.text.toLowerCase();
      switch (widget.searchMode) {
        case SearchMode.STARTING_WITH:
          setState(() {
            results = widget.data
                .where(
                  (element) =>
                  (widget.caseSensitive ? element : element.toLowerCase())
                      .startsWith(searchText),
            )
                .toList();
          });
          break;
        case SearchMode.CONTAINS:
          setState(() {
            results = widget.data
                .where(
                  (element) =>
                  (widget.caseSensitive ? element : element.toLowerCase())
                      .contains(searchText),
            )
                .toList();
          });
          break;
        case SearchMode.EXACT_MATCH:
          setState(() {
            results = widget.data
                .where(
                  (element) =>
              (widget.caseSensitive
                  ? element
                  : element.toLowerCase()) ==
                  searchText,
            )
                .toList();
          });
          break;
      }
      setState(() {
        if (results.length > widget.maxElementsToDisplay) {
          results = results.sublist(0, widget.maxElementsToDisplay);
        }
      });
    }
    // now send the latest updates
    if (widget.onEditingProgress != null) {
      widget.onEditingProgress!(controller.text, results);
    }
  }

  void sendSubmitResults(value) {
    try {
      if (lastSubmittedText == value) {
        setState(() {
          results = [];
        });
        return; // Nothing new to Submit
      }
      lastSubmittedText = value;
      setState(() {
        isItemClicked = true;
      });
      if (lastSubmittedText == "")
        widget.onSearchClear();
      else
        widget.onSubmitted!(lastSubmittedText, results);
      setState(() {
        results = [];
      });
    } catch (e) {
      print(e.toString());
    }
  }
}

enum SearchMode {
  STARTING_WITH,
  CONTAINS,
  EXACT_MATCH,
}