import 'package:brainbinary_structure/screen/city/city_view_model.dart';
import 'package:brainbinary_structure/screen/city/widget/city_list_item.dart';
import 'package:brainbinary_structure/utils/app.dart';
import 'package:brainbinary_structure/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CityScreen extends StatelessWidget {
  final String country;

  CityScreen(this.country);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CityViewModel>.reactive(
      onModelReady: (model) async {
        model.init(country);
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppRes.city),
          ),
          body: model.isBusy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : model.cities == null
                  ? Center(
                      child: Text("API ISSUE"),
                    )
                  : ListView.builder(
                      itemCount: model.cities.data.length > 30
                          ? 30
                          : model.cities.data.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () => model.countryItemClick(index),
                        child: CityListItem(
                          model.cities.data[index].city,
                          model.selectedCity,
                          index,
                        ),
                      ),
                    ),
          bottomNavigationBar: model.isBusy
              ? null
              : BottomBar(
                  onContinue: () => model.continueClick(model.selectedCity),
                ),
        );
      },
      viewModelBuilder: () => CityViewModel(),
    );
  }
}
