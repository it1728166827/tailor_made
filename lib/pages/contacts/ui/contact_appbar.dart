import 'package:flutter/material.dart';
import 'package:tailor_made/pages/contacts/models/contact.model.dart';
import 'package:tailor_made/utils/tm_theme.dart';

class ContactAppBar extends StatefulWidget {
  final ContactModel contact;
  final ScrollController scrollController;
  final bool scrolled;

  ContactAppBar({this.contact, this.scrollController, this.scrolled: true});

  @override
  ContactAppBarState createState() {
    return new ContactAppBarState();
  }
}

class ContactAppBarState extends State<ContactAppBar> {
  bool isAtTop = false;

  void _updateScrollPosition() {
    if (widget.scrollController.position.maxScrollExtent == widget.scrollController.offset) {
      setState(() => isAtTop = true);
    } else if (8.0 < widget.scrollController.offset) {
      setState(() => isAtTop = false);
    }
  }

  @override
  void initState() {
    widget.scrollController.addListener(_updateScrollPosition);
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_updateScrollPosition);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onTapGoBack() {
      Navigator.pop(context);
    }

    Widget appBarLeading = new FlatButton(
      padding: EdgeInsets.fromLTRB(8.0, 8.0, 16.0, 8.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          new SizedBox(width: isAtTop ? 0.0 : 4.0),
          new Hero(
            tag: widget.contact.image,
            child: new CircleAvatar(
              radius: isAtTop ? 0.0 : null,
              backgroundColor: Colors.grey.shade400,
              backgroundImage: NetworkImage(widget.contact.image),
            ),
          ),
        ],
      ),
      onPressed: onTapGoBack,
    );

    Widget appBarTitle = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          widget.contact.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        isAtTop || (widget.contact.pending < 1)
            ? new Container()
            : new Text.rich(
                new TextSpan(
                  children: [
                    new TextSpan(
                      text: widget.contact.pending.toString(),
                      style: new TextStyle(fontWeight: FontWeight.w600),
                    ),
                    new TextSpan(
                      text: " pending wear-ables",
                    ),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(
                  fontSize: 13.0,
                  color: Colors.white,
                ),
              ),
      ],
    );

    Widget appBarIcon({IconData icon, VoidCallback onTap}) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkResponse(
          child: new Icon(icon, color: Colors.white),
          onTap: onTap,
          radius: 20.0,
          splashColor: accentColor.withOpacity(.25),
        ),
      );
    }

    return new PreferredSize(
      preferredSize: new Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: BoxDecoration(
            // color: Colors.transparent,
            // color: theme.appBarBackgroundColor,
            // color: Colors.black.withOpacity(.05),
            // boxShadow: [
            //   BoxShadow(color: Colors.black.withOpacity(.05)),
            //   BoxShadow(color: Colors.black.withOpacity(.05), spreadRadius: 2.0, blurRadius: 10.0),
            // ],
            ),
        child: SafeArea(
          top: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              appBarLeading,
              Expanded(
                child: appBarTitle,
              ),
              appBarIcon(
                icon: Icons.call,
                onTap: () {},
              ),
              appBarIcon(
                icon: Icons.message,
                onTap: () {},
              ),
              appBarIcon(
                icon: Icons.more_vert,
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
