import 'package:flutter/material.dart';
import 'package:http_city/http_city/model/http_city_model.dart';
import '../viewModel/http_city_view_model.dart';

class HttpCityView extends HttpCityViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView.builder(
        itemCount: httpCity.length,
        itemBuilder: (context, index) => buildCardHttp(httpCity[index]),
      ),
    );
  }

  Card buildCardHttp(HttpCityModel city) {
    return Card(
      margin: EdgeInsets.all(20),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.35,
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.network(city.imageUrl),
          ),
          subtitle: Text(
            city.description,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: appBarBuildText(),
      leading: buildPaddingProgress,
    );
  }

  Widget get buildPaddingProgress {
    return Visibility(
      visible: isLoading,
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }

  Text appBarBuildText() => Text("Turkey");
}
