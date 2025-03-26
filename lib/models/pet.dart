class Pet {
  final String breed;
  final String imagePath;
  final String category;
  final String description;
  final String? size;
  final String? coatLength;
  final String? origin;

  Pet({
    required this.breed,
    required this.imagePath,
    required this.category,
    required this.description,
    this.size,
    this.coatLength,
    this.origin,
  });

  static List<Pet> getSamplePets() {
    return [
      // 貓咪品種
      Pet(
        breed: '緬因貓',
        imagePath: 'assets/images/maine.jpg',
        category: 'cat',
        coatLength: 'long',
        origin: '美國',
        description:
            '緬因貓（Maine Coon）是北美洲最大的家貓品種，以其巨大的體型和友善的性格聞名。它們原產於美國緬因州，毛髮長而防水，適應寒冷環境。緬因貓聰明且活潑，喜歡與人互動，被稱為「溫柔的巨人」。',
      ),
      Pet(
        breed: '暹羅貓',
        imagePath: 'assets/images/siamese.jpg',
        category: 'cat',
        coatLength: 'short',
        origin: '泰國',
        description:
            '暹羅貓（Siamese）以其優雅的身形和藍色眼睛聞名，毛色通常為淺色身體搭配深色斑點。它們原產於泰國，性格活潑且愛說話，喜歡與主人互動。暹羅貓非常聰明，對主人忠誠，但可能有些固執。',
      ),
      Pet(
        breed: '布偶貓',
        imagePath: 'assets/images/ragdoll.jpg',
        category: 'cat',
        coatLength: 'long',
        origin: '美國',
        description:
            '布偶貓（Ragdoll）以其溫順的性格和柔軟的長毛聞名，抱起來像布偶一樣柔軟。它們由美國人安·貝克於1960年代培育出來，性格溫和且黏人，喜歡與人相處。布偶貓需要定期梳理毛髮，適合家庭飼養。',
      ),
      Pet(
        breed: '英國短毛貓',
        imagePath: 'assets/images/british_shorthair.jpg',
        category: 'cat',
        coatLength: 'short',
        origin: '英國',
        description:
            '英國短毛貓（British Shorthair）以其圓潤的臉龐和厚實的毛髮聞名，性格溫和且獨立。它們是英國最古老的貓種之一，最初用於控制鼠害，現在是受歡迎的家庭寵物。英國短毛貓喜歡安靜的環境，對主人忠誠但不黏人。',
      ),
      Pet(
        breed: '美國短毛貓',
        imagePath: 'assets/images/america_shorthair.jpg',
        category: 'cat',
        coatLength: 'short',
        origin: '美國',
        description:
            '美國短毛貓（American Shorthair）以其強壯的體型和短而密的毛髮聞名，性格溫和且適應力強。它們最初由歐洲移民帶到美國，用於控制農場的鼠害，經過多年的自然繁育，成為美國最受歡迎的貓種之一。美國短毛貓喜歡與人互動，適合家庭飼養。',
      ),
      Pet(
        breed: '波斯貓',
        imagePath: 'assets/images/persian.jpg',
        category: 'cat',
        coatLength: 'long',
        origin: '伊朗',
        description:
            '波斯貓（Persian）以其長而濃密的毛髮和扁平的臉部聞名，性格溫和且安靜。它們原產於伊朗，喜歡舒適的室內環境，對主人溫柔但不喜歡過多活動。波斯貓需要每天梳理毛髮以防止打結。',
      ),
      Pet(
        breed: '孟加拉貓',
        imagePath: 'assets/images/bengal.jpg',
        category: 'cat',
        coatLength: 'short',
        origin: '美國',
        description:
            '孟加拉貓（Bengal）以其豹紋般的毛色和野性外觀聞名，性格活潑且好動。它們是美國培育的混種貓，結合了亞洲豹貓的基因，喜歡攀爬和玩耍。孟加拉貓需要大量活動空間，適合活躍的主人。',
      ),
      Pet(
        breed: '阿比西尼亞貓',
        imagePath: 'assets/images/abyssinian.jpg',
        category: 'cat',
        coatLength: 'short',
        origin: '衣索比亞',
        description:
            '阿比西尼亞貓（Abyssinian）以其纖細的身形和活潑的性格聞名，毛色通常帶有斑點。它們據信起源於衣索比亞，喜歡探索和跳躍，智商高且好奇心強。阿比西尼亞貓適合有時間陪伴的主人。',
      ),
      Pet(
        breed: '蘇格蘭摺耳貓',
        imagePath: 'assets/images/scottish_fold.jpg',
        category: 'cat',
        coatLength: 'short',
        origin: '英國',
        description:
            '蘇格蘭摺耳貓（Scottish Fold）以其獨特的摺耳和圓潤的臉龐聞名，性格溫和且安靜。它們起源於英國蘇格蘭，因基因突變導致耳朵摺疊。蘇格蘭摺耳貓喜歡與人相處，但需要注意關節健康問題。',
      ),
      Pet(
        breed: '挪威森林貓',
        imagePath: 'assets/images/norwegian_forest.jpg',
        category: 'cat',
        coatLength: 'long',
        origin: '挪威',
        description:
            '挪威森林貓（Norwegian Forest Cat）以其濃密的長毛和強壯的體型聞名，適應寒冷環境。它們原產於挪威，性格友善且獨立，喜歡攀爬和狩獵。挪威森林貓需要定期梳理毛髮，適合有戶外空間的家庭。',
      ),
      Pet(
        breed: '俄羅斯藍貓',
        imagePath: 'assets/images/russian_blue.jpg',
        category: 'cat',
        coatLength: 'short',
        origin: '俄羅斯',
        description:
            '俄羅斯藍貓（Russian Blue）以其短而密的藍色毛髮和綠色眼睛聞名，性格溫和且害羞。它們原產於俄羅斯，對陌生人較為謹慎，但對主人非常忠誠。俄羅斯藍貓喜歡安靜的環境，毛髮護理需求低。',
      ),
      Pet(
        breed: '曼赤肯貓',
        imagePath: 'assets/images/munchkin.jpg',
        category: 'cat',
        coatLength: 'short',
        origin: '美國',
        description:
            '曼赤肯貓（Munchkin）以其短腿和活潑的性格聞名，體型小巧但行動敏捷。它們起源於美國，因基因突變導致腿短，喜歡玩耍和探索。曼切堪貓適合家庭飼養，但需要注意脊椎健康。',
      ),
      Pet(
        breed: '埃及貓',
        imagePath: 'assets/images/egyptian_mau.jpg',
        category: 'cat',
        coatLength: 'short',
        origin: '埃及',
        description:
            '埃及貓（Egyptian Mau）以其自然的斑點毛色和優雅的身形聞名，性格活潑且敏捷。它們原產於埃及，是少數自然形成的品種，喜歡跑跳和狩獵。埃及貓對主人忠誠，適合有活動空間的家庭。',
      ),
      Pet(
        breed: '土耳其安哥拉貓',
        imagePath: 'assets/images/turkish_angora.jpg',
        category: 'cat',
        coatLength: 'long',
        origin: '土耳其',
        description:
            '土耳其安哥拉貓（Turkish Angora）以其優雅的長毛和纖細的身形聞名，性格活潑且聰明。它們原產於土耳其，通常有白色毛髮和異色眼，喜歡與人互動。土耳其安哥拉貓需要定期梳理毛髮，適合活躍的主人。',
      ),
      Pet(
        breed: '日本短尾貓',
        imagePath: 'assets/images/japanese_bobtail.jpg',
        category: 'cat',
        coatLength: 'short',
        origin: '日本',
        description:
            '日本短尾貓（Japanese Bobtail）以其短而彎曲的尾巴聞名，性格友善且好動。它們原產於日本，常被認為是幸運的象徵，喜歡玩耍和與人相處。日本短尾貓毛髮護理需求低，適合家庭飼養。',
      ),
      Pet(
        breed: '東奇尼貓',
        imagePath: 'assets/images/tonkinese.jpg',
        category: 'cat',
        coatLength: 'short',
        origin: '加拿大',
        description:
            '東奇尼貓（Tonkinese）是暹羅貓和緬甸貓的混種，以其溫和的性格和短毛聞名。它們起源於加拿大，毛色多樣且有光澤，喜歡與人互動且愛說話。東奇尼貓適合喜歡陪伴的主人。',
      ),
      Pet(
          breed: '索馬利貓',
          imagePath: 'assets/images/somali.jpg',
          category: 'cat',
          coatLength: 'long',
          origin: '美國',
          description:
              '索馬利貓，是一種長毛貓，為阿比西尼亞貓的近親品種。起源於1967年，是由突變的長毛阿比西尼亞貓作為親貓，有計劃培育出的品種。其身長略大於阿比西尼亞貓，尾巴厚實。性格好動聰明，叫聲悅耳，但畏寒。'),
      Pet(
        breed: '雪鞋貓',
        imagePath: 'assets/images/snowshoe.jpg',
        category: 'cat',
        coatLength: 'short',
        origin: '美國',
        description:
            '雪鞋貓（Snowshoe）以其白色腳掌和藍色眼睛聞名，是暹羅貓和美國短毛貓的混種。它們起源於美國，性格溫和且愛說話，喜歡與人互動。雪鞋貓毛髮護理簡單，適合家庭飼養。',
      ),
      Pet(
        breed: '巴厘貓',
        imagePath: 'assets/images/balinese.jpg',
        category: 'cat',
        coatLength: 'long',
        origin: '美國',
        description:
            '巴厘貓（Balinese）是暹羅貓的長毛變種，以其優雅的身形和藍色眼睛聞名。它們起源於美國，性格活潑且愛說話，喜歡與主人互動。巴厘貓需要適量梳理毛髮，適合喜歡陪伴的主人。',
      ),
      Pet(
        breed: '科拉特貓',
        imagePath: 'assets/images/korat.jpg',
        category: 'cat',
        coatLength: 'short',
        origin: '泰國',
        description:
            '科拉特貓（Korat）以其藍灰色毛髮和綠色眼睛聞名，性格溫和且敏感。它們原產於泰國，被認為是幸運的象徵，對主人忠誠但對陌生人謹慎。科拉特貓毛髮護理需求低，適合安靜的家庭。',
      ),

      // 大型犬
      Pet(
        breed: '拉布拉多尋回犬',
        imagePath: 'assets/images/labrador.jpg',
        category: 'dog',
        size: 'large',
        origin: '加拿大',
        description:
            '拉布拉多尋回犬（英語：Labrador Retriever），簡稱拉布拉多犬，是一種起源於加拿大紐芬蘭與拉布拉多省的大型尋回犬。它們以智商高、個性溫和、活潑且幾乎沒有攻擊性而聞名，非常適合被選作寵物犬、導盲犬或其他工作犬，與金毛尋回犬、哈士奇並列三大低攻擊性犬種。根據1991年至2022年間的犬隻登記數，拉布拉多犬是美國最受歡迎的犬種之一。',
      ),
      Pet(
        breed: '阿拉斯加雪橇犬',
        imagePath: 'assets/images/alaskan.jpg',
        category: 'dog',
        size: 'large',
        origin: '美國',
        description:
            '阿拉斯加雪橇犬又稱阿拉斯加馬拉穆，是一種最古老的雪橇犬和寵物犬，以其巨大無比的體型和超強耐力聞名。它們臉型圓潤可愛、四肢健碩粗壯，擁有濃密的毛髮，適合寒冷環境。阿拉斯加雪橇犬被培育用於拉雪橇，展現出色的耐力和力量，但需要大量運動和空間。',
      ),
      Pet(
        breed: '德國牧羊犬',
        imagePath: 'assets/images/german_shepherd.jpg',
        category: 'dog',
        size: 'large',
        origin: '德國',
        description:
            '德國牧羊犬（德語：Deutscher Schäferhund；英語：German Shepherd），是一種大型犬，1977年正式命名為德國牧羊犬。它們敏捷且適合在工作環境活動，常被用於警察、護衛、搜救和軍事任務，也常作為導盲犬。德國牧羊犬智商高、忠誠且易於訓練，但需要規律的運動和精神刺激。',
      ),
      Pet(
        breed: '黃金獵犬',
        imagePath: 'assets/images/golden_retriever.jpg',
        category: 'dog',
        size: 'large',
        origin: '英國',
        description:
            '黃金獵犬，又譯金毛獵犬、黃金尋回犬，是一種起源於英國的大型獵犬。它們因性格穩重、咬合力小且溫柔而得名，適合用於幫助獵人尋回獵物。黃金獵犬以其金黃色毛髮和友善性格聞名，喜歡與人互動，適合家庭飼養，也喜歡玩耍和游泳，是理想的伴侶犬。',
      ),

      // 中型犬
      Pet(
        breed: '邊境牧羊犬',
        imagePath: 'assets/images/border_collie.jpg',
        category: 'dog',
        size: 'medium',
        origin: '英國',
        description:
            '邊境牧羊犬（英語：Border Collie）是一種起源於英國英格蘭與蘇格蘭邊境的中型犬，被認為是智商最高的犬種之一。它們敏捷、專注且精力充沛，常被用於牧羊工作。邊境牧羊犬需要大量的運動和智力挑戰，適合活躍的主人，但不適合久坐的生活方式。',
      ),
      Pet(
        breed: '澳洲牧羊犬',
        imagePath: 'assets/images/australian_shepherd.jpg',
        category: 'dog',
        size: 'medium',
        origin: '美國',
        description:
            '澳洲牧羊犬（英語：Australian Shepherd）是一種起源於美國的中型犬，儘管名字中有「澳洲」，實際上是在美國發展的品種。它們以多彩的毛色和牧羊能力聞名，性格活潑且忠誠，喜歡參與各種活動，適合有農場或戶外空間的家庭飼養。',
      ),
      Pet(
        breed: '英國可卡犬',
        imagePath: 'assets/images/english_cocker_spaniel.jpg',
        category: 'dog',
        size: 'medium',
        origin: '英國',
        description:
            '英國可卡犬（英語：English Cocker Spaniel）是一種起源於英國的中型犬，以其優雅的外觀和長耳朵聞名。它們性格溫和、情感豐富，喜歡與人互動，最初被培育為獵犬。英國可卡犬適合家庭飼養，但需要定期梳理毛髮以保持整潔。',
      ),
      Pet(
        breed: '比格犬',
        imagePath: 'assets/images/beagle.jpg',
        category: 'dog',
        size: 'medium',
        origin: '英國',
        description:
            '比格犬（英語：Beagle）是一種起源於英國的中型犬，以其出色的嗅覺和獵兔能力聞名。它們性格好奇、友善且活潑，喜歡探索周圍環境。比格犬適合家庭飼養，但可能因為好奇心強而需要監督，且吠叫聲較響亮。',
      ),

      // 小型犬
      Pet(
        breed: '比熊犬',
        imagePath: 'assets/images/bichon_frise.jpg',
        category: 'dog',
        size: 'small',
        origin: '法國',
        description:
            '比熊犬（英語：Bichon Frise）是一種起源於法國的小型犬，以其蓬鬆的白色毛髮和圓潤外觀聞名。它們性格溫柔、活潑且友善，喜歡討好主人，適合家庭飼養。比熊犬需要定期梳理毛髮以防止打結，對陌生人也很友善。',
      ),
      Pet(
        breed: '馬爾濟斯',
        imagePath: 'assets/images/maltese.jpg',
        category: 'dog',
        size: 'small',
        origin: '馬爾他',
        description:
            '馬爾濟斯（英語：Maltese）是一種起源於地中海地區馬爾他的小型犬，以其長而絲滑的白色毛髮聞名。它們性格溫柔、優雅且活潑，喜歡陪伴主人，是理想的室內寵物。馬爾濟斯需要經常梳理毛髮以保持整潔。',
      ),
      Pet(
        breed: '迷你雪納瑞',
        imagePath: 'assets/images/miniature_schnauzer.jpg',
        category: 'dog',
        size: 'small',
        origin: '德國',
        description:
            '迷你雪納瑞（英語：Miniature Schnauzer）是一種起源於德國的小型犬，以其獨特的鬍鬚和眉毛聞名。它們性格聰明、警惕且活潑，對主人忠誠，易於訓練。迷你雪納瑞適合家庭飼養，但需要適量運動和毛髮護理。',
      ),
      Pet(
        breed: '西高地白梗',
        imagePath: 'assets/images/west_highland_white_terrier.jpg',
        category: 'dog',
        size: 'small',
        origin: '英國',
        description:
            '西高地白梗（英語：West Highland White Terrier）是一種起源於英國蘇格蘭的小型犬，以其白色毛髮和活潑性格聞名。它們最初被培育用於獵捕小型動物，性格勇敢、自信且獨立。西高地白梗適合家庭飼養，但可能有點固執。',
      ),
    ];
  }
}
