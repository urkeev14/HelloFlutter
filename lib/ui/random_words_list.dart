import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWordsList extends StatefulWidget {
  const RandomWordsList({Key? key}) : super(key: key);

  @override
  _RandomWordsListState createState() => _RandomWordsListState();
}

class _RandomWordsListState extends State<RandomWordsList> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  final _saved = <WordPair>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: [
          IconButton(
            onPressed: _pushSaved,
            icon: const Icon(Icons.list),
            tooltip: "Saved suggestions",
          )
        ],
      ),
      body: _buildSuggestionList(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      // Add lines from here...
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ), // ...to here.
    );
  }

  Widget _buildSuggestionList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (BuildContext _context, int i) {
        if (i.isOdd) {
          return const Divider();
        }

        final int index = i ~/ 2;

        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final isAlreadySaved = _saved.contains(pair);
    return ListTile(
      leading: const Icon(Icons.account_circle),
      trailing: Icon(
        isAlreadySaved ? Icons.favorite : Icons.favorite_border,
        color: isAlreadySaved ? Colors.red : null,
        semanticLabel: isAlreadySaved ? 'Remove from saved' : 'Save',
      ),
      dense: true,
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      subtitle: Text(pair.second),
      tileColor: Colors.white10,
      onTap: () {
        setState(() {
          onFavoriteClick(isAlreadySaved, pair);
        });
      },
    );
  }

  void onFavoriteClick(bool isAlreadySaved, WordPair pair) {
    if (isAlreadySaved) {
      _saved.remove(pair);
    } else {
      _saved.add(pair);
    }
  }
}
