# Express On Docker

This repository is an attempt to set up the bare minimum needed for Express development. Previous solutions have not had testing working, were slow, or just hard to update. 

The project uses the Docker PHP library "https://hub.docker.com/_/php" as well as some examples from the Lando project. Using SQLite seems a lot faster than MySQL.

```bash
# Setup code.
./setup.sh

# Build and run Docker container.
docker build -t express-php .
docker run --rm -d -p 8058:80 --name express express-php
```
