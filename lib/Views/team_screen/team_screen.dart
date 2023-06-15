import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Utils/colors.dart';


class TeamScreen extends StatefulWidget {
  const TeamScreen({Key? key}) : super(key: key);

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:AppColors.primary ,

      appBar: AppBar(
        backgroundColor:AppColors.secondary ,
        automaticallyImplyLeading: false,
        // leading: TextButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     child: Icon(Icons.arrow_back_ios,size : 35,color: AppColors.AppbtnColor,)
        // ),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                "Teams ",
                style: TextStyle(
                    color: AppColors.AppbtnColor,fontSize: 16,
                    fontWeight: FontWeight.w600),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(

          children: [



            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  SizedBox(width: 5,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,top: 20),
                    child: Text("All Team For Upcoming Client Job", style: TextStyle(fontSize: 17, color: AppColors.whit, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15,),

            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: 10,

                  itemBuilder: (context, index) {
                    return

                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.teamcard,
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 7),
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              height: 65,
                              decoration: BoxDecoration(
                                  color: AppColors.teamcard2,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("Client Name: Krishna Patel",style: TextStyle(color: AppColors.textclr,fontSize: 11,fontWeight: FontWeight.bold),),
                                  Text("Event: Edding",style: TextStyle(color: AppColors.textclr,fontSize: 11,fontWeight: FontWeight.bold),),
                                  Text("Vanue: Mumbai",style: TextStyle(color: AppColors.textclr,fontSize: 11,fontWeight: FontWeight.bold),),

                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
                              child: Row(
                                children: const [
                                  Text("Date: ",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 14),),
                                  SizedBox(width: 7,),
                                  Text("29-04-2023",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      Container(
                                        padding: EdgeInsets.all(3.0),
                                        child: Text("Photographer Name  ",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 14),),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Text("Krishna Patel ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Text("Ajit Thakkar ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Text("Ramesh Prajapati ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Text("Mohit Khan ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
                                      ),

                                    ],),

                                  Container(
                                    width: MediaQuery.of(context).size.width/2.3,

                                    child:     Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(

                                          padding: const EdgeInsets.all(3.0),

                                          child: const Text("Type Of Photography",
                                            overflow: TextOverflow.ellipsis,

                                            style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 14),),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(3.0),

                                          child: Text("Candid Photography",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(3.0),
                                          child: Text("Drone",style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(3.0),
                                          child: Text("Led",style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Container(
                                              child: Text("Candid Chinematography",style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                        ),



                                      ],),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 10,),

                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.teamcard2,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,

                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5.0,right: 10,top: 5),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Google Map Link ",style: TextStyle(color: AppColors.temtextclr,fontSize: 16,fontWeight: FontWeight.bold),),
                                            SizedBox(height: 15,),

                                            Text("Notes ",style: TextStyle(color: AppColors.temtextclr,fontSize: 16,fontWeight: FontWeight.bold),),



                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5,right: 5,top: 10, bottom: 10),

                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          children: [
                                            Container(
                                              color: Colors.white,
                                              height: 40,
                                              width: 170,

                                              child: TextFormField(
                                                // controller: nameController,
                                                style: TextStyle(color: AppColors.field, fontSize: 12),
                                                keyboardType: TextInputType.name,
                                                decoration: InputDecoration(
                                                    hintStyle: TextStyle(fontSize: 12),
                                                    hintText: 'Paste Google Map Link',
                                                    border: InputBorder.none,
                                                    contentPadding: EdgeInsets.only(bottom: 5,left: 5)
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                            Container(
                                              color: Colors.white,
                                              height: 40,
                                              width: 170,
                                              child: TextFormField(
                                                style: TextStyle(color: AppColors.field, fontSize: 12),                                  // controller: nameController,
                                                keyboardType: TextInputType.name,
                                                decoration: InputDecoration(
                                                    hintStyle: TextStyle(fontSize: 12),
                                                    hintText: 'Enter Short Instruction/ Time /etc. Map Link Link ',
                                                    border: InputBorder.none,
                                                    contentPadding: EdgeInsets.only(bottom: 5,left: 5)
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                  Container(
                                    height: 35,
                                    width: MediaQuery.of(context).size.width/1.7,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color:AppColors.pdfbtn),
                                    child: Center(child: Text("PDF",
                                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
                                    ),
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                ],
                              ),
                            ),

                          ],
                        ),
                      );


                  },),
              ),
            ),


//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: AppColors.teamcard,
//                     borderRadius: BorderRadius.circular(10)),
//                 margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 7),
//                 width: double.infinity,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 15),
//                       height: 65,
//                       decoration: BoxDecoration(
//                           color: AppColors.teamcard2,
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: const [
//                           Text("Client Name: Krishna Patel",style: TextStyle(color: AppColors.textclr,fontSize: 11,fontWeight: FontWeight.bold),),
//                           Text("Event: Edding",style: TextStyle(color: AppColors.textclr,fontSize: 11,fontWeight: FontWeight.bold),),
//                           Text("Vanue: Mumbai",style: TextStyle(color: AppColors.textclr,fontSize: 11,fontWeight: FontWeight.bold),),
//
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
//                       child: Row(
//                         children: const [
//                           Text("Date: ",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 14),),
//                           SizedBox(width: 7,),
//                           Text("29-04-2023",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 10,),
//
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children:  [
//                             Container(
//                               padding: EdgeInsets.all(3.0),
//                               child: Text("Photographer Name  ",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 14),),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(3.0),
//                               child: Text("Krishna Patel ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(3.0),
//                               child: Text("Ajit Thakkar ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(3.0),
//                               child: Text("Ramesh Prajapati ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(3.0),
//                               child: Text("Mohit Khan ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
//                             ),
//
//                           ],),
//
// Container(
//       width: MediaQuery.of(context).size.width/2.3,
//
//       child:     Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: [
//      Container(
//
//        padding: const EdgeInsets.all(3.0),
//
//        child: const Text("Type Of Photography",
//            overflow: TextOverflow.ellipsis,
//
//            style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 14),),
//      ),
//      Container(
//        padding: const EdgeInsets.all(3.0),
//
//        child: Text("Candid Photography",
//          overflow: TextOverflow.ellipsis,
//          style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),),
//      ),
//      const Padding(
//        padding: EdgeInsets.all(3.0),
//        child: Text("Drone",style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),),
//      ),
//      const Padding(
//        padding: EdgeInsets.all(3.0),
//        child: Text("Led",style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),),
//      ),
//      Padding(
//        padding: const EdgeInsets.all(3.0),
//        child: Container(
//            child: Text("Candid Chinematography",style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,)),
//      ),
//
//
//
//    ],),
//     ),
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: 10,),
//
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 10),
//                       decoration: BoxDecoration(
//                           color: AppColors.teamcard2,
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 5.0,right: 10,top: 5),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text("Google Map Link ",style: TextStyle(color: AppColors.temtextclr,fontSize: 16,fontWeight: FontWeight.bold),),
//                                     SizedBox(height: 15,),
//
//                                     Text("Notes ",style: TextStyle(color: AppColors.temtextclr,fontSize: 16,fontWeight: FontWeight.bold),),
//
//
//
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 5,right: 5,top: 10, bottom: 10),
//
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//
//                                   children: [
//                                     Container(
//                                       color: Colors.white,
//                                       height: 40,
//                                       width: 170,
//
//                                       child: TextFormField(
//                                         // controller: nameController,
//                                         style: TextStyle(color: AppColors.field, fontSize: 12),
//                                         keyboardType: TextInputType.name,
//                                         decoration: InputDecoration(
//                                             hintStyle: TextStyle(fontSize: 12),
//                                             hintText: 'Paste Google Map Link',
//                                             border: InputBorder.none,
//                                             contentPadding: EdgeInsets.only(bottom: 5,left: 5)
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: 10,),
//                                     Container(
//                                       color: Colors.white,
//                                       height: 40,
//                                       width: 170,
//                                       child: TextFormField(
//                                         style: TextStyle(color: AppColors.field, fontSize: 12),                                  // controller: nameController,
//                                         keyboardType: TextInputType.name,
//                                         decoration: InputDecoration(
//                                           hintStyle: TextStyle(fontSize: 12),
//                                             hintText: 'Enter Short Instruction/ Time /etc. Map Link Link ',
//                                             border: InputBorder.none,
//                                             contentPadding: EdgeInsets.only(bottom: 5,left: 5)
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//
//                             ],
//                           ),
//                           Container(
//                             height: 35,
//                             width: MediaQuery.of(context).size.width/1.7,
//                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color:AppColors.pdfbtn),
//                             child: Center(child: Text("PDF",
//                               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
//                             ),
//                             ),
//                           ),
//                           const SizedBox(height: 10,),
//                         ],
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),





