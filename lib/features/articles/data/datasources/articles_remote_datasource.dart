import 'package:rafiq/features/articles/data/models/articles_model.dart';

class ArticleRemoteDataSource {
  final List<ArticlesModel> _mockArticles = [
    ArticlesModel(
      id: 1,
      title: "نصائح للحفاظ على صحة القلب",
      image: "https://i.imgur.com/8Km9tLL.jpg",
      category: "تغذية",
      readTime: 10,
      authorName: " د/ محمد علي",
      authorImage: "https://i.pravatar.cc/150?img=3",
      content: [
        ArticleSection(
          title: "",
          description:
              "تعتبر أمراض القلب من الأسباب الرئيسية للوفاة حول العالم. ولكن الخبر الجيد هو أن معظم هذه الأمراض يمكن الوقاية منها. كل ما عليك فعله هو اتباع خطوات صحية يوميًا. في هذا المقال، سنستعرض أهم الخطوات التي يمكنك اتخاذها اليوم لحماية قلبك.",
        ),
        ArticleSection(
          title: "1. التغذية السليمة هي الأساس",
          description:
              "تبدأ صحة القلب من طبق الطعام. ينصح الأطباء بتناول الدهون الصحية مثل زيت الزيتون، والتركيز على الخضروات والفواكه والحبوب الكاملة. كما أن تقليل الملح والسكريات الزائدة يساعد القلب بشكل كبير.",
        ),
        ArticleSection(
          title: "2. التحكم في التوتر",
          description:
              "الإجهاد المزمن يمكن أن يؤدي إلى ارتفاع ضغط الدم، مما يزيد من احتمالية الإصابة بمشاكل القلب. حاول ممارسة تمارين الاسترخاء مثل التأمل أو المشي، وقم بتخصيص وقت ممتع مع العائلة والأصدقاء. أيضًا، لا تنسَ أن النوم الجيد يساعد في الحفاظ على ضغط دم صحي.",
        ),
      ],
    ),

    ArticlesModel(
      id: 2,
      title: "أفضل الأطعمة لصحة القلب",
      image: "https://i.imgur.com/z4d4kWk.jpg",
      category: "تغذية",
      readTime: 6,
      authorName: "د/ أحمد علي",
      authorImage: "https://i.pravatar.cc/150?img=4",
      content: [
        ArticleSection(
          title: "",
          description:
              "تعتبر أمراض القلب من الأسباب الرئيسية للوفاة حول العالم. ولكن الخبر الجيد هو أن معظم هذه الأمراض يمكن الوقاية منها. كل ما عليك فعله هو اتباع خطوات صحية يوميًا. في هذا المقال، سنستعرض أهم الخطوات التي يمكنك اتخاذها اليوم لحماية قلبك.",
        ),
        ArticleSection(
          title: "1. التغذية السليمة هي الأساس",
          description:
              "تبدأ صحة القلب من طبق الطعام. ينصح الأطباء بتناول الدهون الصحية مثل زيت الزيتون، والتركيز على الخضروات والفواكه والحبوب الكاملة. كما أن تقليل الملح والسكريات الزائدة يساعد القلب بشكل كبير.",
        ),
        ArticleSection(
          title: "2. التحكم في التوتر",
          description:
              "الإجهاد المزمن يمكن أن يؤدي إلى ارتفاع ضغط الدم، مما يزيد من احتمالية الإصابة بمشاكل القلب. حاول ممارسة تمارين الاسترخاء مثل التأمل أو المشي، وقم بتخصيص وقت ممتع مع العائلة والأصدقاء. أيضًا، لا تنسَ أن النوم الجيد يساعد في الحفاظ على ضغط دم صحي.",
        ),
      ],
    ),
  ];

  Future<List<ArticlesModel>> getArticles() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockArticles;
  }

  Future<ArticlesModel> getArticleById(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockArticles.firstWhere((a) => a.id == id);
  }
}
