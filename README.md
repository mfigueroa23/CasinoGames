# Casino Roulette — Betting Strategy Simulator

A Bash script that simulates roulette betting strategies with fictional money, letting you observe how classic systems play out over time.

## Strategies

| Strategy | Description |
|---|---|
| `martingala` | Double your bet after every loss; reset to the base bet after a win. |
| `labouchereInversa` | Start with a sequence `[1 2 3 4]`. Add the sum of the first and last elements as your bet. On a win, append the bet to the sequence. On a loss, remove both extremes. Reset when the sequence is empty. |

Both strategies bet continuously on **even (par)** or **odd (impar)** numbers (0–36).

## Usage

```bash
./casinoRoulete.sh -m <amount> -t <technique>
```

### Options

| Flag | Description |
|---|---|
| `-m <number>` | Starting fictional money amount |
| `-t <technique>` | Betting strategy: `martingala` or `labouchereInversa` |
| `-h` | Show the help panel |

### Examples

```bash
# Martingala with $1000
./casinoRoulete.sh -m 1000 -t martingala

# Reverse Labouchere with $500
./casinoRoulete.sh -m 500 -t labouchereInversa
```

## Session Stats

At the end of each run (out of money or bet exceeds balance) the script reports:

- Total number of rounds played
- Maximum balance reached and at which round
- Total wins and losses
- Sequence of losing numbers

## Requirements

- Bash (tested on macOS/Linux)
- A terminal that supports ANSI color codes

## Notes

This is a pure simulation using `$RANDOM` — no real money is involved. It is intended for educational exploration of betting system behavior, not as gambling advice.
