import 'package:order/data/model/get_group_category_model.dart' as m;
import 'package:order/data/model/get_white_goods_model.dart' as mwg;
import 'package:newwg_repository/newwg_repository.dart';

const empty = "";
const zero = 0;

extension GetGroupCategoriesMapper on GetGroupCategoryResponse {
  m.GetGroupCategoryModel toModel() {
    return m.GetGroupCategoryModel(
      code: code ?? zero,
      messages: messages ?? empty,
      errors: errors ?? empty,
      data: data!
          .map((e) => m.GroupCategory(
                id: e.id ?? zero,
                code: e.code ?? empty,
                name: e.name ?? empty,
                isAllowMultiAsset: e.isAllowMultiAsset ?? false,
                notes: e.notes ?? empty,
              ))
          .toList(),
    );
  }
}

extension GetWhiteGoodsMapper on GetWhiteGoodsResponse {
  mwg.GetWhiteGoodsModel toModel() {
    return mwg.GetWhiteGoodsModel(
      code: code ?? zero,
      messages: messages ?? empty,
      errors: errors ?? empty,
      data: data!
          .map((e) => mwg.WhiteGoods(
                assetCode: e.assetCode ?? empty,
                description: e.description ?? empty,
                categoryId: e.categoryId ?? empty,
                categoryName: e.categoryName ?? empty,
              ))
          .toList(),
      pageInfo: mwg.PageInfo(
        limit: pageInfo!.limit ?? zero,
        nextPage: pageInfo!.nextPage ?? zero,
        offset: pageInfo!.offset ?? zero,
        page: pageInfo!.page ?? zero,
        prevPage: pageInfo!.prevPage ?? zero,
        totalPage: pageInfo!.totalPage ?? zero,
        totalRecord: pageInfo!.totalRecord ?? zero,
      ),
    );
  }
}
