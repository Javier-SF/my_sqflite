import 'package:flutter/material.dart';

class PaginatedListView extends StatefulWidget {
  const PaginatedListView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PaginatedListViewState createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  final ScrollController _scrollController = ScrollController();
  final List<int> _data = List.generate(19, (index) => index);
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
  }

  void _loadMoreData() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      // Simulando una carga de datos desde una API
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _data.addAll(List.generate(20, (index) => _data.length + index));
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paginated ListView'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _data.length,
        itemBuilder: (context, index) {
          if (index == _data.length) {
            return _isLoading
                ? Center(child: CircularProgressIndicator())
                : SizedBox.shrink();
          }
          return ListTile(
            title: Text('Item ${_data[index]}'),
          );
        },
      ),
    );
  }
}
