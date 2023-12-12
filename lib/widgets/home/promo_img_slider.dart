import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/result_status.dart';
import '../../models/promotion_sheet.dart';
import '../../constants.dart';
import '../../screens/promotion_screen.dart';
import '../../custom_decoratoin.dart';
import '../../view_models/product_list_vm.dart';
import '../../common/size_config.dart';

class PromoImgSlider extends StatefulWidget {
  const PromoImgSlider({Key? key}) : super(key: key);

  @override
  State<PromoImgSlider> createState() => _PromoImgSliderState();
}

class _PromoImgSliderState extends State<PromoImgSlider> {
  Future<ResultStatus> _fetchProductAds(BuildContext context,
      {bool forceFetch = false}) async {
    return await Provider.of<ProductListVM>(context, listen: false)
        .getProductAds(forceFetch);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ResultStatus>(
        future: _fetchProductAds(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return skeletonCarousel(context);
          }
          return Selector<ProductListVM, List<Products>>(
              shouldRebuild: (previous, next) => previous != next,
              selector: (context, provider) => provider.productAdsForCampaign,
              builder: (context, campaign, child) {
                if (campaign.isEmpty) {
                  return blankCarousel(
                    context,
                    function: () {
                      setState(() {
                        _fetchProductAds(context, forceFetch: true);
                      });
                    },
                  );
                }
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: getProportionateScreenHeight(15),
                  ),
                  child: Column(
                    children: [
                      CarouselSlider.builder(
                        itemCount: campaign.length,
                        itemBuilder: (context, index, realIndex) => InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              createRoute(
                                PromotionScreen(campaign: campaign[index]),
                              ),
                            );
                          },
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: FadeInImage(
                                  placeholder: const AssetImage(
                                      AssetImagePath.c4eFadeinImg),
                                  image: NetworkImage(
                                    campaign[index].image,
                                    headers: campaign[index].imgCookie,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ),
                        options: CarouselOptions(
                            aspectRatio: 16 / 9,
                            // height: getProportionateScreenHeight(200),
                            enlargeCenterPage: true,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            autoPlay: true),
                      )
                    ],
                  ),
                );
              });
        });
  }
}
