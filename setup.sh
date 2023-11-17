#!/bin/sh

# Update the package repository
apk update

# Install PostgreSQL and its dependencies
apk add postgresql postgresql-client postgresql-contrib

# Initialize the PostgreSQL data directory
su - postgres -c "initdb -D /var/lib/postgresql/data"

# Modify PostgreSQL configuration to allow connections from all IP addresses
echo "host all all 0.0.0.0/0 md5" >> /var/lib/postgresql/data/pg_hba.conf
echo "listen_addresses = '*'" >> /var/lib/postgresql/data/postgresql.conf

# Start the PostgreSQL service
rc-service postgresql start

# Enable PostgreSQL to start on boot
rc-update add postgresql

# Set the password for the 'postgres' user to 'root'
su - postgres -c "psql -c \"ALTER USER postgres WITH PASSWORD 'root';\""

# Restart PostgreSQL to apply the configuration changes
rc-service postgresql restart

echo "PostgreSQL installed and configured. User: postgres, Password: root"

# Install Git, Node.js, and npm
apk add nodejs npm

echo "Node.js, and npm installed"