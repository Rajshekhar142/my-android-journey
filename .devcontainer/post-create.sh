#!/bin/bash

# Update package lists and install necessary dependencies
sudo apt-get update
sudo apt-get install -y wget unzip libncurses5 qemu-kvm tigervnc-standalone-server novnc websockify fluxbox

# Set Android environment variables
export ANDROID_HOME=$HOME/android-sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator

# Download and install Android command line tools
wget -O commandlinetools.zip https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip
mkdir -p $ANDROID_HOME/cmdline-tools
unzip commandlinetools.zip -d $ANDROID_HOME/cmdline-tools
mv $ANDROID_HOME/cmdline-tools/cmdline-tools $ANDROID_HOME/cmdline-tools/latest
rm commandlinetools.zip

# Accept licenses and install platform tools, emulator, and a system image
yes | sdkmanager --licenses
sdkmanager "platform-tools" "emulator" "system-images;android-33;google_apis;x86_64"

# Create a new Android Virtual Device (AVD)
echo "no" | avdmanager create avd -n pixel_emulator -k "system-images;android-33;google_apis;x86_64"

# Add the environment variables to the bash profile so they are available in new terminals
echo 'export ANDROID_HOME=$HOME/android-sdk' >> ~/.bashrc
echo 'export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator' >> ~/.bashrc

echo "Android environment setup complete!"
