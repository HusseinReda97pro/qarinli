<<<<<<< HEAD
class HtmlEditor {
  static String merageTwoTDs(String html) {
    return html
        .replaceFirst(
          '</td>',
          '',
        )
        .replaceFirst('<td class="rh-tabletext-block-right">', '');
  }
}
=======
class HtmlEditor {
  static String merageTwoTDs(String html) {
    return html
        .replaceFirst(
          '</td>',
          '',
        )
        .replaceFirst('<td class="rh-tabletext-block-right">', '');
  }
}
>>>>>>> 1ed456bb93dbde9d2e4d18e7f5511a30428e382b
