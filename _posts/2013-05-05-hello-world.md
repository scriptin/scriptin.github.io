---
layout: post
title: Hello world!
published: false
---
## Heading 2

### Heading 3

Inline code: `code`

Link: [google][]

> Quoted text on multiple lines.
> Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

Long paragraph with too many text in it.
We should break it down to multiple lines as well.

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

- List item 1
- Item 2
- Third item
- Last item

* List item 1
* Item 2
* Third item
* Last item

1. List item 1
2. Item 2
3. Third item
4. Last item


```ruby
File.readlines('file.txt').each do |line|
  puts line
end
```

<table class="table table-bordered table-striped table-hover">
    <thead>
        <tr>
            <th>header 1</th>
            <th>header 2</th>
            <th>header 3</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>cell 1-1</td>
            <td>cell 1-2</td>
            <td>cell 1-3</td>
        </tr>
        <tr>
            <td>cell 2-1</td>
            <td>cell 2-2</td>
            <td>cell 2-3</td>
        </tr>
        <tr>
            <td>cell 3-1</td>
            <td>cell 3-2</td>
            <td>cell 3-3</td>
        </tr>
    </tbody>
    <tfoot>
        <tr>
            <th>footer 1</th>
            <th>footer 2</th>
            <th>footer 2</th>
        </tr>
    </tfoot>
</table>

```ruby
class Person
  attr_reader :name, :age
  def initialize(name, age)
    @name, @age = name, age
  end
  def <=>(person) # Comparison operator for sorting
    age <=> person.age
  end
  def to_s
    "#{name} (#{age})"
  end
end

group = [
  Person.new("Bob", 33),
  Person.new("Chris", 16),
  Person.new("Ash", 23)
]

puts group.sort.reverse
```

```scala
class Point(
    // adding `val` here automatically creates
    // public accessor methods named `x` and `y`
    val x: Double, val y: Double,
    addToGrid: Boolean = false
) {
  // import functions/vars from companion object
  import Point._

  if (addToGrid)
    grid.add(this)

  def this() {
    this(0.0, 0.0)
  }

  def distanceToPoint(other: Point) =
    distanceBetweenPoints(x, y, other.x, other.y)
}

object Point {
  // private/protected members shared between
  // class and companion object
  private val grid = new Grid()

  def distanceBetweenPoints(x1: Double, y1: Double,
      x2: Double, y2: Double) = {
    val xDist = x1 - x2
    val yDist = y1 - y2
    math.sqrt(xDist*xDist + yDist*yDist)
  }
}
```

[google]: http://google.com
