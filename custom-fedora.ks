# Maintained by the Fedora Workstation WG:
# http://fedoraproject.org/wiki/Workstation
# mailto:desktop@lists.fedoraproject.org

url --mirrorlist="https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-40&arch=x86_64"
repo--name=google-chrome--install--baseurl="https://dl.google.com/linux/chrome/rpm/stable/x86_64" --cost=0
repo --name=zoom --install --baseurl="https://zoom.us/linux/download/$basearch" --gpgkey=https://zoom.us/linux/download/pubkey --cost=0 repo --name=github-desktop --install --baseurl="https://packagecloud.io/shiftkey/desktop/fedora/38/x86_64" --gpgkey=https://packagecloud.io/shiftkey/desktop/gpgkey --cost=0 repo --name=code --install --baseurl="https://packages.microsoft.com/yumrepos/vscode" --gpgkey=https://packages.microsoft.com/keys/microsoft.asc --cost=0
%include fedora-live-base.ks
%include fedora-workstation-common.ks

part / --size 8192

# Base environment setup
lang en_US.UTF-8
keyboard us
timezone UTC

# Partitioning and installation setup
clearpart --all --initlabel
firewall --enabled --service=ssh
network --bootproto=dhcp --device=eth0

# Package installation
%packages
@core
@base-x
@fonts
git
curl
wget
# Essential tools
dnf-plugins-core
#Office
google-chrome-stable
%end

%post
# Add VSCode repository
cat << EOF > $INSTALL_ROOT/etc/yum.repos.d/vscode.repo
gpgkey=file:///etc/pki/rpm-gpg/microsoft.asc
EOF

# Add Zoom GPG key and repository
cat << EOF > $INSTALL_ROOT/etc/yum.repos.d/zoom.repo
gpgkey=file:///etc/pki/rpm-gpg/zoom.asc
EOF

# Add GitHub Desktop GPG key and repository
cat << EOF > $INSTALL_ROOT/etc/yum.repos.d/github-desktop.repo
gpgkey=file:///etc/pki/rpm-gpg/packagecloud-shiftkey.gpg
EOF

# Add Google Chrome repository
cat <<EOF >> /etc/yum.repos.d/google-chrome.repo
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF

# Create a static resolv.conf to ensure DNS resolution
cat << EOF > $INSTALL_ROOT/etc/resolv.conf
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF
%end

%post
# Refresh repo metadata and install packages
dnf clean all
dnf makecache
# Install VSCode, Zoom, GitHub Desktop, and Google Chrome
dnf install -y code google-chrome-stable github-desktop zoom
%end
