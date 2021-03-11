import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';
import 'package:tood_and_note/ModelAndProvider/theme_provider.dart';
import 'package:tood_and_note/widget/drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          DemoLocalizations.of(context).trans('contact'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
        child: ContactUs(
          companyName: DemoLocalizations.of(context).trans('contact'),
          email: 'abdullahajwa99@gmail.com',
          githubUserName: 'AbdullahAbuAjwa',
          linkedinURL: 'https://www.linkedin.com/in/abdullahabuajwa/',
          cardColor: Provider.of<ThemeProvider>(context).darkTheme
              ? Color(0xff006494)
              : Color(0xffffb47a),
          companyFontSize: 30.sp,
          emailText: DemoLocalizations.of(context).trans('email'),
        ),
      ),
    );
  }
}
