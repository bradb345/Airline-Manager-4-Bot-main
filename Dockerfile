# Use official Playwright image with all browsers pre-installed
FROM mcr.microsoft.com/playwright:v1.56.1-jammy

# Set working directory
WORKDIR /app

# Copy package files
COPY package.json package-lock.json* ./

# Install dependencies
RUN npm ci

# Copy the rest of the application
COPY . .

# Install Playwright browsers (already in the image, but ensure they're available)
# RUN npx playwright install --with-deps chromium

# Set environment to non-interactive
ENV CI=true

# Run the tests in a loop every 30 minutes (1800 seconds)
CMD ["sh", "-c", "while true; do echo \"[$(date)] Starting bot run...\"; npx playwright test; echo \"[$(date)] Bot run completed. Sleeping for 30 minutes...\"; sleep 1800; done"]
