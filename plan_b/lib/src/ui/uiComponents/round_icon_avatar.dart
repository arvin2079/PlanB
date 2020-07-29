import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Avatar extends StatefulWidget {
  Avatar({this.icon, this.iconSize, this.size = 80});

  final IconData icon;
  final double size;
  final double iconSize;

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  File _imageAsset;

  @override
  void initState() {
    // TODO: getting saved image that user choose before from database
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _getImage,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300], width: 2),
          borderRadius: BorderRadius.circular(200),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              buildImageAsset(),
              Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: _imageAsset != null ? Colors.black12 : Colors.white,
                ),
              ),
              Icon(
                _imageAsset == null && widget.icon == null
                    ? Icons.person
                    : widget.icon,
                color:
                    _imageAsset == null ? Colors.grey[600] : Colors.grey[200],
                size: widget.iconSize == null ? 40 : widget.iconSize,
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildImageAsset() {
    if (_imageAsset != null)
      return Image.file(
        _imageAsset,
        fit: BoxFit.fitWidth,
        height: widget.size,
        width: widget.size,
      );
    else
      return Container(
        width: 0,
        height: 0,
      );
  }

  void _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageAsset = image;
    });
  }
}
