#!/bin/sh

gsettings set com.canonical.indicator.datetime time-format "custom"
gsettings set com.canonical.indicator.datetime custom-time-format "%m月 %d日(%A) %H:%M:%S"
