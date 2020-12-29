import 'package:qarinli/models/category.dart';
import 'package:qarinli/models/fetchedProducts.dart';

List<Category> topCategories = [
  Category(
    name: 'موبايلات وتابلت',
    id: 778,
    imageUrl: 'assets/top_categories/mobs.png',
    fetchedProducts:
        FetchedProducts(products: [], totalPages: 0, totalResults: 0),
    productsIsLoading: false,
    currentPage: 1,
    subCategories: [
      Category(id: 779, name: 'جوالات'),
      Category(id: 780, name: 'تابلت وقارىء رقمي'),
      Category(id: 781, name: 'اكسسوارات جوالات وتقنية'),
    ],
  ),
  Category(
    name: 'كمبيوتر ولابتوب',
    id: 783,
    imageUrl: 'assets/top_categories/laptops.png',
    fetchedProducts:
        FetchedProducts(products: [], totalPages: 0, totalResults: 0),
    productsIsLoading: false,
    currentPage: 1,
    subCategories: [
      Category(id: 784, name: 'لابتوب'),
      Category(id: 785, name: 'طابعات و حبر'),
    ],
  ),
  Category(
    name: 'الأجهزة المنزلية',
    id: 1179,
    imageUrl: 'assets/top_categories/homeEquipments.png',
    fetchedProducts:
        FetchedProducts(products: [], totalPages: 0, totalResults: 0),
    productsIsLoading: false,
    currentPage: 1,
    subCategories: [
      Category(id: 1180, name: 'اجهزة صغيرة'),
      Category(id: 1662, name: 'تلفزيونات'),
      Category(id: 1695, name: 'مكيف الهواء')
    ],
  ),
  Category(
    name: 'عطور',
    id: 794,
    imageUrl: 'assets/top_categories/ator.png',
    fetchedProducts:
        FetchedProducts(products: [], totalPages: 0, totalResults: 0),
    productsIsLoading: false,
    currentPage: 1,
    subCategories: [
      Category(id: 795, name: 'عطر رجالي'),
      Category(id: 796, name: 'عطر نسائي')
    ],
  ),
  Category(
    name: 'أزياء',
    id: 797,
    imageUrl: 'assets/top_categories/clothes.png',
    fetchedProducts:
        FetchedProducts(products: [], totalPages: 0, totalResults: 0),
    productsIsLoading: false,
    currentPage: 1,
    subCategories: [
      Category(id: 798, name: 'أزياء الرجل'),
      Category(id: 799, name: 'أزياء المرأه'),
      Category(id: 2163, name: 'أزياء الأطفال')
    ],
  ),
];
