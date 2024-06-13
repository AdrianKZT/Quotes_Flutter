import 'package:flutter/material.dart';
import 'package:quotes/api/quotes.dart';
import 'package:quotes/model/quotes_model.dart';

class ShowAll extends StatefulWidget {
  const ShowAll({ super.key });

  @override
  _ShowAllState createState() => _ShowAllState();
}

class _ShowAllState extends State<ShowAll> {
  late Future<List<Quotes>> futureQuotes;
  List<Quotes> allQuotes = [];

  @override
  void initState() {
    super.initState();
    futureQuotes = QuotesApi().getQuotes();
    futureQuotes.then((value) {
      setState(() {
        allQuotes = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("All Quotes", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FutureBuilder<List<Quotes>>(
              future: futureQuotes,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Failed to load Quotes, Please try again"));
                } else {
                  return ListView.builder(
                    itemCount: allQuotes.length,
                    itemBuilder: (context, index) {
                      return QuotesModel(quote: allQuotes[index]);
                    }
                  );
                }
              }
            )
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 25)  ,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text("Back to Home", style: TextStyle(color: Colors.white),)
            ),
          )
        ],
      )
    );
  }
}