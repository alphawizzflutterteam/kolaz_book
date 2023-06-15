

import 'package:flutter/material.dart';

import '../../Utils/colors.dart';
import '../freelencing_jobpost/account.dart';
import 'client_amt.dart';


class photographer_outstanding extends StatefulWidget {
  const photographer_outstanding({Key? key}) : super(key: key);

  @override
  State<photographer_outstanding> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<photographer_outstanding> {

  var selectedTime1;
  _selectStartTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        useRootNavigator: true,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(primary: Colors.black),
                buttonTheme: ButtonThemeData(
                    colorScheme: ColorScheme.light(primary: Colors.black))),
            child: MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: false),
                child: child!),
          );
        });
    if (timeOfDay != null && timeOfDay != selectedTime1) {
      setState(() {
        selectedTime1 = timeOfDay.replacing(hour: timeOfDay.hourOfPeriod);
        startTimeController.text = selectedTime1!.format(context);
      });
    }
    var per = selectedTime1!.period.toString().split(".");
    print(
        "selected time here ${selectedTime1!.format(context).toString()} and ${per[1]}");
  }

  TextEditingController dateinput = TextEditingController();
  @override
  void initState() {
    dateinput.text = "";

    super.initState();
  }

  TextEditingController startTimeController = TextEditingController();

  String? dropdownvalue;
  bool isSelected = false;
  var items = [
    '2wheeler',
    '3wheeler',
    '4wheeler',
  ];


  var item = ['Select Category'];

  Widget _clients() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 45,
          width: MediaQuery.of(context).size.width/1.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width:80,child: ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff668D3F),
              ),child: Text("All"))),
              SizedBox(width: 15,),
              SizedBox(width:120,child: ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff668D3F),
              ),child: Text("Outstanding"))),
            ],
          ),
        ),
        SizedBox(height: 4,),
        Container(
          height: 45,
          width: MediaQuery.of(context).size.width/1.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Photographer name",style: TextStyle(color:AppColors.whit),),
              Text("City Name",style: TextStyle(color:AppColors.whit)),
              Text("Remaining",style: TextStyle(color:AppColors.whit)),
            ],
          ),),
        SizedBox(height: 4,),

        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientDetails()));
          },
          child: Container(
            height: 45,
            width: MediaQuery.of(context).size.width/1.1,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff68913F),
                  Color(0xff424242)])),
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Dhaval Patel", style: TextStyle(color: AppColors.textclr),),
                  Text("Mumbai", style: TextStyle(color: AppColors.textclr)),
                  Text("1000", style: TextStyle(color: AppColors.textclr)),
                  // Image.asset("assets/calling.png", scale: 1.4,)
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          // padding: EdgeInsets.symmetric(horizontal: 20,),
          height: 45,
          width: MediaQuery.of(context).size.width/1.1,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xff68913F),
                Color(0xff424242)])),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dhaval Patel", style: TextStyle(color: AppColors.textclr),),
                Text("Mumbai", style: TextStyle(color: AppColors.textclr)),
                Text("1000", style: TextStyle(color: AppColors.textclr)),
                // Image.asset("assets/calling.png", scale: 1.4,)
              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          height: 45,
          width: MediaQuery.of(context).size.width/1.1,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xff68913F),
                Color(0xff424242)])),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dhaval Patel", style: TextStyle(color: AppColors.textclr),),
                Text("Mumbai", style: TextStyle(color: AppColors.textclr)),
                Text("1000", style: TextStyle(color: AppColors.textclr)),
                // Image.asset("assets/calling.png", scale: 1.4,)
              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          height: 45,
          width: MediaQuery.of(context).size.width/1.1,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xff68913F),
                Color(0xff424242)])),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dhaval Patel", style: TextStyle(color: AppColors.textclr),),
                Text("Mumbai", style: TextStyle(color: AppColors.textclr)),
                Text("1000", style: TextStyle(color: AppColors.textclr)),
                // Image.asset("assets/calling.png", scale: 1.4,)
              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          height: 45,
          width: MediaQuery.of(context).size.width/1.1,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xff68913F),
                Color(0xff424242)])),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dhaval Patel", style: TextStyle(color: AppColors.textclr),),
                Text("Mumbai", style: TextStyle(color: AppColors.textclr)),
                Text("1000", style: TextStyle(color: AppColors.textclr)),
                // Image.asset("assets/calling.png", scale: 1.4,)
              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          height: 45,
          width: MediaQuery.of(context).size.width/1.1,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xff68913F),
                Color(0xff424242)])),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dhaval Patel", style: TextStyle(color: AppColors.textclr),),
                Text("Mumbai", style: TextStyle(color: AppColors.textclr)),
                Text("1000", style: TextStyle(color: AppColors.textclr)),
                // Image.asset("assets/calling.png", scale: 1.4,)
              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          height: 45,
          width: MediaQuery.of(context).size.width/1.1,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xff68913F),
                Color(0xff424242)])),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dhaval Patel", style: TextStyle(color: AppColors.textclr),),
                Text("Mumbai", style: TextStyle(color: AppColors.textclr)),
                Text("1000", style: TextStyle(color: AppColors.textclr)),
                // Image.asset("assets/calling.png", scale: 1.4,)
              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
        Container(

          height: 45,
          width: MediaQuery.of(context).size.width/1.1,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xff68913F),
                    Color(0xff424242)])
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dhaval Patel", style: TextStyle(color: AppColors.textclr),),
                Text("Mumbai", style: TextStyle(color: AppColors.textclr)),
                Text("1000", style: TextStyle(color: AppColors.textclr)),
                // Image.asset("assets/calling.png", scale: 1.4,)
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget _phptographers() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width/1.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width:80,child: ElevatedButton(onPressed: (){}, child: Text("All"))),
            SizedBox(width:100,child: ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red, // Background color
            ), child: Text("Payout"),)),
            SizedBox(width:120,child: ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(
             backgroundColor: Color(0xff668D3F),
            ),child: Text("Outstanding"))),
          ],
        ),
      ),
      SizedBox(height: 4,),
      Container( height: 45,
        width: MediaQuery.of(context).size.width/1.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Photographer name",style: TextStyle(color:AppColors.whit),),
            Text("City Name",style: TextStyle(color:AppColors.whit)),
            Text("Remaining",style: TextStyle(color:AppColors.whit)),
          ],
        ),),
      SizedBox(height: 4,),
      InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountScreen()));

        },
        child: Container(
          height: 45,
          width: MediaQuery.of(context).size.width/1.1,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xff68913F),
                Color(0xff424242)])),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Jigar Patel", style: TextStyle(color: AppColors.textclr),),
                Text("Mumbai", style: TextStyle(color: AppColors.textclr)),
                Text("1000", style: TextStyle(color: AppColors.textclr)),
                // Image.asset("assets/calling.png", scale: 1.4,)
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 10),
      Container(
        // padding: EdgeInsets.symmetric(horizontal: 20,),
        height: 45,
        width: MediaQuery.of(context).size.width/1.1,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xff68913F),
              Color(0xff424242)])),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Jigar Patel", style: TextStyle(color: AppColors.textclr),),
              Text("Mumbai", style: TextStyle(color: AppColors.textclr)),
              Text("1000", style: TextStyle(color: AppColors.textclr)),
              // Image.asset("assets/calling.png", scale: 1.4,)
            ],
          ),
        ),
      ),
      SizedBox(height: 10,),
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width/1.1,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xff68913F),
              Color(0xff424242)])),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Kinjal Patel", style: TextStyle(color: AppColors.textclr),),
              Text("Mumbai", style: TextStyle(color: AppColors.textclr)),
              Text("1000", style: TextStyle(color: AppColors.textclr)),
              // Image.asset("assets/calling.png", scale: 1.4,)
            ],
          ),
        ),
      ),
      SizedBox(height: 10,),
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width/1.1,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xff68913F),
              Color(0xff424242)])),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Dhaval Patel", style: TextStyle(color: AppColors.textclr),),
              Text("Mumbai", style: TextStyle(color: AppColors.textclr)),
              Text("1000", style: TextStyle(color: AppColors.textclr)),
              // Image.asset("assets/calling.png", scale: 1.4,)
            ],
          ),
        ),
      ),
      SizedBox(height: 10,),
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width/1.1,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xff68913F),
              Color(0xff424242)])),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Dhaval Patel", style: TextStyle(color: AppColors.textclr),),
              Text("Mumbai", style: TextStyle(color: AppColors.textclr)),
              Text("1000", style: TextStyle(color: AppColors.textclr)),
              // Image.asset("assets/calling.png", scale: 1.4,)
            ],
          ),
        ),
      ),
      SizedBox(height: 10,),
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width/1.1,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xff68913F),
              Color(0xff424242)])),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Dhaval Patel", style: TextStyle(color: AppColors.textclr),),
              Text("Mumbai", style: TextStyle(color: AppColors.textclr)),
              Text("1000", style: TextStyle(color: AppColors.textclr)),
              // Image.asset("assets/calling.png", scale: 1.4,)
            ],
          ),
        ),
      ),

    ]);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgruond,
      appBar: isSelected ? AppBar(
        backgroundColor: Color(0xff303030),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Center(child: Text("Client Account",
                style: TextStyle(fontSize: 16, color:Color(0xff1E90FF), fontWeight: FontWeight.bold)
            ),
            ),
          ),
        ],
      ) : AppBar(
        backgroundColor: Color(0xff303030),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Center(child: Text("Photographers Account",
                style: TextStyle(fontSize: 16, color:Color(0xff1E90FF), fontWeight: FontWeight.bold)
            ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        // padding: EdgeInsets.only(bottom: 100.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            child:Image.asset("assets/images/pdf.png"),
            onPressed: () {

            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.containerclr,
                        borderRadius: BorderRadius.circular(10)),

                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isSelected = true;
                            });
                          },
                          child: Container(
                              height: 40,
                              width: 70,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10),
                                child: Text(
                                  'Client',
                                  style: TextStyle(
                                    color: isSelected
                                        ? Color(0xffffffff)
                                        : Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.AppbtnColor
                                    : AppColors.containerclr,
                                // border: Border.all(color: AppColors.AppbtnColor),
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isSelected = false;
                            });
                          },
                          child: Container(
                              height: 40,
                              width: 120,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10),
                                child: Text(
                                  'Photographer',
                                  style: TextStyle(
                                    color: isSelected
                                        ? AppColors.whit
                                        : Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.containerclr
                                      : AppColors.AppbtnColor,
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ],
                    ),)

                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 4,
              ),
              isSelected ? _clients() : _phptographers(),
            ],
          ),
        ),
      ),
    );
  }

}
