import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naturalslim_widgets/models/hours_location_available_model.dart';


class AppointmentProps{
  int indexDaySelected = 0;
  HoursLocationAvailableResponse selectedDate = HoursLocationAvailableResponse(date: DateTime.now(), hours: []);
  int indexHourSelected = 0;
}

class ScheduleAppointmentWidget extends StatefulWidget {
  /// This widget is used to display dates and times. Its main implementation was intended to schedule an appointment.
  /// 
  /// The [dateData] field, if nothing is received, will use local dates and times. 
  /// The dates that will display up to 30 days from the current date.
  /// 
  /// The [onChangedValue] field is a function that returns the value of the selected date and time. 
  /// This function is executed every time the date and/or time value has changed (either by a tap/click on a different date or time)
  ScheduleAppointmentWidget({
    this.dateData,
    this.onChangedValue,
    Key? key
  }) : props = AppointmentProps(), super(key: key);

  String? dateData;
  Function(DateTime)? onChangedValue;
  AppointmentProps props;

  @override
  State<ScheduleAppointmentWidget> createState() => _ScheduleAppointmentWidgetState();
}

class _ScheduleAppointmentWidgetState extends State<ScheduleAppointmentWidget> {

  late ScrollController _scrollController;
  late DateTime _selectedDateTime;
  late List<HoursLocationAvailableResponse> _widgetDatesData;

  @override
  void initState() {
    _scrollController = ScrollController(); 

    if(widget.dateData == null || widget.dateData!.isEmpty){

      // Local data is assigned
      _widgetDatesData = _buildDates();
      if(widget.props.selectedDate.hours.isEmpty) widget.props.selectedDate = _widgetDatesData[widget.props.indexDaySelected];

    } else {
      
      // The data that comes from the constructor is assigned
      _widgetDatesData = HoursLocationAvailableResponse.hoursLocationAvailableResponseFromJson(widget.dateData!);
      if(widget.props.selectedDate.hours.isEmpty) widget.props.selectedDate = _widgetDatesData[widget.props.indexDaySelected];

    }

    selectedValueReturned();

    super.initState();
  }
  
  /* ----------------------------------------------------------------- */

  double _valueScroll = 0;
  final double _valueToGo = 220;
  final List<String> _hoursWeekdays = ['09:00:00', '10:00:00', '11:00:00', '12:00:00', '13:00:00', '14:00:00', '15:00:00', '16:00:00',  '17:00:00', '18:00:00'];

  @override
  Widget build(BuildContext context) {    
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Widget Top (Date Calendar)
        Expanded(
          flex: 0,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _calendarNavigationButton(
                icon: const Icon(Icons.arrow_left),
                functionTap: () => (){
                  if(_valueScroll > _scrollController.position.minScrollExtent){
                    _valueScroll -= _valueToGo;
      
                    _scrollController.animateTo(
                      _valueScroll,
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.fastOutSlowIn
                    );
                  }
                }
              ),
              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: double.infinity * 0.50,
                    minWidth: double.infinity * 0.50,
                    minHeight: 100,
                    maxHeight: 100
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: _widgetDatesData.length,
                    itemBuilder: (context, index){
                      DateTime date = _widgetDatesData[index].date;
                      String nameDay = DateFormat('EEE').format(date);
                      String numberDay = date.day.toString();
                      String nameMonth = DateFormat('MMM').format(date);
                              
                      return  _cardDay(index, context, nameDay, numberDay, nameMonth);
                    },
                  )
                )
              ),
              _calendarNavigationButton(
                icon: const Icon(Icons.arrow_right),
                functionTap: () => (){
                  if(_valueScroll < _scrollController.position.maxScrollExtent){
                    _valueScroll += _valueToGo;
      
                    _scrollController.animateTo(
                      _valueScroll,
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.fastOutSlowIn
                    );
                  }
                }
              ),
            ],
          ),
        ),
    
        // Widget bottom (hours calendar)
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Wrap(
              children: _widgetDatesData[widget.props.indexDaySelected].hours.asMap().entries.map((e){
                String hour = e.value.substring(0, 2);
                String minute = e.value.substring(3, 5);
      
                String formattedTime = DateFormat('h:mm a').format(DateTime(2000, 01, 01, int.parse(hour), int.parse(minute)));
      
                return _cardHour(e, context, formattedTime); 
              }).toList(),
            ),
          )
        )
      ],
    );
  }

  /// Method to return the calendar navigation button
  Widget _calendarNavigationButton({required Widget icon, required Function functionTap}) {
    return Container(
      height: 40,
      width: 40,
      margin: const EdgeInsets.all(4.0),
      child: Ink(
        decoration: ShapeDecoration(
          color: Colors.grey.withOpacity(0.2),
          shape: const CircleBorder(),
        ),
        child: Center(
          child: IconButton(
            icon: icon,
            splashRadius: 25,
            onPressed: functionTap(), 
          ),
        ),
      ),
    );
  }

  /// Method to return a card with a date
  InkWell _cardDay(int index, BuildContext context, String nameDay, String numberDay, String nameMonth) {
    return InkWell(
      child: Container(
        width:  60,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: widget.props.indexDaySelected == index ? Theme.of(context).colorScheme.secondary : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.3,
              blurRadius: 4,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(nameDay, style: TextStyle(fontSize: 12, color: widget.props.indexDaySelected == index ? Colors.white : Colors.black), overflow: TextOverflow.ellipsis,),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(numberDay, style: TextStyle(fontSize: 14, color: widget.props.indexDaySelected == index ? Colors.white : Colors.black),),
            ),
            Text(nameMonth, style: TextStyle(fontSize: 14, color: widget.props.indexDaySelected == index ? Colors.white : Colors.black),),
          ],
        ),
      ),
      onTap: () => setState(() {
        widget.props.indexDaySelected = index;
        widget.props.selectedDate = _widgetDatesData[index];

        selectedValueReturned();
      }),
    );
  }

  /// Method to return a card with a time
  Widget _cardHour(MapEntry<int, String> e, BuildContext context, String formattedTime) {
    return Container(
      width: 100,
      height: 50,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: widget.props.indexHourSelected == e.key ? Theme.of(context).colorScheme.secondary : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0.3,
            blurRadius: 4,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: InkWell(
        onTap: () {
          setState((){
            widget.props.indexHourSelected = e.key;

            selectedValueReturned();
          });
        },
        child: Center(child: Text(formattedTime, style: TextStyle(fontSize: 14, color: widget.props.indexHourSelected == e.key ? Colors.white : Colors.black),)),
      ),
    );
  }
  
  /// Method that executes the [onChangedValue] function (if it exists) and returns the value selected in the function received by the constructor.
  void selectedValueReturned(){
    if(widget.onChangedValue != null){
      String date = widget.props.selectedDate.date.toString().substring(0, 10);
      String time = widget.props.selectedDate.hours[widget.props.indexHourSelected];

      _selectedDateTime = DateTime.parse('$date $time');
      widget.onChangedValue!(_selectedDateTime);
    }
  }

  /// Method calculate upcoming days locally
  List<HoursLocationAvailableResponse> _buildDates(){
    List<HoursLocationAvailableResponse> dates = [];
    DateTime date = DateTime.now();

    for(var i = 0; i < 30; i++){
      if(i > 0) date = date.add(const Duration(days: 1));

      if(date.weekday != 7){
        dates.add(
          HoursLocationAvailableResponse(
            date: date,
            hours: _hoursWeekdays
          )
        );
      }
    }

    return dates;
  }
}