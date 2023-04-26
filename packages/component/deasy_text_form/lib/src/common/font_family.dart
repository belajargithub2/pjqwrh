
enum FontFamilyTextForm { light, medium, bold }

String getFontFamilyTextForm(FontFamilyTextForm fontType) {
  switch (fontType) {
    case FontFamilyTextForm.light:
      return "KBFGDisplayLight";
    case FontFamilyTextForm.medium:
      return "KBFGDisplayMedium";
    case FontFamilyTextForm.bold:
      return "KBFGDisplayBold";
    default:
      return "KBFGDisplayLight";
  }
}
