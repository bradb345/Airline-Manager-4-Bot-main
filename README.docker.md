# Docker Setup for Airline Manager Bot

## Prerequisites

- Docker installed on your machine
- Docker Compose installed (usually comes with Docker Desktop)

## Setup Instructions

1. **Create your environment file:**
   ```bash
   cp .env.example .env
   ```
   
2. **Edit `.env` file with your credentials:**
   ```bash
   nano .env  # or use your preferred editor
   ```

## Running with Docker Compose (Recommended)

The bot is configured to run continuously in a loop, executing tests every 30 minutes (matching the GitHub Actions schedule).

**Build and run the bot in background:**
```bash
docker-compose up -d --build
```

**View logs in real-time:**
```bash
docker-compose logs -f
```

**Stop the bot:**
```bash
docker-compose down
```

**Restart the bot:**
```bash
docker-compose restart
```

**Check bot status:**
```bash
docker-compose ps
```

## Running with Docker (Without Compose)

**Build the image:**
```bash
docker build -t airline-manager-bot .
```

**Run the container:**
```bash
docker run --rm \
  --env-file .env \
  -v $(pwd)/playwright-report:/app/playwright-report \
  -v $(pwd)/test-results:/app/test-results \
  airline-manager-bot
```

## Viewing Test Reports

After running the tests, the Playwright HTML report will be available in the `playwright-report` directory on your host machine.

To view the report:
```bash
npx playwright show-report playwright-report
```

## Scheduling with Cron

To run the bot on a schedule, you can set up a cron job:

1. Open crontab:
   ```bash
   crontab -e
   ```

2. Add a schedule (example: run every 4 hours):
   ```bash
   0 */4 * * * cd /Users/bradleybernard/Documents/code/Airline-Manager-4-Bot-main && docker-compose up >> /tmp/airline-bot.log 2>&1
   ```

## Troubleshooting

**Container exits immediately:**
- Check logs: `docker-compose logs`
- Ensure .env file exists and contains valid credentials

**Permission issues:**
- Ensure the mounted volume directories have proper permissions

**Browser launch failures:**
- The Playwright Docker image should have all dependencies pre-installed
- If issues persist, try rebuilding: `docker-compose build --no-cache`
