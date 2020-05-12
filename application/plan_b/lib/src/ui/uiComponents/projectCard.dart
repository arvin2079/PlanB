import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class ProjectCard extends StatefulWidget {
  const ProjectCard({
    this.onExpansionChanged,
    this.initiallyExpanded = false,
    this.children = const <Widget>[],
    @required this.title,
    @required this.caption,
    @required this.buttonOpenText,
  })
      : assert(initiallyExpanded != null),
        assert(buttonOpenText != null);

  final String buttonOpenText;

//  final ProjectItem item;
  final String title;
  final String caption;
  final ValueChanged<bool> onExpansionChanged;
  final List<Widget> children;
  final bool initiallyExpanded;

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
  CurveTween(curve: Curves.easeIn);

  AnimationController _controller;
  Animation<double> _heightFactor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);

    _isExpanded =
        PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null)
      widget.onExpansionChanged(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    return Container(
      child: Column(
        children: <Widget>[
          ListTileTheme.merge(
            child: ListTile(
              title: Text(
                widget.title,
                style: Theme
                    .of(context)
                    .textTheme
                    .subtitle,
              ),
              subtitle: Text(
                widget.caption,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'yekan',
                  fontSize: 15,
                  height: 1.3,
                ),
              ),
            ),
          ),
          ClipRect(
            child: Align(
              heightFactor: _heightFactor.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              AnimatedBuilder(
                animation: _controller.view,
                builder: _buildChildren,
                child: closed
                    ? null
                    : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: widget.children,
                  ),
                ),
              ),
              _buildBottomButton(closed, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton(bool closed, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, bottom: 5, top: 5),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          closed ? widget.buttonOpenText : 'بستن',
          style: Theme
              .of(context)
              .textTheme
              .button,
        ),
        onPressed: _handleTap,
      ),
    );
  }
}

//project card item model
class ProjectItem {
  ProjectItem({this.team, this.requests, this.creator,
    @required this.title, @required this.caption, @required this.skills});

  // fixme : team and request and creator are type of USER not STRING
  final String title;
  final String caption;
  final List<String> skills;
  final List<User> team;
  final List<User> requests;
  final User creator;
}
