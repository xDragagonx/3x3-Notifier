Global("locales", {})
--create tables of each language
locales["eng_eu"]={}
locales["rus"]={}
locales["fr"]={}
locales["ger"]={}
locales["tr"]={}

locales["eng_eu"][ "3x3Combat" ] = "3x3 Combat"
locales["fr"][ "3x3Combat" ] = "3x3 Combat"
locales["rus"][ "3x3Combat" ] = "3x3 Боевой"
locales["ger"][ "3x3Combat" ] = "3x3 Combat"
locales["tr"][ "3x3Combat" ] = "3x3 Combat"

locales["eng_eu"][ "signed" ] = "Someone signed"
locales["fr"][ "signed" ] = "Quelqu'un a sign/233"
locales["rus"][ "signed" ] = "Кто-то подписал"
locales["ger"][ "signed" ] = "Jemand hat unterschrieben"
locales["tr"][ "signed" ] = "Birisi imzalad?"


locales = locales[common.GetLocalization()] -- trims all other languages except the one that common.getlocal got.