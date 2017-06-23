#!/bin/sh

# Remove old ros installation
sudo rm -rf /opt/ros


do_cleanup()
{
    echo 'uninstall Home brew'
# Uninstall home brew
    brew install wget
    brew cleanup
    wget https://gist.githubusercontent.com/mxcl/1173223/raw/a833ba44e7be8428d877e58640720ff43c59dbad/uninstall_homebrew.sh
    bash uninstall_homebrew.sh
    rm Uninstall_homebrew.sh
    sudo rm -rf /usr/local/Cellar /usr/local/.git
    sudo rm -rf /usr/local/Library/Taps
# sudo rm -rf /usr/local/Homebrew
# sudo rm -rf /usr/local/Caskroom
## rm -rf ~/Library/Caches/Homebrew
    rm -rf ~/Library/Logs/Homebrew
## sudo rm -rf /Library/Caches/Homebrew
# sudo rm -rf /Library/Homebrew/

# Clean up ""all"" python packages
    sudo rm -rf /Library/Python/2.7/site-packges
    sudo rm -rf /usr/local/lib/python2.7/site-packages

    echo 'install Home brew'
# install Home brew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo export PATH='/usr/local/bin:$PATH' >> ~/.zshrc
    source $HOME/.zshrc
    brew doctor
    brew update

# Install zshell, if you want to use bash instead, you should change the sourced files from .zsh to .bash
    brew install zsh
}

# do_cleanup

# XQuartz
brew install caskroom/cask/brew-cask
brew cask install xquartz

# Install brewed python
brew install python
mkdir -p ~/Library/Python/2.7/lib/python/site-packages
 echo "$(brew --prefix)/lib/python2.7/site-packages" >> ~/Library/Python/2.7/lib/python/site-packages/homebrew.pth

# sudo easy_install pip

# Homebrew taps for prerequisites
# Gives us console_bridge, urdfdom, and gtest.
brew tap ros/deps

brew tap homebrew/versions
brew tap homebrew/science

# brew tap osrf/simulation
# Sierra no longer has a working qt4 so use this private version until the issue is resolved.
brew tap lloydc99/simulation
brew tap cartr/qt4
# brew install cartr/qt4/qt
# brew install cartr/qt4/pyqt



# Prerequisites
brew install cmake libyaml lz4 theora poco numpy intltool

brew install boost --with-python
## brew install opencv --with-tbb

## brew install opencv --with-qt --with-eigen --with-tbb

brew install https://raw.githubusercontent.com/NikolausDemmel/homebrew-simulation/ogre-fixes/ogre1.9.rb
brew install https://raw.githubusercontent.com/NikolausDemmel/homebrew-simulation/ogre-fixes/gazebo2.rb

echo "Fix header problem in ros_comm indigo until patch is pushed."
if [ -d src/ros_comm/rosconsole ]; then
    pushd src/ros_comm/rosconsole
    curl https://gist.githubusercontent.com/lloydc99/da3b16f8afe49dd5b059dcf19f79ddc6/raw/ec566b0aac2e914164d2262f72182f9a171c3f94/ros_comm_vector.patch | patch -p1
    popd
fi

# Install the ROS infrastructure tools, you may have to run this several times until all python deps are properly installed
pip install -U setuptools rosdep rosinstall_generator wstool rosinstall catkin_tools catkin_pkg bloom empy sphinx pycurl
sudo rosdep init

# sudo pip install -U --install-option="--include-path=/usr/local/include" --install-option="--library-path=/usr/local/lib" pygraphviz

if [ ! -f /etc/ros/rosdep/10-ros-install-osx.list ]; then
    echo "This sudo prompt adds the brewed python rosdep and legacy qt4 yaml to /etc/ros/rosdep/10-ros-install-osx.list."
    sudo sh -c "echo 'yaml https://gist.githubusercontent.com/lloydc99/827e2f2fad3c97de11687121301c1ce5/raw/1061326d022c3e4f056e38040b1260c352a613c7/rosdeps.yaml osx' > /etc/ros/rosdep/sources.list.d/10-ros-install-osx.list"
fi

rosdep update

# Download the ROS sources
mkdir $HOME/ros_catkin_ws && cd $HOME/ros_catkin_ws
rosinstall_generator desktop_full --rosdistro indigo --deps --tar > indigo.rosinstall
wstool init -j8 src indigo.rosinstall

# Grabbing these older meshes allows rviz to run with Ogre 1.7 rather than Ogre 1.8+.
# Some details here: https://github.com/ros-visualization/rviz/issues/782
if [ -d src/rviz ]; then
    pushd src/rviz/ogre_media/models
    curl https://raw.githubusercontent.com/ros-visualization/rviz/hydro-devel/ogre_media/models/rviz_cone.mesh > rviz_cone.mesh
    curl https://raw.githubusercontent.com/ros-visualization/rviz/hydro-devel/ogre_media/models/rviz_cube.mesh > rviz_cube.mesh
    curl https://raw.githubusercontent.com/ros-visualization/rviz/hydro-devel/ogre_media/models/rviz_cylinder.mesh > rviz_cylinder.mesh
    curl https://raw.githubusercontent.com/ros-visualization/rviz/hydro-devel/ogre_media/models/rviz_sphere.mesh > rviz_sphere.mesh
    popd
fi

# This patch originates from here: https://github.com/ros/catkin/pull/784
#if [ -d src/catkin ]; then
#    pushd src/catkin/cmake
#    curl https://raw.githubusercontent.com/ros/catkin/8a47f4eceb4954beb4a5b38b50793d0bbe2c96cf/cmake/catkinConfig.cmake.in > catkinConfig.cmake.in
#    popd
#fi

# Install the ROS dependencies
rosdep install --from-paths src --ignore-src --rosdistro indigo -y --skip-keys python-qt-bindings-qwt5 --skip-keys libqt5-core --skip-keys libqt5-gui --skip-keys libqt5-opengl --skip-keys libqt5-opengl-dev --skip-keys libqt5-widgets --skip-keys qt5-qmake --skip-keys qtbase5-dev --skip-keys python-imaging


# Fix for strange lack of nosetests in osx, kindof hackish
if [ -z `which nosetests` ]; then
    ln -s /usr/local/Cellar/numpy/$(python -c "import numpy; print numpy.__version__")/libexec/nose/bin/nosetests /usr/local/bin

# Parallel build
sudo mkdir -p /opt/ros/indigo
sudo chown $USER /opt/ros/indigo
catkin config --install  --install-space /opt/ros/indigo --cmake-args \
       -DCMAKE_BUILD_TYPE=Release \
       -DCMAKE_FIND_FRAMEWORK=LAST \
       -DCATKIN_ENABLE_TESTING=1 \
       -DPYTHON_LIBRARY=$(python -c "import sys; print sys.prefix")/lib/libpython2.7.dylib \
       -DPYTHON_INCLUDE_DIR=$(python -c "import sys; print sys.prefix")/include/python2.7

catkin build
# -DPYTHON_LIBRARY=/usr/local/Cellar/python/2.7.9/Frameworks/Python.framework/Versions/2.7/lib/libpython2.7.dylib \
# -DPYTHON_INCLUDE_DIR=/usr/local/Cellar/python/2.7.9/Frameworks/Python.framework/Versions/2.7/include/python2.7

source /opt/ros/indigo/setup.zsh

cd ~/ros_catkin_ws
# mv src src_isolated
# mkdir src
# catkin build
# source ~/ros_catkin_ws/devel/setup.zsh
