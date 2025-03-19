#import "@preview/nth:1.0.1": *

// Custom functions
#let my-date(date) = nth(date.day()) + date.display(" [month repr:long] [year]")

#let active(reference) = {
  cite(reference, form: "prose", style: "apa")
}

#let passive(reference) = {
  cite(reference, form: "normal", style: "apa")
}


// Main template
#let conf(
  title: "Your title",
  program: "Name of your program",
  name: "Your name",
  student_number: "123456",
  supervisor: "Name of your supervisor",
  second_assessor: "Name of your second assessor",
  date: my-date(datetime.today()),
  abstract: lorem(100),
  universtiy: "Erasmus University Rotterdam",
  factulty: "Erasmus School of Economics",
  logo: "figures/eur.png",
  disclaimer: "The content of this thesis is the sole responsibility of the author and does not reflect the view of the supervisor, second assessor, Erasmus School of Economics or Erasmus University.",
  doc
) = {
  //// General page settings
  
  // Font
  set text(font: "New Computer Modern")

  // Margin
  set page(
    margin: 2.5cm,
  )

  // Table
  let frame(stroke) = (x, y) => (
    top: if y < 2 { stroke } else { 0pt },
    bottom: stroke,
  )

  set table(
    stroke: frame(rgb(black)),
  )

  // Equation numbering
  set math.equation(numbering: "(1)")

  //// Document structure

  // Title page
  set align(center)
  block[
    #smallcaps[#universtiy]

    #smallcaps[#factulty]

    #program
  ]
  v(0.8fr)

  // Title and author
  line(length: 100%)

  block[
    #set text(18pt)
    #title

    #set text(14pt)

    #name (#student_number)
  ]

  line(length: 100%)
  v(0.8fr)

  // Universtiy logo
  box(image(logo, height: 15.0%))
  v(0.8fr)

  // Information table
  table(
    stroke: (x, y) => if y == 2 {
      (bottom: 0.7pt + black)
    } else if y == 0 {
      (top: 0.7pt + black)
    },
    align: (left, left,),
    columns: 2,
    [Supervisor:], [#supervisor],
    [Second assessor:], [#second_assessor],
    [Date final version:], [#date]
  )


  set par()
  v(1fr) // Fill to the bottom
  disclaimer

  // Abstract
  if abstract != "" {
    pagebreak()
    block[
    #set heading(outlined: false)
    = Abstract
    #set par(
      justify: true,
    )
    #set align(left)
    #abstract
    ]
  }

  set align(left)

  // Table of contents
  pagebreak()
  set page(numbering: "1")
  counter(page).update(1)

  show outline.entry.where(
    level: 1
  ): it => {
    v(12pt, weak: true)
    strong(it)
  }

  outline(indent: auto)

  // Main document appears now
  doc
}