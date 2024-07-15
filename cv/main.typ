#import "config.typ": text_size, bg_color, fg_color

#set text(
  font: "New Computer Modern",
  size: text_size
)

#set page(
  paper: "a4",
  margin: (x: 1.8cm, y: 1.5cm),
  header: align(right)[
    #text(fill: bg_color)[Dmitry Shpika]
  ],
  numbering: "1",
)

#set par(
  justify: false,
  leading: 0.52em,
)

#show heading.where(
  level: 1
): it => [
  #set align(left)
  #set text(text_size * 3, weight: "regular", font: "Oswald", fill: fg_color, tracking: -1pt)
  #block(upper(it.body))
]

#show heading.where(
  level: 2
): it => [
  #set align(left)
  #set text(text_size * 2, weight: "regular", font: "Oswald")
  #block(it.body)
]

#show heading.where(
  level: 3
): it => [
  #set align(left)
  #set text(text_size * 1.5, weight: "bold")
  #block(it.body)
]

= Dmitry Shpika

#line(
  length: 100%,
  stroke: 2pt + gradient.linear(bg_color, white)
)

#grid(
  columns: (5fr, 3fr),
  gutter: 1cm,
  [
    #include "summary.typ"
    #include "work.typ"
    #include "education.typ"
  ],
  [#include "aside.typ"],
)
