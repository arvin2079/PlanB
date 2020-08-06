import 'package:flutter/material.dart';
import 'package:planb/src/ui/constants/constants.dart';

class OfflineError extends StatelessWidget {
  Function function;

  OfflineError({this.function});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("!خطا در برقراری ارتباط",
            style: Theme.of(context).textTheme.headline6.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                color: secondaryVariant)),
        Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
                "از متصل بودن اینترنت اطمنیان حاصل کرده و دوباره برای برقراری ارتباط تلاش کنید",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.normal, color: secondaryVariant))),
        SizedBox(
          height: 20,
        ),
        Container(
          child: Image.asset('images/offline.png'),
        ),
        FlatButton(
          child: Text(
            "تلاش مجدد",
            style: TextStyle(color: secondaryVariant),
          ),
          onPressed: function,
        ),
      ],
    );
  }
}
