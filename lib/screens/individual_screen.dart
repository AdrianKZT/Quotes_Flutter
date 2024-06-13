import 'package:flutter/material.dart';
import 'package:quotes/model/quotes_model.dart';

class IndividualScreen extends StatelessWidget {

  final Quotes quotes;
  const IndividualScreen({ super.key , required this.quotes });

  @override
  Widget build(BuildContext context){    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //Remove the back arrow button
        title: Text("Quote ID: ${quotes.id}", style: const TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
              Container(    
                  width: 350,
                  height: 350,
                  padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),          
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            quotes.quote,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic
                            ),
                          ),
                        ),
                        Text(
                          quotes.author,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    )
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);  
                  }, 
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text("Back to Home", style: TextStyle(color: Colors.white),)
                )
              ],
            )
          )
    );
  }
}