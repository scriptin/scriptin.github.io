#import "config.typ": bg_color, fg_color

#let history_record(content, title: "", place: "Self-employed", from: "", to: "", type: "") = [
  #let inset_left = 0.2cm
  #let inset_y = 0.1cm
  #block(
    stroke: (left: 2pt + bg_color, rest: none),
    inset: (left: inset_left, right: 0cm, y: inset_y),
    above: 0.6cm,
    below: 0cm,
  )[
    === #title
  ]
  #block(inset: (
    left: inset_left, right: 0cm, y: inset_y),
  )[
    *#place*

    #from #sym.arrow.r #to #sym.dot.op #type

    #content
  ]
]

#let skill_level_bar(val, max: 6) = stack(
  dir: ltr,
  spacing: 0.2em,
  ..range(1, max+1).map(n =>
    rect(
      width: 0.7em,
      height: 0.7em,
      radius: 50%,
      inset: 0pt,
      stroke: 1pt + fg_color,
      fill: if (n <= val) { fg_color } else { white }
    )
  )
)
