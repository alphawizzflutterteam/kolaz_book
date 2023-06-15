import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../Utils/colors.dart';

class Broadcast_screen extends StatefulWidget {
  const Broadcast_screen({Key? key}) : super(key: key);

  @override
  State<Broadcast_screen> createState() => _Broadcast_screenState();
}

class _Broadcast_screenState extends State<Broadcast_screen> {
  bool _isToggled = false;
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: AppColors.backgruond,
        appBar: AppBar(
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, color: Color(0xff1E90FF))),
          backgroundColor: Color(0xff303030),

          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,right: 10),
                  child: const Text("Brodcast", style: TextStyle(fontSize: 18, color:Color(0xff1E90FF), fontWeight: FontWeight.bold)
                  ),
                ),
                Expanded(
                  child:Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: FlutterSwitch(
                      height: 20.0,
                      width: 40.0,
                      padding: 4.0,
                      toggleSize: 15.0,
                      borderRadius: 10.0,
                      activeColor: AppColors.AppbtnColor,
                      value: _isToggled,
                      onToggle: (value) {
                        setState(() {
                          _isToggled = value;
                        });
                      },
                    ),
                  ),
                  // IconButton(
                  //   icon: Icon(_isToggled ? Icons.toggle_on_outlined : Icons.toggle_off,color: AppColors.AppbtnColor,size: 40,),
                  //   onPressed: () {
                  //     setState(() {
                  //       _isToggled = !_isToggled;
                  //     });
                  //   },
                  //
                  // ),
                ),
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.st,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Container(
                         width: 150,
                         height: 50,
                         decoration: BoxDecoration(
                             color: AppColors.containerclr2,
                           borderRadius: BorderRadius.circular(10)
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(10.0),
                           child: Text("Hi,Gayatri Chouhan",style: TextStyle(color: AppColors.whit),),
                         ),
                       ),
                       Container(
                         width: 80,
                         height: 50,
                         decoration: BoxDecoration(
                             color: AppColors.containerclr2,
                             borderRadius: BorderRadius.circular(10)
                         ),

                         child: Padding(
                           padding: const EdgeInsets.all(10.0),
                           child: Text("You have 1 message left",overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColors.whit),),
                         ),
                       )
                     ],
                  ),
                  SizedBox(height: 12,),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.containerclr2,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text("What You Need?",style: TextStyle(color:Color(0xff1E90FF,),fontSize: 17),),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Photographer",style: TextStyle( color:Color(0xff1E90FF)),),
                                  Container(
                                    height: 50,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.backgruond,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Select Type Of Photographer",style: TextStyle(color: AppColors.whit),),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Date",style: TextStyle( color:Color(0xff1E90FF)),),
                                Container(
                                  height: 50,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.backgruond,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("1 or 2 or 3 Selection",style: TextStyle(color: AppColors.whit),),
                                  ),
                                )
                              ],),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("City",style: TextStyle( color:Color(0xff1E90FF)),),
                                  Container(
                                    height: 50,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.backgruond,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Select City",style: TextStyle(color: AppColors.whit),),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("State",style: TextStyle( color:Color(0xff1E90FF)),),
                                  Container(
                                    height: 50,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.backgruond,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Select State",style: TextStyle(color: AppColors.whit),),
                                    ),
                                  )
                                ],),
                              SizedBox(height: 20,),
                              SizedBox(height: 50,width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('Send'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xff40ACFF),
                                    shape: StadiumBorder(),
                                  ),
                                )
                              ),
                              SizedBox(height: 10,),
                              Text("Note-All KalazBook User See Your Broadcasr Message You Can send 2 message in 24 hrs",
                                style: TextStyle(fontSize: 9,color: AppColors.whit), )

                            ],
                          ),
                        ),

                      ),
                      SizedBox(height: 18,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Align(child: Text("Kolaz Book Users",style: TextStyle(color:Color(0xff1E90FF),fontWeight: FontWeight.bold,fontSize: 18),),alignment: Alignment.topLeft,),
                        Align(child: Text("India",style: TextStyle(color:Color(0xff1E90FF),fontWeight: FontWeight.bold,fontSize: 18),),alignment: Alignment.topLeft,),
                      ],),
                      SizedBox(height: 18,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff6D6A6A),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(

                            children: [
                              Align(alignment: Alignment.topRight, child: SizedBox(height:5, child: IconButton(onPressed: (){}, icon: Icon(Icons.close)))),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage('https://media.istockphoto.com/id/877022826/photo/portrait-of-a-happy-young-asian-business-man.jpg?b=1&s=170667a&w=0&k=20&c=zBdoktuoe8bFhuBsdvtQgL_nJPnrZUn2gSf7OL3X2dM='),
                                  radius: 45,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Vismay Singh Chouhan",style: TextStyle(fontSize: 16, color:Color(0xff1E90FF),fontWeight: FontWeight.bold),),
                                        SizedBox(width:190,
                                            child: Text("I need (type of Photographer ),(Date,Date,Date),this date in (city name)",overflow: TextOverflow.visible,style: TextStyle(color: AppColors.textclr),maxLines: 3,))
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff6D6A6A),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Align(alignment: Alignment.topRight, child: SizedBox(height:5, child: IconButton(onPressed: (){}, icon: Icon(Icons.phone,color: Color(0xff1E90FF),)))),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage('https://media.istockphoto.com/id/877022826/photo/portrait-of-a-happy-young-asian-business-man.jpg?b=1&s=170667a&w=0&k=20&c=zBdoktuoe8bFhuBsdvtQgL_nJPnrZUn2gSf7OL3X2dM='),
                                    radius: 45,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Koushik ",style: TextStyle(fontSize: 16, color:Color(0xff1E90FF),fontWeight: FontWeight.bold),),
                                        SizedBox(width: 190,
                                            child: Text("I need (type of Photographer ),(Date,Date,Date),this date in (city name)",overflow: TextOverflow.ellipsis,maxLines: 3,style: TextStyle(color: AppColors.textclr),))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ) ,
                      SizedBox(height: 10,),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff6D6A6A),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Align(alignment: Alignment.topRight, child: SizedBox(height:5, child: IconButton(onPressed: (){}, icon: Icon(Icons.phone,color: Color(0xff1E90FF),)))),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage('https://media.istockphoto.com/id/877022826/photo/portrait-of-a-happy-young-asian-business-man.jpg?b=1&s=170667a&w=0&k=20&c=zBdoktuoe8bFhuBsdvtQgL_nJPnrZUn2gSf7OL3X2dM='),
                                    radius: 45,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Dipak",style: TextStyle(fontSize: 16, color:Color(0xff1E90FF),fontWeight: FontWeight.bold),),
                                        SizedBox(width: 190,
                                            child: Text("I need (type of Photographer ),(Date,Date,Date),this date in (city name)",overflow: TextOverflow.ellipsis,maxLines: 3,style: TextStyle(color: AppColors.textclr),))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff6D6A6A),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Align(alignment: Alignment.topRight, child: SizedBox(height:5, child: IconButton(onPressed: (){}, icon: Icon(Icons.phone,color: Color(0xff1E90FF),)))),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage('https://media.istockphoto.com/id/877022826/photo/portrait-of-a-happy-young-asian-business-man.jpg?b=1&s=170667a&w=0&k=20&c=zBdoktuoe8bFhuBsdvtQgL_nJPnrZUn2gSf7OL3X2dM='),
                                    radius: 45,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Rajesh",style: TextStyle(fontSize: 16, color:Color(0xff1E90FF),fontWeight: FontWeight.bold),),
                                        SizedBox(
                                            width: 200,
                                            child: Text("I need (type of Photographer ),(Date,Date,Date),this date in (city name)",overflow: TextOverflow.ellipsis,maxLines: 3,style: TextStyle(color: AppColors.textclr),))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
  }
}
