import 'package:flutter/material.dart';
import 'package:tailor_made/pages/contacts/models/contact.model.dart';
import 'package:tailor_made/pages/contacts/ui/contact_appbar.dart';
import 'package:tailor_made/pages/contacts/ui/contact_header.dart';
import 'package:tailor_made/pages/contacts/ui/contact_jobs_list.dart';
import 'package:tailor_made/pages/contacts/ui/contact_payments_list.dart';
import 'package:tailor_made/pages/contacts/ui/contact_gallery_grid.dart';
import 'package:tailor_made/utils/tm_theme.dart';

const TABS = const ["Jobs", "Gallery", "Payments"];

class Contact extends StatefulWidget {
  final ContactModel contact;

  Contact({this.contact});

  @override
  _ContactState createState() => new _ContactState();
}

class _ContactState extends State<Contact> {
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    final TMTheme theme = TMTheme.of(context);

    return new Scaffold(
      backgroundColor: theme.scaffoldColor,
      body: new DefaultTabController(
        length: 3,
        child: new NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: new SliverAppBar(
                  backgroundColor: accentColor,
                  automaticallyImplyLeading: false,
                  title: new ContactAppBar(
                    contact: widget.contact,
                    scrollController: _scrollController,
                    scrolled: innerBoxIsScrolled,
                  ),
                  pinned: true,
                  // floating: true,
                  // snap: true,
                  titleSpacing: 0.0,
                  centerTitle: false,
                  flexibleSpace: ContactHeaderCarouselWidget(),
                  expandedHeight: 300.0,
                  forceElevated: true,
                  bottom: tabTitles(backgroundColor: theme.appBarBackgroundColor),
                ),
              ),
            ];
          },
          body: new TabBarView(
            children: [
              tabView(name: TABS[0].toLowerCase(), child: JobsListWidget()),
              tabView(name: TABS[1].toLowerCase(), child: GalleryGridWidget()),
              tabView(name: TABS[2].toLowerCase(), child: PaymentsListWidget()),
            ],
          ),
        ),
      ),
    );
  }
}

Widget tabTitles({Color backgroundColor}) {
  return PreferredSize(
    child: Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.25), offset: Offset(0.0, 2.0), spreadRadius: 0.0, blurRadius: 3.0),
          // BoxShadow(color: Colors.white, offset: Offset(0.0, -3.0), spreadRadius: 2.0, blurRadius: 0.0),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 0.0),
      child: TabBar(
        // indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelColor: Colors.grey.withOpacity(.7),
        tabs: [
          Tab(child: Text(TABS[0])),
          Tab(child: Text(TABS[1])),
          Tab(child: Text(TABS[2])),
        ],
      ),
    ),
    preferredSize: Size.fromHeight(kTextTabBarHeight),
  );
}

Widget tabView({name: String, child: Widget}) {
  return new SafeArea(
    top: false,
    bottom: true,
    child: new Builder(
      builder: (BuildContext context) {
        return new CustomScrollView(
          key: new PageStorageKey<String>(name),
          slivers: <Widget>[
            new SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            new SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              sliver: child,
            ),
          ],
        );
      },
    ),
  );
}
