import 'package:c4e_rewards/common/size_config.dart';
import 'package:c4e_rewards/constants.dart';
import 'package:c4e_rewards/custom_decoratoin.dart';
import 'package:c4e_rewards/models/promotion_sheet.dart';
import 'package:c4e_rewards/models/result_status.dart';
import 'package:c4e_rewards/screens/promotion_screen.dart';
import 'package:c4e_rewards/view_models/product_list_vm.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BannerImage extends StatefulWidget {
  const BannerImage({super.key});

  @override
  State<BannerImage> createState() => _BannerImageState();
}

class _BannerImageState extends State<BannerImage> {


  Future<ResultStatus> _fetchProductAds(BuildContext context,
  {bool forceFetch = false}) async {
  return await Provider.of<ProductListVM>(context, listen: false)
      .getProductAds(forceFetch);
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ResultStatus>(
        future: _fetchProductAds(context),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return skeletonCarousel(context, height: 120);
          }
          return Selector<ProductListVM, List<Products>>(
            shouldRebuild: (previous, next)=> previous != next,
            selector: (context, provider)=> provider.productAdsForBanner,
              builder: (context, banner, child){
              if(banner.isEmpty){
                return blankCarousel(
                    context,
                  function: (){
                      setState(() {
                        _fetchProductAds(context, forceFetch: true);
                      });
                  }
                );
              }
              return Padding(
                padding: EdgeInsets.only(
                  bottom: getProportionateScreenHeight(15),
                ),
                child: Column(
                  children: [
                    CarouselSlider.builder(
                      itemCount: banner.length,
                      itemBuilder: (context, index, realIndex) => Container(
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
                                banner[index].image,
                                headers: banner[index].imgCookie,
                              ),
                              fit: BoxFit.cover,
                            ),
                          )),
                      options: CarouselOptions(
                          aspectRatio: 30 / 9,
                          // height: getProportionateScreenHeight(200),
                          enlargeCenterPage: true,
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          autoPlay: false),
                    )
                  ],
                ),
              );
              },

          );
        }
    );
  }
}