            // const SizedBox(height: 10,),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //   child: Container(
            //     decoration: BoxDecoration(
            //         color: AppColors.teamcard,
            //         borderRadius: BorderRadius.circular(10)),
            //     margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 7),
            //     width: double.infinity,
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         Container(
            //           padding: EdgeInsets.symmetric(horizontal: 15),
            //           height: 65,
            //           decoration: BoxDecoration(
            //               color: AppColors.teamcard2,
            //               borderRadius: BorderRadius.circular(10)),
            //           child: Row(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: const [
            //               Text("Client Name: Krishna Patel",style: TextStyle(color: AppColors.textclr,fontSize: 11,fontWeight: FontWeight.bold),),
            //               Text("Event: Edding",style: TextStyle(color: AppColors.textclr,fontSize: 11,fontWeight: FontWeight.bold),),
            //               Text("Vanue: Mumbai",style: TextStyle(color: AppColors.textclr,fontSize: 11,fontWeight: FontWeight.bold),),
            //
            //             ],
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
            //           child: Row(
            //             children: const [
            //               Text("Date: ",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 14),),
            //               SizedBox(width: 7,),
            //               Text("29-04-2023",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
            //             ],
            //           ),
            //         ),
            //         const SizedBox(height: 10,),
            //
            //         Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 8, ),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Column(
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children:  [
            //                   Container(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Photographer Name  ",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 14),),
            //                   ),
            //                   Padding(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Krishna Patel ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
            //                   ),
            //                   Padding(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Ajit Thakkar ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
            //                   ),
            //                   Padding(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Ramesh Prajapati ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
            //                   ),
            //                   Padding(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Mohit Khan ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
            //                   ),
            //
            //                 ],),
            //               Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Container(
            //                     width: 150,
            //
            //                     padding: const EdgeInsets.all(3.0),
            //
            //                     child: const Text("Type Of Photography",
            //                       overflow: TextOverflow.ellipsis,
            //
            //                       style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 14),),
            //                   ),
            //                   Container(
            //                     padding: const EdgeInsets.all(3.0),
            //                     width: 150,
            //
            //                     child: Text("Candid Photography",
            //                       overflow: TextOverflow.ellipsis,
            //                       style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),),
            //                   ),
            //                   const Padding(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Drone",style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),),
            //                   ),
            //                   const Padding(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Led",style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),),
            //                   ),
            //                   Padding(
            //                     padding: const EdgeInsets.all(3.0),
            //                     child: Container(
            //                         width: 180,
            //                         child: Text("Candid Chinematography",style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,)),
            //                   ),
            //
            //
            //
            //                 ],),
            //
            //             ],
            //           ),
            //         ),
            //
            //         const SizedBox(height: 10,),
            //
            //         Container(
            //           padding: EdgeInsets.symmetric(horizontal: 10),
            //           decoration: BoxDecoration(
            //               color: AppColors.teamcard2,
            //               borderRadius: BorderRadius.circular(10)),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //
            //             children: [
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: [
            //                   Padding(
            //                     padding: const EdgeInsets.only(left: 5.0,right: 10,top: 5),
            //                     child: Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Text("Google Map Link ",style: TextStyle(color: AppColors.temtextclr,fontSize: 16,fontWeight: FontWeight.bold),),
            //                         SizedBox(height: 15,),
            //
            //                         Text("Notes ",style: TextStyle(color: AppColors.temtextclr,fontSize: 16,fontWeight: FontWeight.bold),),
            //
            //
            //
            //                       ],
            //                     ),
            //                   ),
            //                   Padding(
            //                     padding: const EdgeInsets.only(left: 5,right: 5,top: 10, bottom: 10),
            //
            //                     child: Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //
            //                       children: [
            //                         Container(
            //                           color: Colors.white,
            //                           height: 40,
            //                           width: 170,
            //
            //                           child: TextFormField(
            //                             // controller: nameController,
            //                             style: TextStyle(color: AppColors.field, fontSize: 12),
            //                             keyboardType: TextInputType.name,
            //                             decoration: InputDecoration(
            //                                 hintStyle: TextStyle(fontSize: 12),
            //                                 hintText: 'Paste Google Map Link',
            //                                 border: InputBorder.none,
            //                                 contentPadding: EdgeInsets.only(bottom: 5,left: 5)
            //                             ),
            //                           ),
            //                         ),
            //                         SizedBox(height: 10,),
            //                         Container(
            //                           color: Colors.white,
            //                           height: 40,
            //                           width: 170,
            //                           child: TextFormField(
            //                             style: TextStyle(color: AppColors.field, fontSize: 12),                                  // controller: nameController,
            //                             keyboardType: TextInputType.name,
            //                             decoration: InputDecoration(
            //                                 hintStyle: TextStyle(fontSize: 12),
            //                                 hintText: 'Enter Short Instruction/ Time /etc. Map Link Link ',
            //                                 border: InputBorder.none,
            //                                 contentPadding: EdgeInsets.only(bottom: 5,left: 5)
            //                             ),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //
            //                 ],
            //               ),
            //               Container(
            //                 height: 35,
            //                 width: MediaQuery.of(context).size.width/1.7,
            //                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color:AppColors.pdfbtn),
            //                 child: Center(child: Text("PDF",
            //                   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
            //                 ),
            //                 ),
            //               ),
            //               const SizedBox(height: 10,),
            //             ],
            //           ),
            //         ),
            //
            //       ],
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 10,),



            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //   child: Container(
            //     decoration: BoxDecoration(
            //         color: AppColors.teamcard,
            //         borderRadius: BorderRadius.circular(10)),
            //     margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 7),
            //     width: double.infinity,
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         Container(
            //           padding: EdgeInsets.symmetric(horizontal: 15),
            //           height: 65,
            //           decoration: BoxDecoration(
            //               color: AppColors.teamcard2,
            //               borderRadius: BorderRadius.circular(10)),
            //           child: Row(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: const [
            //               Text("Client Name: Krishna Patel",style: TextStyle(color: AppColors.textclr,fontSize: 11,fontWeight: FontWeight.bold),),
            //               Text("Event: Edding",style: TextStyle(color: AppColors.textclr,fontSize: 11,fontWeight: FontWeight.bold),),
            //               Text("Vanue: Mumbai",style: TextStyle(color: AppColors.textclr,fontSize: 11,fontWeight: FontWeight.bold),),
            //
            //             ],
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
            //           child: Row(
            //             children: const [
            //               Text("Date: ",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 14),),
            //               SizedBox(width: 7,),
            //               Text("29-04-2023",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
            //             ],
            //           ),
            //         ),
            //         const SizedBox(height: 10,),
            //
            //         Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 8, ),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Column(
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children:  [
            //                   Container(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Photographer Name  ",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 14),),
            //                   ),
            //                   Padding(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Krishna Patel ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
            //                   ),
            //                   Padding(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Ajit Thakkar ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
            //                   ),
            //                   Padding(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Ramesh Prajapati ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
            //                   ),
            //                   Padding(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Mohit Khan ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
            //                   ),
            //
            //                 ],),
            //               Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Container(
            //                     width: 150,
            //
            //                     padding: const EdgeInsets.all(3.0),
            //
            //                     child: const Text("Type Of Photography",
            //                       overflow: TextOverflow.ellipsis,
            //
            //                       style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 14),),
            //                   ),
            //                   Container(
            //                     padding: const EdgeInsets.all(3.0),
            //                     width: 150,
            //
            //                     child: Text("Candid Photography",
            //                       overflow: TextOverflow.ellipsis,
            //                       style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),),
            //                   ),
            //                   const Padding(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Drone",style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),),
            //                   ),
            //                   const Padding(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Led",style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),),
            //                   ),
            //                   Padding(
            //                     padding: const EdgeInsets.all(3.0),
            //                     child: Container(
            //                         width: 180,
            //                         child: Text("Candid Chinematography",style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,)),
            //                   ),
            //
            //
            //
            //                 ],),
            //
            //             ],
            //           ),
            //         ),
            //
            //         const SizedBox(height: 10,),
            //
            //         Container(
            //           padding: EdgeInsets.symmetric(horizontal: 10),
            //           decoration: BoxDecoration(
            //               color: AppColors.teamcard2,
            //               borderRadius: BorderRadius.circular(10)),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //
            //             children: [
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: [
            //                   Padding(
            //                     padding: const EdgeInsets.only(left: 5.0,right: 10,top: 5),
            //                     child: Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Text("Google Map Link ",style: TextStyle(color: AppColors.temtextclr,fontSize: 16,fontWeight: FontWeight.bold),),
            //                         SizedBox(height: 15,),
            //
            //                         Text("Notes ",style: TextStyle(color: AppColors.temtextclr,fontSize: 16,fontWeight: FontWeight.bold),),
            //
            //
            //
            //                       ],
            //                     ),
            //                   ),
            //                   Padding(
            //                     padding: const EdgeInsets.only(left: 5,right: 5,top: 10, bottom: 10),
            //
            //                     child: Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //
            //                       children: [
            //                         Container(
            //                           color: Colors.white,
            //                           height: 40,
            //                           width: 170,
            //
            //                           child: TextFormField(
            //                             // controller: nameController,
            //                             style: TextStyle(color: AppColors.field, fontSize: 12),
            //                             keyboardType: TextInputType.name,
            //                             decoration: InputDecoration(
            //                                 hintStyle: TextStyle(fontSize: 12),
            //                                 hintText: 'Paste Google Map Link',
            //                                 border: InputBorder.none,
            //                                 contentPadding: EdgeInsets.only(bottom: 5,left: 5)
            //                             ),
            //                           ),
            //                         ),
            //                         SizedBox(height: 10,),
            //                         Container(
            //                           color: Colors.white,
            //                           height: 40,
            //                           width: 170,
            //                           child: TextFormField(
            //                             style: TextStyle(color: AppColors.field, fontSize: 12),                                  // controller: nameController,
            //                             keyboardType: TextInputType.name,
            //                             decoration: InputDecoration(
            //                                 hintStyle: TextStyle(fontSize: 12),
            //                                 hintText: 'Enter Short Instruction/ Time /etc. Map Link Link ',
            //                                 border: InputBorder.none,
            //                                 contentPadding: EdgeInsets.only(bottom: 5,left: 5)
            //                             ),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //
            //                 ],
            //               ),
            //               Container(
            //                 height: 35,
            //                 width: MediaQuery.of(context).size.width/1.7,
            //                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color:AppColors.pdfbtn),
            //                 child: Center(child: Text("PDF",
            //                   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
            //                 ),
            //                 ),
            //               ),
            //               const SizedBox(height: 10,),
            //             ],
            //           ),
            //         ),
            //
            //       ],
            //     ),
            //   ),
            // ),

          ],
        ),
      ),
    );
  }
}
