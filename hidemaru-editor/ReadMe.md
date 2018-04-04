# ![秀丸エディタ](icon.gif) hidemaru-editor

Hidemaru Editor

## icon.gifについて(About icon.gif)
icon.gif IS NOT provided with MIT License.


---
<!-- 10 -->
A texteditor made in japan.

Features
* Japanese Support
* Tab
* Macro
* Syntax Highlight
* Code folding
* Vertical writing

etc...

## Known issue
* Silent uninstallation is not supported.

日本製の高機能テキストエディタです。

* 日本語サポート
* タブ
* 高度なマクロ機能
* シンタックスハイライト
* コードの折りたたみ
* 縦書き

など、様々な編集機能を有しています。

## Paramaters

[サイレントインストール](http://hide.maruo.co.jp/swreg/corporation_silent.html)にあるオプションを指定できます。

See [Silent Install Options](http://hide.maruo.co.jp/swreg/corporation_silent.html).

Example(例):

`cinst -y hidemaru-editor --params "'/key:XXXXXXX /name:yourname /exit'"`

* **output** Log file path
* **dir** Install directory
* **key** License key
* **name** License user name
* **exit** Exit all instances of Hidemaru Editor.

You can choose a version of Hidemaru Editor.(ビット数と言語を`/type:32`のように指定できます。)

* **type** install type
  * **32** (defualt) 32bit version
  * **32e** 32bit English version
  * **32f** 32bit float version
  * **64**  64bit version
  * **64e** 64bit English version
  * **64f** 64bit float version