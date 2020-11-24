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
