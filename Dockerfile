# Dotnet 6.0 is base
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env

# Use bash instead of default shell
SHELL ["/bin/bash", "--login", "-c"]

# Create profile file with default settings
RUN echo "export DOTNET_ROLL_FORWARD=Major" > ~/.bashrc && chmod +x ~/.bashrc

# Install nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash


# Work in the /app folder instead of container root
WORKDIR /app


# Copy only the nvmrc file first.
# This way docker will cache this file regardless to changes in other files and improve performance.
COPY ./.nvmrc .

# Configure node using the node-version-manager config file
RUN nvm install && nvm use


# Copy over the npm package/lock files and install.
# Doing this before the build script allows docker to cache this layer to improve performance in subsequent builds.
COPY ./control/package.json ./control/package.json
COPY ./control/package-lock.json ./control/package-lock.json
RUN npm install --prefix control


# Copy over the pcfproj and cdsproj and restore dependencies.
# Doing this before the build script allows docker to cache this layer to improve performance in subsequent builds.
COPY ./control/control.pcfproj ./control/control.pcfproj
COPY ./solution/solution.cdsproj ./solution/solution.cdsproj
RUN dotnet restore ./solution


# Copy all files (excluding what is specified in .dockerignore file)
COPY . .

# Build the project
RUN dotnet build ./solution -c Release 
