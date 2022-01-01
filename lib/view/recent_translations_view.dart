import 'package:flutter/material.dart';


class RecentTranslationsView extends StatelessWidget {


  final List<String> recentTranslationsList;
  final List<String> recentTypedTextList;

  RecentTranslationsView(this.recentTranslationsList,this.recentTypedTextList);

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      //On Scroll, removes keyboard.
      onNotification: (notification) {
        if (notification is ScrollStartNotification) {
          FocusScope.of(context).unfocus();
        }
        return true;
      },

      child: Expanded(
        child: Card(
          child: ListView.separated(
            itemCount: recentTranslationsList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListTile(
                  tileColor: Colors.white,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recentTranslationsList[index],
                      ),
                      Text(
                        recentTypedTextList[index],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  trailing: GestureDetector(
                    child: Container(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.star_border),
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(
                  height: 0,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
