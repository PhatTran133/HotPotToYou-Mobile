import 'package:auto_size_text/auto_size_text.dart';
import 'package:electronic_equipment_store/models/h_hotpot_model.dart';
import 'package:electronic_equipment_store/models/h_pot_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants/color_constants.dart';
import '../../core/constants/dismension_constants.dart';
import '../../core/constants/textstyle_constants.dart';
import '../../models/product_model.dart';

class PotCard extends StatefulWidget {
  final PotModel product;

  const PotCard({
    super.key,
    required this.product,
  });

  @override
  State<PotCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<PotCard> {
  bool isFavorite = false;
  final AutoSizeGroup autoSizeGroup = AutoSizeGroup();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kDefaultCircle14),
      child: Container(
        color: ColorPalette.hideColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //img
                AspectRatio(
                  aspectRatio: 13 / 9,
                  child: Image.network(widget.product.Url,
                      fit: BoxFit.cover),
                ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 160,
                    child: AutoSizeText(
                      overflow: TextOverflow.ellipsis,
                      minFontSize: 16,
                      maxLines: 2,
                      widget.product.Name,
                      style: TextStyles.h5.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  //Price
                                    
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 160,
                          child: AutoSizeText.rich(
                            group: autoSizeGroup,
                            minFontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: 'kích thước: ',
                                    style: TextStyles.defaultStyle.bold),
                                 TextSpan(
                                  text: widget.product.Size,
                                  
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6,),
                    SizedBox(
                      width: 160,
                      child: AutoSizeText.rich(
                        group: autoSizeGroup,
                        maxLines: 2,
                        TextSpan(
                          children: [
                            const TextSpan(
                                text: 'Giá: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text:
                                  NumberFormat.currency(locale: 'vi_VN', symbol: 'vnđ').format(widget.product.Price),
                                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10)
          ],
          
        ),
      ),
    );
  }
}
