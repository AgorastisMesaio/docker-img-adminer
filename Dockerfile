# Dockerfile for Adminer image
#
# This Dockerfile sets up a standard Adminer container that you can use
# inside your docker compose projects or standalone.
#
# I'm implementing Auto Login capability so it's easier
# for developers working on DB's
#
FROM adminer:latest

# Administrative port
EXPOSE 8080

# Autologin
COPY config/index.php /var/www/html/index.php

# Run Adminer as adminer user
USER adminer

# Start the program with PHP
CMD	[ "php", "-S", "[::]:8080", "-t", "/var/www/html" ]
