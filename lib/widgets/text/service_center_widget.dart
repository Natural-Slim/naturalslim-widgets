import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:naturalslim_widgets/models/service_center_info.dart';

class ServiceCenterWidget extends StatefulWidget {
  const ServiceCenterWidget({
    Key? key,
    required this.title,
    required this.iframe,
    required this.serviceCenterInfoList
  }) : super(key: key);


  /// The title that will be displayed on this section
  final String title;

  /// This should render an iframe of html
  final String iframe;
  
  /// This must be a list that represents an object with the following structure
  /// ```
  /// {
  ///   "country": <String>,
  ///   "contactInfo": <String>?
  ///   "moreInformation": <String>?
  /// }
  /// ```
  final List<ServiceCenterInformation> serviceCenterInfoList;

  @override
  State<ServiceCenterWidget> createState() => _ServiceCenterWidgetState();
}

class _ServiceCenterWidgetState extends State<ServiceCenterWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Html(
            shrinkWrap: true, 
            data: widget.iframe,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0, bottom: 10),
            child: Text(widget.title , style: Theme.of(context).textTheme.headline5, textAlign: TextAlign.center,),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.serviceCenterInfoList.map((e) => _buildTextInfo(title: e.country, subtitle2: e.contactInformation, subtitle: e.moreInformation)).toList()
          )
        ],
      ),
    );
  }

  /// Method to build each item of contact information for each country
  Widget _buildTextInfo({required String title, String? subtitle, String? subtitle2, String? subtitle3,}){

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyText1),
          if(subtitle != null) Text(subtitle, style: Theme.of(context).textTheme.bodyText2,),
          if(subtitle2 != null) Text(subtitle2, style: Theme.of(context).textTheme.bodyText2,),
          if(subtitle3 != null) Text(subtitle3, style: Theme.of(context).textTheme.bodyText2,)
        ],
      ),
    );
  }
}