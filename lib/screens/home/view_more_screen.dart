import 'package:jobCafeApp/utils/provider.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../models/store.dart';
import '../components/store_card.dart';
import '../components/app_bar.dart';

class ViewMoreScreen extends StatefulWidget {
  final String title;

  const ViewMoreScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<ViewMoreScreen> createState() => _ViewMoreScreenState();
}

class _ViewMoreScreenState extends State<ViewMoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _fetchData,
          child: FutureBuilder(
            future: _fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                List<Store> stores = UtilProvider.of(context).storeList;
                return CustomScrollView(
                  slivers: <Widget>[
                    _buildSliverAppBar(context),
                    _buildSliverList(stores),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return sliverAppBar(context, title: widget.title);
  }

  Widget _buildSliverList(List<Store> stores) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              var store = stores[index];
          return Padding(
            padding: pd24242400,
            child: StoreCard(store: store),
          );
        },
        childCount: stores.length,
      ),
    );
  }

  Future<void> _fetchData() async {
    UtilProvider.getAndSetStores(context, index: 0);
  }
}