# Dockerfile for Adminer image
#
# This Dockerfile sets up a standard Adminer container that you can use
# inside your docker compose projects or standalone.
#
# I'm implementing Auto Login capability so it's easier
# for developers working on DB's
#
FROM adminer:latest

# Run install as root
USER root

# Tools for healthcheck
# Oly install what I'll need, i.e.: openssl netcat-openbsd curl.
RUN apt-get update && apt install -y curl

# Administrative port
EXPOSE 8080

# Autologin
COPY config/index.php /var/www/html/index.php

# Copy healthcheck
ADD healthcheck.sh /healthcheck.sh
RUN chmod +x /healthcheck.sh

# My custom health check
# I'm calling /healthcheck.sh so my container will report 'healthy' instead of running
# --interval=30s: Docker will run the health check every 'interval'
# --timeout=10s: Wait 'timeout' for the health check to succeed.
# --start-period=3s: Wait time before first check. Gives the container some time to start up.
# --retries=3: Retry check 'retries' times before considering the container as unhealthy.
HEALTHCHECK --interval=30s --timeout=10s --start-period=3s --retries=3 \
  CMD /healthcheck.sh || exit $?

# Run Adminer as adminer user
USER adminer

# Start the program with PHP
CMD	[ "php", "-S", "[::]:8080", "-t", "/var/www/html" ]
