# Superhero Activity Generator 🦸

A bash script that generates random commits to make your GitHub contribution graph look active.

## Features

- Generates random commits for the past 365 days (configurable)
- Creates fake "hero" JSON files with random power levels
- Customizable commits per day
- Backdated commits to fill your contribution graph

## Usage

```bash
# Run with defaults (5 commits/day for 365 days)
bash super.sh

# Customize via environment variables
COMMITS_PER_DAY=10 DAYS_BACK=100 bash super.sh
```

## Push to GitHub

```bash
git push -u origin main --force
```

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `COMMITS_PER_DAY` | 5 | Maximum commits per day |
| `DAYS_BACK` | 365 | How many days back to generate commits |

## License

MIT
