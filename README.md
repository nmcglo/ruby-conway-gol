# ruby-conway-gol

> **Note:** This was a quick POC project that I wrote when I wanted
> to understand the Ruby langauge a little bit. 'Hello, World!' programs
> are just enough to test that the language interpreter/compiler is
> installed correctly. I always felt that Conway's game of life was
> a good extra step to understand the very basics of a langauge:
> class, function, and variable syntax; multi-dimensional arrays;
> optional graphics or text representation of the board state; with
> very simple, well-defined logic that's easy to implement. So that's
> what this is!

Conway's Game of Life in Ruby, rendered in a Tk window.

## Requirements

- Ruby with the `tk` binding available (`require 'tk'`) and a Tcl/Tk runtime.
- A display (X11/Wayland/macOS); there is no headless/terminal renderer.

## Run

```sh
ruby gameboard.rb
```

A 50x30 grid of 10px cells opens in a window titled "Conway". The initial
population is random: each cell is born alive with probability 0.45
(`rand > 0.55`). Generations advance roughly every 30 ms.

Grid geometry lives in globals at the bottom of `gameboard.rb`:

```ruby
$cell_size = 10
$width     = 50
$height    = 30
```

## Files

| File | Purpose |
| --- | --- |
| `life_matrix.rb` | Simulation core: `LifeMatrix` (grid, neighbor wiring, `tick`) and `Cell` (state, rule evaluation). |
| `gameboard.rb` | Tk front end plus the entry point; draws each cell as a filled rectangle and drives the clock. |
| `life_matrix_test.rb` | `test/unit` smoke test that builds a 5x10 matrix and prints it. |
| `testing.rb` | Unrelated scratch script demonstrating object aliasing between two containers. |

## Design

`LifeMatrix#initialize` allocates `height * width` `Cell` objects and gives each
one direct references to its neighbors, so rule evaluation never indexes back
into the grid.

`LifeMatrix#tick` is a two-phase update, which is what keeps the generation
synchronous:

1. `tic` on every cell computes `next_state` from the *current* neighbor states.
2. `toc` on every cell commits `next_state` into `state`.

Cell rules (`Cell#tic`) are the standard B3/S23 rules: a live cell with fewer
than 2 or more than 3 live neighbors dies, a dead cell with exactly 3 live
neighbors is born.

## Known deviations and rough edges

- Edges are clipped, not wrapped: border cells simply have fewer neighbors.
- `LifeMatrix#to_s` indexes `@cells[j][i]` (row/column swapped) and loops
  `0..@height` / `0..@width` inclusive, so it raises on non-square grids and
  runs one past the end. Only `life_matrix_test.rb` exercises it.
- `Gameboard#draw` recurses via `@canvas.after(30, self.draw)`, which *calls*
  `draw` immediately instead of passing a callback, so the animation loop is
  unbounded recursion rather than a scheduled timer.
- Each frame allocates a fresh `TkcRectangle` per cell; old items are never
  deleted, so canvas memory grows with runtime.
- `time_alive` is declared via `attr_accessor` and printed by `how_long_alive`,
  but nothing ever assigns it.

## Tests

```sh
ruby life_matrix_test.rb
```

The suite is a single construction-and-print smoke test; it asserts nothing
about the rules. `life_matrix.rb` has no Tk dependency, so the test runs
without the Tk binding installed.
