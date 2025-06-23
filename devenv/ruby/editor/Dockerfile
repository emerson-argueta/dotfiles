FROM ubuntu:24.04

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Create the 'editor' user and set their home directory
RUN useradd -m -s /bin/zsh editor && \
    usermod -aG sudo editor # Add editor to sudo group if needed for installations

# Install essential tools and dependencies:
# build-essential (for compiling tools), git, curl, zsh, tmux, python3-pip,
# ripgrep, fzf, wget, unzip, fontconfig.
# Ruby dependencies: libssl-dev, zlib1g-dev, libreadline-dev, libyaml-dev, libffi-dev,
# libgdbm-dev, libncurses5-dev.
# Database client libraries: libpq-dev (PostgreSQL), libmysqlclient-dev (MySQL).
# Node.js and Yarn.
RUN apt-get update && \
    apt-get install -y \
    cmake \
    bison \
    python3 \
    build-essential \
    git \
    curl \
    zsh \
    tmux \
    python3-pip \
    ripgrep \
    fzf \
    wget \
    unzip \
    fontconfig \
    libssl-dev \
    zlib1g-dev \
    libreadline-dev \
    libyaml-dev \
    libffi-dev \
    libgdbm-dev \
    libncurses5-dev \
    libpq-dev \
    libmysqlclient-dev \
    nodejs \
    npm \
    yarn \
    --no-install-recommends && \
    # Clean up APT cache to reduce image size
    rm -rf /var/lib/apt/lists/*

# --- chruby and ruby-install Installation ---
# Install ruby-install (often used with chruby to install Ruby versions)
RUN wget https://github.com/postmodern/ruby-install/releases/download/v0.10.1/ruby-install-0.10.1.tar.gz && \
  tar -xzvf ruby-install-0.10.1.tar.gz && \
  cd ruby-install-0.10.1/ && \
  make install

# Install chruby
RUN wget https://github.com/postmodern/chruby/releases/download/v0.3.9/chruby-0.3.9.tar.gz && \
  tar -xzvf chruby-0.3.9.tar.gz && \
  cd chruby-0.3.9/ && \
  make install


# IMPORTANT: Set the default shell for subsequent RUN commands and CMD here,
# ensuring .zshrc is sourced and chruby is initialized correctly.
SHELL ["/bin/zsh", "-lc"]

# Install the latest stable Ruby version using ruby-install (e.g., 3.3.0 as of current stable)
# chruby will automatically switch to this version upon shell login.
RUN ruby-install ruby-3.3.2
# --- End chruby and ruby-install Installation ---

# Configure Git with a default user name and email
# You can change these values after connecting to the container if needed.
RUN git config --global user.name "Your Name" && \
    git config --global user.email "you@example.com"


# --- Nerd Fonts Installation ---
# Create a directory for Nerd Fonts
USER root
RUN mkdir -p /usr/local/share/fonts/truetype/nerdfonts && \
    # Download Iosevka Term SS09 Nerd Font (a popular variant with ligatures)
    # This URL points to a specific release from the Nerd Fonts GitHub repository.
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Iosevka.zip -O /tmp/Iosevka.zip && \
    # Unzip the font files into the fonts directory
    unzip -o /tmp/Iosevka.zip -d /usr/local/share/fonts/truetype/nerdfonts && \
    # Clean up the downloaded zip file
    rm /tmp/Iosevka.zip && \
    # Update the font cache to register the new fonts
    fc-cache -fv
# --- End Nerd Fonts Installation ---


# --- Neovim and Homebrew Installation ---
# Create linuxbrew user for Homebrew installation as per Homebrew's recommendations
USER root
RUN useradd -m -s /bin/zsh linuxbrew && \
    usermod -aG sudo linuxbrew && \
    mkdir -p /home/linuxbrew/.linuxbrew && \
    chown -R linuxbrew: /home/linuxbrew/.linuxbrew

# Switch to linuxbrew user to install Homebrew
USER linuxbrew
ENV HOME /home/linuxbrew
ENV HOMEBREW_INSTALL_FROM_API=1
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
RUN git config --global --add safe.directory /home/linuxbrew/.linuxbrew/Homebrew

# Switch back to root to set global PATH and install common tools for any user
USER root
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"
ENV HOMEBREW_NO_INSTALL_CLEANUP=1
ENV HOMEBREW_NO_AUTO_UPDATE=1

# --- Powerlevel10k Installation ---
# Install Powerlevel10k for the 'editor' user
USER linuxbrew
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/linuxbrew/.powerlevel10k && \
    echo 'source /home/linuxbrew/.powerlevel10k/powerlevel10k.zsh-theme' >> /home/linuxbrew/.zshrc
# --- End Powerlevel10k Installation ---

# Configure tmux plugin manager for user
RUN git clone https://github.com/tmux-plugins/tpm /home/linuxbrew/.tmux/plugins/tpm

# Ensure chruby is sourced in the user's .zshrc
# This needs to be done under the  user's context
RUN echo 'source /usr/local/share/chruby/chruby.sh' >> /home/linuxbrew/.zshrc && \
    echo 'source /usr/local/share/chruby/auto.sh' >> /home/linuxbrew/.zshrc

# Correct permission issue for Homebrew directory so 'editor' user can execute brew commands
USER linuxbrew
RUN brew update
RUN brew install neovim

# Install foreman as a global gem.
# This is installed after Ruby is set up by chruby.
# RUN gem install foreman

# Expose port 3000, as the Rails server will be run from this container.
EXPOSE 3000

# Default command to run when the container starts.
# 'zsh' will launch an interactive zsh shell from which the user can create and run a Rails project.
CMD ["zsh"]
