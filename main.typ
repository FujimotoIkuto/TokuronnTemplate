#import "tokuronn_template.typ": *

#show: thesis.with(
  title: "テンプレート",
  author: "高専　太郎",
  kousen: "神戸市立工業高等専門学校",
  senkouka: "専攻科",
  senkou: "機械システム工学専攻",
  id: "学籍番号",
  sidoukyoukan: "指導　教員",
  abstract_ja: [
    高専専攻科における特別研究論文の執筆を効率的かつ正確に行うためにテンプレートを作成した．
  ],
  abstract_en: [
    We created a template to facilitate efficient and accurate writing of papers.
  ]
)

= はじめに

このテンプレートは @utkhanlab を参考に作成した．


= Typstの使い方

Typstの使い方は調べれば出てくる @typst @1Step621 ．

== コンパイル

以下のコマンドでコンパイルできる．
#showybox()[
  ```bash
  typst compile <file_name>.typ
  ```
]


== 式

式の書き方は ```typst $ 1 + 1 = 2 $ <eq1> ``` と書く．
$ 1 + 1 = 2 $ <eq1>
$ e^(i pi) + 1 = 0 $
```typst <eq1>``` とつけることで ```typst @eq1``` @eq1 で簡単に参照できる．
文中の式はスペースを空けずに ```typst $pi$``` $pi$ このように書くことができる．

== 図

図の書き方は以下の通り．
#showybox(title: "図の書き方", frame: (title-color: olive))[
  ```typst
  #figure(
    image("Fig/image.png", width: 80%),
    caption: [図名],
    supplement: [図],
    kind: "image"
  )<fig1>
  ```
]
式と同じく， `@fig1` @fig1 で参照できる．

#figure(
  image("Fig/image.png", width: 80%),
  caption: [図名],
  supplement: [図],
  kind: "image"
)<fig1>

== 表

表の書き方は以下の通り．
#showybox(title: "表の書き方", frame: (title-color: olive))[
  ```typst
  #figure(
    table(
      columns: 2,
      stroke: none,
      table.hline(),
      table.header([aaa], table.vline(), [bbb]),
      table.hline(),
      [cc], [dddd],
      [ee], [ffff],
      table.hline(),
      ),
      caption: [表名],
      supplement: [表],
      kind: "table"
  ) <tbl_1>
  ```
]
表の書き方はたくさんある．

#figure(
  table(
    columns: 2,
    stroke: none,
    table.hline(),
    table.header([aaa], table.vline(), [bbb]),
    table.hline(),
    [cc], [dddd],
    [ee], [ffff],
    table.hline(),
    ),
    caption: [表名],
    supplement: [表],
    kind: "table"
) <tbl_1>

== 文献の引用

引用したいときは `@論文1` と書く @論文1 ．
引用したいときは `@article1` `@book1` と書く @article1 @book1 ．
引用する文献の情報は `bunnkenn.bib` のように書く．

#showybox(title: "bibファイルの例", frame: (title-color: olive))[
  ```bib
  @article{論文1,
    author = {著者},
    journal = {ジャーナル},
    number = {1},
    title = {タイトル},
    volume = {1},
    year = {2024}
  }

  @article{article1,
    author = {author},
    journal = {journal},
    number = {1},
    title = {title},
    volume = {1},
    year = {2024}
  }

  @book{book1,
    author = {author},
    editor = {editor},
    publisher = {publisher},
    title = {title},
    year = {2024}
  }
  ```
]

= まとめ

まとめを書く．

= 謝辞

謝辞を書く．

// = 参考文献
#show bibliography: set text(12pt)
  #bibliography("bunnkenn.bib", title: "参考文献", style: "ieee")

= 付録

付録を書く．