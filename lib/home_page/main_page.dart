import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:ai_bot/const_key/key.dart';
import 'package:ai_bot/home_page/model/model_message.dart';
import 'package:intl/intl.dart';
class mainPage extends StatefulWidget {
  final String user;
  const mainPage({super.key,required this.user});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  final _textController = TextEditingController();
  final model = GenerativeModel(model:'gemini-1.5-flash-latest', apiKey: safeKey.apiKey);
  List<modelMessage> prompt = [];
  Future<void> sendMessage () async {
    final String message = _textController.text.trim();
    setState(() {
      _textController.clear();
      prompt.add(modelMessage(isPrompt: true , message: message, dateTime: DateTime.now()));
    });
    final content = [Content.text(message)];
    final response = await model.generateContent(content);
    setState(() {
      prompt.add(modelMessage(isPrompt: false , message: response.text??"Couldn't generate a response", dateTime: DateTime.now()));
    });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(50, 49, 49, 1),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: const Color.fromRGBO(50, 49, 49, 1),
        child: Column(
          children: [
            const SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(onPressed: (){}, icon: Icon(Icons.menu,color: Colors.white.withOpacity(.8),)),
                const SizedBox(width: 90,),
                Text('Dynamo',style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(.8),
                  fontSize: 21
                ),),
                const SizedBox(width: 90,),
                Icon(Icons.supervised_user_circle,color: Colors.white.withOpacity(.8),size: 30,)
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              children: [
                const SizedBox(width: 20,),
                Text('Hi, ${widget.user}',style: GoogleFonts.roboto(
                  color: Colors.white.withOpacity(.8),
                  fontWeight: FontWeight.bold,
                  fontSize: 24
                ),)
              ],
            ),
            const SizedBox(height: 20,),
            Column(
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width-30,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      controller: _textController,
                      minLines: 1,
                      maxLines: 10,
                      style: GoogleFonts.roboto(
                        color: Colors.white.withOpacity(.8),
                        letterSpacing: 0.8
                      ),
                      decoration: InputDecoration(
                          hintText: 'Enter a prompt here',
                          prefixIcon: Icon(Icons.search,color: Colors.white.withOpacity(.8),),
                          suffixIcon: IconButton(
                            onPressed: (){
                              sendMessage();
                            },
                            icon: Icon(Icons.send_rounded,color: Colors.white.withOpacity(.8),), 
                          ),
                          hintStyle: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(.7),
                          ),
                          contentPadding: const  EdgeInsets.symmetric(horizontal:20),
                          border: const OutlineInputBorder(borderSide: BorderSide.none)
                      ),
                    ),
                  ),
                ]),
            const SizedBox(height: 10,),
            Expanded(
              flex: 1,
              child: ListView.builder(
                  itemCount:prompt.length,
                  itemBuilder: (context,index){
                    final message = prompt[index];
                    return userPrompt( message.isPrompt , index, message);
                  }),
            ),
          ],
        )
      ),
    );
  }

   userPrompt(final bool isPrompt , int index, modelMessage message) {
    return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 20).copyWith(left: isPrompt?80:15),
                    decoration: BoxDecoration(
                      color: isPrompt ? Colors.green : Colors.white.withOpacity(.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text(
                          message.message, style: GoogleFonts.roboto(
                              fontWeight: isPrompt ? FontWeight.bold : FontWeight.w500,
                              fontSize: 18,
                              letterSpacing: 0.8,
                              color: isPrompt ? Colors.white:Colors.white.withOpacity(.8)
                            ),).animate().fadeIn(duration: const Duration(milliseconds: 400)),

                        Text(DateFormat('hh:mm a').format(message.dateTime),
                          style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: isPrompt ? Colors.white:Colors.white.withOpacity(.8)
                        ),)
                      ],
                    ),
                  );
  }
}
