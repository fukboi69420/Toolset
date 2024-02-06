#########################
# Install Tor on Linux #
#########################

set -e

if [ "$(id -u)" -ne 0 ]; then
	echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
	exit 1
fi

echo "Installing Tor..."

apt-get update
apt-get install -y tor torbrowser-launcher

echo "Tor installed successfully!"
