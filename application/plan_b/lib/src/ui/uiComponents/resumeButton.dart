import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {this.onPressed,
      this.solidColor,
      this.image,
      this.fontColor = Colors.white,
      this.iconShadow = true,
      this.showArrow = false,
      this.arrowColor = Colors.white,
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
  final Color arrowColor;
  final Color rightColor;
  final Color leftColor;
  final Function onPressed;
  final Color solidColor;
  final bool iconShadow;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6, bottom: 6),
      child: Container(
        height: 75,
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
                _buildIconShadow(),
                _buildArrowForward(),
                Positioned(
                  right: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        name,
                        style: Theme.of(context).textTheme.button,
                      ),
                      Text(
                        lastname,
                        style: Theme.of(context).textTheme.button,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 15,
                  child: CircleAvatar(
                    radius: 25,
                    child: image == null
                        ? Icon(Icons.person, color: Colors.black26)
                        : image,
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildArrowForward() {
    return showArrow
        ? Positioned(
            left: 25,
            child: Icon(
              Icons.arrow_back_ios,
              color: arrowColor,
            ),
          )
        : Container();
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
