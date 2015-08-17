{% if grains['os'] == 'Debian' %}
locales-all:
  pkg.installed
{% elif grains['os'] == 'Ubuntu' %}
{% set languages = ["aa", "af", "am", "an", "ar", "as", "ast", "az", "be",
	"bem", "ber", "bg", "bho", "bn", "bo", "br", "bs", "ca", "crh", "cs",
	"csb", "cv", "cy", "da", "de", "dv", "dz", "el", "en", "eo", "es",
	"et", "eu", "fa", "ff", "fi", "fil", "fo", "fr", "fur", "fy", "ga",
	"gd", "gl", "gu", "gv", "ha", "he", "hi", "hne", "hr", "hsb", "ht",
	"hu", "hy", "ia", "id", "ig", "is", "it", "ja", "ka", "kk", "kl",
	"km", "kn", "ko", "ks", "ku", "kw", "ky", "lb", "lg", "li", "lo",
	"lt", "lv", "mai", "mg", "mhr", "mi", "mk", "ml", "mn", "mr", "ms",
	"mt", "my", "nan", "nb", "nds", "ne", "nl", "nn", "nso", "oc", "om",
	"or", "os", "pa", "pap", "pl", "ps", "pt", "ro", "ru", "rw", "sa", "sc",
	"sd", "se", "shs", "si", "sk", "sl", "so", "sq", "sr", "ss", "st", "sv",
	"sw", "ta", "te", "tg", "th", "ti", "tk", "tl", "tr", "ts", "tt", "ug",
	"uk", "ur", "uz", "ve", "vi", "wa", "wae", "wo", "xh", "yi", "yo",
	"zh-hans", "zh-hant", "zu"] %}
{% for language in languages %}
language-pack-{{ language }}:
  pkg.installed
{% endfor %}
{% endif %}