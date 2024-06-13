import 'package:flutter/material.dart';
import 'package:quotes/api/quotes.dart';
import 'package:quotes/model/quotes_model.dart';
import 'package:quotes/screens/individual_screen.dart';
import 'package:quotes/screens/show_all.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ super.key });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final QuotesApi quotesApi = QuotesApi();
  Quotes? currentQuote;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchInitialQuote();
  }

  //FUNCTION TO GET THE QUOTES
  void fetchInitialQuote() async {
    try {
      List<Quotes> quotes = await quotesApi.getQuotes();
      setState(() {
        currentQuote = quotes.first;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      // Handle error
      print('Failed to fetch quotes: $error');
    }
  }

  //FUNCTION TO GET RANDOM QUOTES
  void fetchNewQuote() async {
  setState(() {
    isLoading = true;
  });
  try {
    final quotesApi = QuotesApi();
    final Quotes quote = await quotesApi.getRandomQuote();
    setState(() {
      currentQuote = quote;
      isLoading = false;
    });
  } catch (error) {
    setState(() {
      isLoading = false;
    });
    print('Failed to fetch quotes: $error');
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: const Text(
          "Quote of the day",
          style: TextStyle(color: Colors.white),
        ),
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
                    child: InkWell(
                onTap: () {
                  if (!isLoading && currentQuote != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IndividualScreen(quotes: currentQuote!),
                      ),
                    );
                  }
                },
                child: Center(
                  child: isLoading
                      ? const CircularProgressIndicator(
                        color: Colors.blue,
                      )
                      : Text(
                          currentQuote!.quote,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 45),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: fetchNewQuote,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text(
                    'Refresh',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ShowAll()),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text(
                    'Show All',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
