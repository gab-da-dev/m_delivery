To install Flutter on Ubuntu, you can follow these steps:

Step 1: Update your system
Open a terminal and run the following commands to update your system packages:

terminal:

sudo apt update
sudo apt upgrade

Step 2: Install the required dependencies
Flutter has some dependencies that need to be installed. Run the following command to install them:

terminal:
sudo apt install git curl unzip xz-utils zip libglu1-mesa

Step 3: Download Flutter SDK
You can download the Flutter SDK from the official Flutter website. Open a terminal and run the following commands to download Flutter:

terminal:
cd ~
git clone https://github.com/flutter/flutter.git

This will clone the Flutter repository to your home directory.

Step 4: Add Flutter to your PATH
Open your .bashrc file using a text editor:

terminal:
nano ~/.bashrc

Add the following line at the end of the file:

terminal:

export PATH="$PATH:$HOME/flutter/bin"

Save the file and exit the text editor.

Load the updated .bashrc file into the current session by running the following command:

terminal:
source ~/.bashrc

Step 5: Verify the Flutter installation
Run the following command to verify that Flutter is properly installed:

terminal:
flutter doctor

This command will check if there are any issues with your Flutter installation and provide guidance on how to fix them.

Step 6: Download Android Studio
https://developer.android.com/studio


Step 7: Install Android Studio
After the download is complete, navigate to the directory where the downloaded package is located. Open a terminal and run the following command to extract the package:

tar -xvf android-studio-*.tar.gz

Replace android-studio-* with the actual name of the downloaded file.

Next, move the extracted Android Studio folder to the /opt directory:

terminal
sudo mv android-studio /opt/

Step 8: Set up environment variables
Open your .bashrc file using a text editor:

terminal:
nano ~/.bashrc

Add the following lines at the end of the file:

terminal

export PATH="/opt/android-studio/bin:$PATH"
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"

Save the file and exit the text editor.

Load the updated .bashrc file into the current session by running the following command:

terminal:
source ~/.bashrc

Step 9: Launch Android Studio
Open a terminal and run the following command to launch Android Studio:

studio.sh

This will start the Android Studio setup wizard. Follow the on-screen instructions to complete the installation.

Step 10: Set up Android SDK
Once Android Studio is launched, you need to set up the Android SDK. Follow the prompts to install the necessary components and accept the license agreements.

After the installation is complete, you can start using Android Studio for Android app development.

That's it! You have successfully installed Android Studio on Ubuntu.
