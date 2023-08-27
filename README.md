# TCCC-Pixlr
TCCC Skills Cards, Ukrainian Translations in Pixlr File Format

## Downloading Ukrainian TCCC Skills Cards

You can find the end-user TCCC Skills cards [here on Google Drive](https://drive.google.com/drive/folders/173vr97nv5Xb3C8Z_sVUHjFA8SXX3cTE6), or in this repository in the [TCCC Field Medical Skills Cards](TCCC%20Field%20Medical%20Skills%20Cards%20(Бойові%20медичні%20навички)%20ENG%20-%20UKR) folder

## Explanation of project

A project to translate [Tactical Combat Casualty Care](https://en.wikipedia.org/wiki/Tactical_Combat_Casualty_Care) [skills reference & training materials](https://deployedmedicine.com/market/299/category/290) from English to Ukrainian.<br/>
Repository of [Pixlr](https://pixlr.com/) graphics files to track updates & translation corrections.

All skills cards come from, and are the property of, [Deployed Medicine](https://deployedmedicine.com)<br/>
`Усі картки навичок надходять і є власністю Deployed Medicine`

I am NOT from Deployed Medicine.<br/>
`Я НЕ з "Deployed Medicine".`

This is not a replacement for proper field medicine training. I am addressing a need for open source training material in the Ukrainian language.<br/>
`Це не є заміною для належної медичної підготовки. Я розглядаю потребу у відкритих навчальних матеріалах українською мовою.`

I am NOT a medical expert, however, I am trained as an [EMR](https://en.wikipedia.org/wiki/Emergency_medical_responder) with a full understanding of first responder techniques, plus dispatch and organization of resources.<br/>
`Я НЕ медичний експерт, але пройшов підготовку спеціаліста швидкої медичної допомоги з повним розумінням методів надання першої допомоги, а також диспетчеризації та організації ресурсів.`

## Skills Cards, Formats, and Sizes

NOTE: THIS TABLE IS INCOMPLETE! Currently a proof-of-concept, all existing repository cards need to be added to this table as part of a future commit!

| Num | Card Title | Letter | A0 Poster | 1.5m x 1m |
| --- | --- | --- | --- | --- |
| 1 | One-Handed Windlass Tourniquet CUF | [PDF](TCCC%20Field%20Medical%20Skills%20Cards%20(Бойові%20медичні%20навички)%20ENG%20-%20UKR/1.%20One-Handed%20Windlass%20Tourniquet%20CUF%20(джгут%20-%20брашпиль)%20ENG%20-%20UKR/1%20ENG%20One-Handed%20Windlass%20Tourniquet%20PDF.pdf) [PNG](TCCC%20Field%20Medical%20Skills%20Cards%20(Бойові%20медичні%20навички)%20ENG%20-%20UKR/1.%20One-Handed%20Windlass%20Tourniquet%20CUF%20(джгут%20-%20брашпиль)%20ENG%20-%20UKR/1%20ENG%20One-Handed%20Windlass%20Tourniquet%20PNG.png) | | |
| 1 | джгут - брашпиль | [PDF](TCCC%20Field%20Medical%20Skills%20Cards%20(Бойові%20медичні%20навички)%20ENG%20-%20UKR/1.%20One-Handed%20Windlass%20Tourniquet%20CUF%20(джгут%20-%20брашпиль)%20ENG%20-%20UKR/1%20UKR%20One-Handed%20Windlass%20Tourniquet%20PDF.pdf) [PNG](TCCC%20Field%20Medical%20Skills%20Cards%20(Бойові%20медичні%20навички)%20ENG%20-%20UKR/1.%20One-Handed%20Windlass%20Tourniquet%20CUF%20(джгут%20-%20брашпиль)%20ENG%20-%20UKR/1%20UKR%20One-Handed%20Windlass%20Tourniquet%20PNG.png) | [PDF](A0%20Print%20Poster%20PDF%20UKR%20Translations/1.%20A0%20PDF.pdf) | |


## Contributors

For accountability, I am Jason Farrell & may be found on Twitter as [@farrellgraymond](https://twitter.com/farrellgraymond) - message me any concerns.

Thank you to #MedicsTogether ([@medicstogether](https://twitter.com/medicstogether)), Believe In Ukraine ([@Believe_In_Ukr](https://twitter.com/Believe_In_Ukr)), Aryo ([@SomeGumul](https://twitter.com/SomeGumul)), Kate From Kharkiv ([@BohuslavskaKate](https://twitter.com/BohuslavskaKate)) plus others for the support & guidance with proper translations.

## How To Contribute

First, thank you very much for your interest in helping!

In order to contribute, you will want to do the following:

1. Download the Pixlr source file of the card you want to update - the source files are found in the [Pixlr Source Files](Pixlr%20Source%20Files) folder
1. Either create or log into a [Pixlr account](https://pixlr.com/myaccount/), and upload the Pixlr file you want to update to the [Pixlr X app](https://pixlr.com/x/)
1. Make the changes you want to the card
1. Save the card in 3 formats:
   1. PXZ format, so your source changes are saved (please save non-destructive)
   1. PNG format
   1. PDF format
1. Submit a pull request to this repository which includes those 3 files, with the PXZ going in the [Pixlr Source Files](Pixlr%20Source%20Files) folder and the PNG and PDF going in the appropriate [TCCC Field Medical Skills Cards](TCCC%20Field%20Medical%20Skills%20Cards%20(Бойові%20медичні%20навички)%20ENG%20-%20UKR) subfolder

And that's it!

Thank you again for helping to make this shared medical resource better!

## Developer notes

This section contains a series of tips and tricks for working with this repository.

### Extracting all translated text fields for all cards

GOOD TO KNOW: Pixlr files (.pxz) are just zipfiles, containing a manifest.json and a bunch of other binaries (fonts, background images, etc) - the manifest.json contains all of the text that has been translated on a given card.

To extract all of the manifests and text translations for all of the Pixlr filesin the repository, use this command (tested on Mac OS X 13.5): [./extract-manifests-and-translations.sh](extract-manifests-and-translations.sh)

This will delete and regenerate all translations in the [translation-manifests](translation-manifests) folder, to make it easier to see in a text manner which changes are in each release of the cards as well as send the text to translators for review and updates.

Output will look like this:

```
MacBook-Pro:TCCC-Pixlr straxus$ ./extract-manifests-and-translations.sh 
=== Testing for presence of the jq utility - if this check fails, script will exit. If you need to install jq, please go to https://jqlang.github.io/jq/download/
jq-1.6
=== Ensuring directory [translation-manifests] is deleted and recreated...
=== Phase 1: Extracting all Pixlr file manifests in [Pixlr Source Files]...
------ Extracting manifest from [1 Pixlr One-Handed Windlass Tourniquet.pxz]...
------ Extracting manifest from [10 Pixlr Two-Handed Ratchet Tourniquet (TFC).pxz]...
[...]
------ Extracting manifest from [8 Pt7 Pixlr Tactical Trauma Assessment Guide.pxz]...
------ Extracting manifest from [9 Pixlr Two-Handed Windlass Tourniquet (TFC).pxz]...
=== Phase 1 Manifest extraction complete! Extracted manifests can be found in [translation-manifests/*.manifest.json]
=== Phase 2: Extracting all translation strings from manifests...
------ Extracting strings from [translation-manifests/1 Pixlr One-Handed Windlass Tourniquet.pxz.manifest.json]...
------ Extracting strings from [translation-manifests/10 Pixlr Two-Handed Ratchet Tourniquet (TFC).pxz.manifest.json]...
[...]
------ Extracting strings from [translation-manifests/8 Pt7 Pixlr Tactical Trauma Assessment Guide.pxz.manifest.json]...
------ Extracting strings from [translation-manifests/9 Pixlr Two-Handed Windlass Tourniquet (TFC).pxz.manifest.json]...
=== Phase 2 Translation string extraction complete! Extracted translation strings can be found in [translation-manifests/*.manifest.json.translation-strings.json]
MacBook-Pro:TCCC-Pixlr straxus$
```
