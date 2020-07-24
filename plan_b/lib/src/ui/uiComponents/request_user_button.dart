import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequestUserButton extends StatelessWidget {
  const RequestUserButton(
      {this.onPressed,
      this.solidColor,
      this.image,
      this.fontColor = Colors.white,
      this.iconShadow = true,
      @required this.onAccept,
      @required this.onReject,
      this.trailingIcon,
      @required this.name,
      @required this.lastname,
      @required this.rightColor,
      @required this.leftColor});

  final Icon trailingIcon;
  final Image image;
  final String name;
  final String lastname;
  final Color fontColor;
  final Color rightColor;
  final Color leftColor;
  final Function onPressed;
  final Color solidColor;
  final bool iconShadow;
  final Function onAccept;
  final Function onReject;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6, bottom: 6),
      child: Container(
        height: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8.0, // has the effect of softening the shadow
              spreadRadius: 0.0, // has the effect of extending the shadow
              offset: Offset(
                0.0, // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            ),
          ],
          gradient: solidColor != null
              ? null
              : LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [leftColor, rightColor],
                ),
          color: solidColor,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: onPressed,
            highlightColor: Colors.black12,
            splashColor: Colors.black12,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  right: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        name,
                        style: Theme.of(context).textTheme.headline1.copyWith(
                          color: Colors.white
                        ),
                      ),
                      Text(
                        lastname,
                        style: Theme.of(context).textTheme.headline1.copyWith(
                          color: Colors.white
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 15,
                  child: CircleAvatar(
                    radius: 24,
                    backgroundImage: image != null ? image.image : null,
                    child: image == null
                        ? Icon(Icons.person, color: Colors.black26)
                        : null,
                    backgroundColor: Colors.white,
                  ),
                ),
                _buildIconShadow(),
                Positioned(
                  left: 10,
                    child: _buildDecisionButtons(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDecisionButtons(BuildContext context) {
    final double radius = 30;
    return Row(
      children: <Widget>[
        ButtonTheme(
          height: 35,
          minWidth: 70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(radius), topLeft: Radius.circular(radius), bottomRight: Radius.circular(radius)),
          ),
          child: RaisedButton(
            elevation: 2,
            child: Text(
              'قبول',
              style: Theme.of(context).textTheme.caption.copyWith(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            color: Colors.lightGreen,
            onPressed: onAccept,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        ButtonTheme(
          height: 35,
          minWidth: 80,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(radius), topLeft: Radius.circular(radius), bottomLeft: Radius.circular(radius)),
          ),
          child: RaisedButton(
            elevation: 2,
            child: Text(
              'رد',
              style: Theme.of(context).textTheme.caption.copyWith(
                  fontSize: 14,
                  color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            color: Colors.red,
            onPressed: onReject,
          ),
        ),
      ],
    );
  }

  void dispose(){
    dispose();
  }

  Widget _buildIconShadow() {
    return iconShadow
        ? Positioned(
            left: 10,
            child: Opacity(opacity: 0.2, child: trailingIcon),
          )
        : Container();
  }
}
