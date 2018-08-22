import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

//void main() => runApp(MyAppA());

class MyAppA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Hello to Flutter.',
        home: new RandomWords());
  }
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Setup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved)],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext context, int i) {
          if (i.isOdd) {
            return new Divider();
          }
          final int index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(pair.asPascalCase, style: _biggerFont),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: (){
        setState(() {
          if(alreadySaved){
            _saved.remove(pair);
          }else{
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved(){
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
          builder: (BuildContext context){
            final Iterable<ListTile> tiles = _saved.map((WordPair pair){
              return new ListTile(
                title: new Text(pair.asPascalCase, style: _biggerFont),
              );
            });
            final List<Widget> divided = ListTile.divideTiles(
                tiles: tiles, context: context).toList();
            return new Scaffold(
              appBar: new AppBar(title: const Text('Saved Suggestions')),
              body: new ListView(children: divided),
            );
          })
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}
