#let text_size = 10pt
#let fg_color = rgb("#27353b")
#let bg_color = rgb("#b1bfc4")

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

#line(length: 100%, stroke: bg_color)

#grid(
  columns: (5fr, 3fr),
  gutter: 1cm,
  [
    == Professional summary

    #par(justify: true)[
      Software Engineer with over 12 years of experience specializing in full-stack
      and frontend web development. Expertise in TypeScript/JavaScript and React,
      complemented by a strong background in creating robust web applications,
      libraries, and tools. Dedicated to producing clean, well-architected,
      and thoroughly tested code, ensuring high-quality software solutions.
      Proven ability to develop and maintain projects of varying sizes, delivering
      innovative and efficient solutions that meet and exceed client expectations.
    ]



    == Work history



    === Software Engineer

    *Self-employed*

    May 2023 #sym.arrow.r Present #sym.dot.op Part-time / freelance

    Responsibilities: Developing a personal
    language learning application project.



    === Senior Software Engineer

    *Picsart, Inc.*

    Oct 2021 #sym.arrow.r May 2023 #sym.dot.op Full-time

    Responsibilities: Developing internal tools and libraries for image processing.
    Developing new functionality of the web application. Participating in engineering decision-making
    by creating and reviewing technical proposals. Mentoring junior developers.

    Achievements:
    - Developed and maintained an internal tool for converting vector graphics into an internal format,
      used by a company's content team of several people, accelerating and simplifying their work as a result.
    - Created a library for pre-processing vector images, which was subsequently integrated into several
      internal tools.
    - Added several new features to the main web application.
    - Proposed an improvement for unit testing policy and process, which was partially implemented.



    === Software Engineer

    *Swift Invention, Inc.*

    Jul 2015 #sym.arrow.r Sep 2021 #sym.dot.op Full-time / contactor

    Responsibilities: Maintaining, developing and testing Java web applications (Spring),
    Scala ETL tools for dealing with tabular data and social network graphs.
    Designing, developing, and maintaining B2B apps (TypeScript, React, GraphQL).

    Achievements:
    - Fully rewritten (in a team of 4 engineers) a large social network graph web application (Java, Spring),
      created and maintained an accompanying Extract-Transform-Load (ETL) tool (Scala).
    - As a leading frontend engineer, designed, developed, and maintained (team of 3-5 engineers)
      a B2B web application (React/Express, GraphQL API). Integrated 3rd party services for geographic/address
      data and payments.
    - Developed and launched several smaller web applications and sites for corporate clients.



    === Software Engineer

    *Teligent LLC*

    May 2014 #sym.arrow.r Apr 2015 #sym.dot.op Full-time

    Responsibilities: Maintaining, developing and testing several Java web applications for corporate clients,
    written with internally-developed tech based on Spring Framework and Hibernate ORM.

    Achievements:
    - Extended functionality of account management portals with tens of thousands of users
      for corporate clients (telecommunication companies).
    - Integrated critical 3rd party services: billing, SMS notifications.



    === Software Engineer

    *Self-employed*

    May 2013 #sym.arrow.r Feb 2014 #sym.dot.op Part-time / freelance

    Achievements:
    - In a personal project, created a largest dataset of character frequencies for Japanese language,
      as well as several tools and datasets for studying Japanese language.



    === Software Engineer

    *Bank Pervomaisky (PJSC)*

    Feb 2011 #sym.arrow.r Apr 2013 #sym.dot.op Full-time

    Responsibilities: Web-application development and maintenance,
    primarily corporate sites and legacy CRM-systems. Integration with internal SQL Server database.
    Developing and maintaining websites for partner companies.

    Achievements:
    - Developed, tested and deployed main website (tens of thousands of users monthly) on Drupal 6..
    - Designed, developed, deployed, and maintained a corporate CRM system with several hundreds of users.
    - Implemented multiple complex forms integrated with the internal CRM,
      including credit score calculations, business rules validations, and notifications.



    == Education



    === Information security specialist

    *#link("https://kubstu.ru/")[Kuban State Technological University] (KubSTU), Krasnodar, Russia*

    2005 #sym.arrow.r 2010 #sym.dot.op Higher education

    Specialty: "Organization and technologies of information security"

    Achievements:
    - Diploma with distinction
    - Defended thesis: "Usage of polygraph systems in public education institutions"



    === High school

    *School of General education \#42, Krasnodar, Russia*

    1995 #sym.arrow.r 2005 #sym.dot.op Primary/secondary education

    Achievements:
    - Certificate of completion with distinction
    - Silver medal
    - Several non-podium places (4th and below) on city-wide school olympiads on Math and Physics
  ],
  [
    == Contacts

    *Belgrade, Serbia* \
    *web*: #link("scriptin.github.io") \
    *email*: #link("scrptn@gmail.com") \

    == Technical skills

    *Primary:*
    - TypeScript, JavaScript
    - HTML, DOM, Browser APIs
    - CSS, Tailwind, CSS modules, adaptive layouts etc.
    - Frontend: React, Astro
    - Node.js
    - APIs: REST, GraphQL, RPC
    - SQL: MySQL, Postgres, SQLite
    - CI/CD: GitHub Actions, GitLab CI
    - Docker
    - Build tools: Webpack, Vite
    - Unit testing: Jest, Vitest, etc.

    *Secondary:*
    - Python
    - Bash
    - Kotlin, Gradle
    - Graphic/web design
    - Security auditing

    *Previous experience:*
    - Bootstrap, jQuery, Angular.js
    - Java, Scala, Spring Framework, Hibernate, jOOQ
    - PHP, Wordpress, Drupal, Joomla, Kohana, Yii
    - MongoDB, Redis

    == Soft skills

    - Code reviews with extensive feedback
    - Mentoring of junior developers
    - Technical writing and proposals
    - Presentations, live demos
    - IT consulting
    - Creative writing

    #let cell_gutter = 0.1em
    #let cell_size = 0.7em
    #let skill_level(val, max) = block(
      width: max * cell_size + (max - 1) * cell_gutter,
      grid(
        columns: range(0, max).map(it => 1fr),
        stroke: none,
        gutter: cell_gutter,
        inset: 0pt,
        ..range(1, max+1).map(n =>
          grid.cell(
            inset: 0pt,
            align: center + bottom,
            rect(
              width: cell_size,
              height: cell_size,
              radius: 50%,
              inset: 0pt,
              stroke: none,
              fill: if (n <= val) { fg_color } else { bg_color }
            )
          )
        )
      )
    )

    == Languages

    #table(
      columns: 3,
      align: (left, right, left),
      stroke: none,
      column-gutter: 0.5em,
      row-gutter: 0.8em,
      inset: 0pt,
      [*Russian*], [Native], [#skill_level(6, 6)],
      [*English*], [C1], [#skill_level(5, 6)],
      [*Spanish*], [B1], [#skill_level(3, 6)],
      [*German*], [A1], [#skill_level(1, 6)],
      [*Japanese*], [A1], [#skill_level(1, 6)],
    )
  ],
)
