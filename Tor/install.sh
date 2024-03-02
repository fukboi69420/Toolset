#########################
# Install Tor on Linux #
#########################

# Download the Tor browser
wget https://www.torproject.org/dist/torbrowser/13.0.10/tor-browser-linux-x86_64-13.0.10.tar.xz
tar -xvf tor-browser-linux64-10.0.1_ALL.tar.xz
cd tor-browser_en-US

# Ask user for desktop path and move start-tor-browser.desktop there
echo "Enter the path to your desktop: "
read desktop_path

# Move the start-tor-browser.desktop to the specified desktop path
mv start-tor-browser.desktop $desktop_path

# If no input was provided, cd .. and create new folder and move .desktop file in
if [ -z "$desktop_path" ]; then
	cd ..
	mkdir tor-browser_en-US
	mv start-tor-browser.desktop tor-browser_en-US
fi

# Print a message to indicate that the installation is finished
echo finished install