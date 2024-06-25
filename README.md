# Custom Fedora ISO with preinstalled application
## Steps to build a custom iso
1. Install lice-cd tools
      sudo dnf install livecd-tools git
2. Clone the fedora kickstart repository
      git clone https://pagure.io/fedora-kickstarts.git
      cd fedora-kickstarts
3. Copy and customize the kickstart file and install vim
      cp fedora-live-workstation.ks custom-fedora.ks
      sudo dnf install vim
      vim custom-fedora.ks
4. Add required packages, repositories and other relevant information in custom-fedora.ks
5. Build the custom ISO:
     sudo livecd-creator --verbose --config=custom-fedora.ks --fslabel=CustomFedora --cache=~/livecd-cache--tmpdir=~/livecd-tmp
## Installation 
1. Use anf VM software, I have used VMware to boot.
2. Follow the standard requisites required for the installation of fedora.
         link: https://fedoraproject.org/workstation/download
## Verification steps
1. After the installation of Github, Zoom, VSCode, Google Chrome verify it by:
     code --version (vsc)
     github-desktop --version (github)
     zoom --version (zoom)
     google-chrome-stable (google chrome)
