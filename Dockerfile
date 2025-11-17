FROM debian:bullseye-slim

# Install Zola
RUN apt-get update && \
    apt-get install -y wget ca-certificates && \
    wget -q https://github.com/getzola/zola/releases/download/v0.18.0/zola-v0.18.0-x86_64-unknown-linux-gnu.tar.gz && \
    tar xzf zola-v0.18.0-x86_64-unknown-linux-gnu.tar.gz && \
    mv zola /usr/local/bin/ && \
    rm zola-v0.18.0-x86_64-unknown-linux-gnu.tar.gz && \
    apt-get remove -y wget && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy site files
COPY . .

# Build the site
RUN zola build

# Expose port for App Platform
EXPOSE 8080

# Serve the site
CMD ["zola", "serve", "--interface", "0.0.0.0", "--port", "8080"]
