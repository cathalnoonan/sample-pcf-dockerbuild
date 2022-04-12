# Dotnet 6.0 is base
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env

# Use bash instead of default shell
SHELL ["/bin/bash", "--login", "-c"]

# Install nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Install xmlstarlet for setting the version numbers
RUN apt-get update && apt-get install -y xmlstarlet

# Work in the /app folder instead of container root
WORKDIR /app

# Copy over the pcfproj and cdsproj and restore dependencies.
# Doing this before the build script allows docker to cache this layer to improve performance in subsequent builds.
COPY ./control/control.pcfproj ./control/
COPY ./solution/solution.cdsproj ./solution/
RUN dotnet restore ./solution

# Configure node using the node-version-manager config file.
# This way docker will cache this file regardless to changes in other files and improve performance.
COPY ./.nvmrc .
RUN nvm install && nvm use

# Copy over the npm package/lock files and install.
# Doing this before the build script allows docker to cache this layer to improve performance in subsequent builds.
COPY ./control/package.json ./control/package-lock.json ./control/
RUN npm install --prefix control

# Copy all files (excluding what is specified in .dockerignore file)
COPY . .

# Set the version numbers consistently in the repo.
RUN ./version.sh

# Build the project
RUN dotnet build ./solution -c Release 
