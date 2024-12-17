#import "@preview/codelst:2.0.1": sourcecode
#import "@preview/showybox:2.0.1":*

#show "，": ", "
#show "．": "."
#show "、": ", "
#show "。": "."

// Definition of abstruct page
#let abstract_page(abstract_ja, abstract_en) = {
  if abstract_ja != [] {
    show <_ja_abstract_>: {
      align(center)[
        #text(size: 20pt, "概要")
      ]
    }
    [= 概要 <_ja_abstract_>]

    v(30pt)
    set text(size: 12pt)
    h(1em)
    abstract_ja
    pagebreak()

    show <_en_abstract_>: {
      align(center)[
        #text(size: 18pt, "英語要約")
      ]
    }
    [= Abstract <_en_abstract_>]

    set text(size: 12pt)
    h(1em)
    abstract_en
  }
}

// Definition of content to string
#let to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(to-string).join("")
  } else if content.has("body") {
    to-string(content.body)
  } else if content == [ ] {
    " "
  }
}

// Definition of chapter outline
#let toc() = {
  align(center)[
    #text(size: 20pt, weight: "bold")[
      #v(30pt)
      ─目　次─
      #v(30pt)
    ]
  ]

  set text(size: 12pt)
  set par(leading: 1.24em, first-line-indent: 0pt)
  locate(loc => {
    let elements = query(heading.where(outlined: true), loc)
    for el in elements {
      if to-string(el.body) == "概要" or to-string(el.body) == "Abstract"{}
      else {
        let before_toc = query(heading.where(outlined: true).before(loc), loc).find((one) => {one.body == el.body}) != none
        let page_num = if before_toc {
          numbering("i", counter(page).at(el.location()).first())
        } else {
          counter(page).at(el.location()).first()
        }

        link(el.location())[#{
          // acknoledgement has no numbering
          let chapt_num = if el.numbering != none {
            numbering(el.numbering, ..counter(heading).at(el.location()))
          } else {none}

          if el.level == 1 {
            set text(weight: "black")
            if to-string(el.body) == "謝辞" {}
            else if to-string(el.body) == "付録" {}
            else if chapt_num == none {} else {
              chapt_num
              "  "
            }
            let rebody = to-string(el.body)
            rebody
          } else if el.level == 2 {
            h(2em)
            chapt_num
            " "
            let rebody = to-string(el.body)
            rebody
          }
        }]
        if el.level < 3{
          box(width: 1fr, h(0.5em) + box(width: 1fr, repeat[.]) + h(0.5em))
          [#page_num]
          linebreak()
        }
      }
    }
  })
}

// Setting empty par
#let empty_par() = {
  v(-1em)
  box()
}

// Construction of paper
#let thesis(
  // The thesis title.
  title: "ここにtitleが入る",

  // The paper`s author.
  author: "ここに著者が入る",

  // The author's information
  kousen: "",
  senkouka: "",
  senkou: "",
  id: "",
  sidoukyoukan: "",
  date: (datetime.today().year()-2018, datetime.today().month(), datetime.today().day()),

  paper-type: "特別研究Ⅱ論文",

  // Abstruct
  abstract_ja: [],
  abstract_en: [],

  // The paper size to use.
  paper-size: "a4",

  // The path to a bibliography file if you want to cite some external
  // works.
  bibliography-file: none,

  // The paper's content.
  body
) = {
  // citation number
  show ref: it => {
    if it.element != none and it.element.func() == heading {
      let el = it.element
      let loc = el.location()
      let num = numbering(el.numbering, ..counter(heading).at(loc))
      if el.level == 1 {
        str(num)
        "章"
      } else if el.level == 2 {
        str(num)
        "節"
      } else if el.level == 3 {
        str(num)
        "項"
      }
    } else {
      it
    }
  }

  // counting caption number
  show figure: it => {
    set align(center)
    if it.kind == "image" {
      set text(size: 12pt)
      it.body
      it.supplement
      " " + it.counter.display(it.numbering)
      "    " + it.caption.body
      locate(loc => {
        let chapt = counter(heading).at(loc).at(0)
        let c = counter("image-chapter" + str(chapt))
        c.step()
      })
    } else if it.kind == "table" {
      set text(size: 12pt)
      it.supplement
      " " + it.counter.display(it.numbering)
      "    " + it.caption.body
      set text(size: 10.5pt)
      it.body
      locate(loc => {
        let chapt = counter(heading).at(loc).at(0)
        let c = counter("table-chapter" + str(chapt))
        c.step()
      })
    } else {
      it
    }
  }

  // Set the document's metadata.
  set document(title: title, author: author)

  // Set the body font. TeX Gyre Pagella is a free alternative
  // to Palatino.
  set text(font: (
    "Nimbus Roman",
    // "Hiragino Mincho ProN",
    // "MS Mincho",
    // "Noto Serif CJK JP",
    "IPAMincho",
    ), size: 12pt)

  // Configure the page properties.
  set page(
    paper: paper-size,
    margin: (bottom: 1.75cm, top: 2.25cm),
  )

  // The first page.
  align(center)[
    #v(150pt)
    #text(
      size: 16pt,
    )[
      #paper-type
    ]

    #v(20pt)
    #text(
      size: 22pt,
    )[
      #title
    ]
    #v(200pt)
    #text(
      size: 16pt,
    )[
      令和 #date.at(0) 年 #date.at(1) 月 #date.at(2) 日\
      #kousen #senkouka\
      #senkou\
      #author
    ]
    #pagebreak()
  ]
  align(center)[
    #v(150pt)
    #text(
      size: 16pt,
    )[
      #paper-type
    ]

    #v(20pt)
    #text(
      size: 22pt,
    )[
      #title
    ]
    #v(200pt)
    #text(
      size: 16pt,
    )[
      令和 #date.at(0) 年 #date.at(1) 月 #date.at(2) 日\
      #kousen #senkouka\
      #senkou\
      #author
    ]
    #pagebreak()
  ]

  counter(page).update(1)
  // Show abstruct
  abstract_page(abstract_ja, abstract_en)
  pagebreak()

  // Configure paragraph properties.
  set par(leading: 0.78em, first-line-indent: 12pt, justify: true)
  show par: set block(spacing: 0.78em)

   // Configure chapter headings.
  set heading(numbering: (..nums) => {
    nums.pos().map(str).join(".") + " "
  })
  show heading.where(level: 1): it => {
    pagebreak()
    counter(math.equation).update(0)
    set text(weight: "bold", size: 20pt)
    set block(spacing: 1.5em)
    let pre_chapt = if to-string(it.body) == "謝辞" {
          text()[
            #v(50pt)
          ]
        }else if to-string(it.body) == "付録" {
          text()[
            #v(50pt)
          ]
        } else if to-string(it.body) == "参考文献" {
          text()[
            #v(50pt)
          ]
        } else if it.numbering != none {
          text()[
            #v(50pt)
            第
            #numbering(it.numbering, ..counter(heading).at(it.location()))
            章
          ]
        } else {none}
    text()[
      #pre_chapt
      #h(20pt)
      #it.body \
      #v(20pt)
    ]
  }
  show heading.where(level: 2): it => {
    set text(weight: "bold", size: 16pt)
    set block(above: 1.5em, below: 1.5em)
    it
  }

  show heading: it => {
    set text(weight: "bold", size: 14pt)
    set block(above: 1.5em, below: 1.5em)
    it
  } + empty_par()


  // Start with a chapter outline.
  toc()

  set page(
    footer: [
      #align(center)[#counter(page).display("1")]
    ]
  )

  counter(page).update(1)

  set math.equation(supplement: [式], numbering: "(1)")

  body
}