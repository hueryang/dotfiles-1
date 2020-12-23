#!/usr/bin/env bash
cd /work/wines/office/drive_c/apps/WeChat/
#LANG=zh_CN.UTF-8 WINEPREFIX="/work/wines/office" WINEARCH=win32 wine start WeChat.exe
LANG=zh_CN.UTF-8 WINEPREFIX="/work/wines/office" WINEARCH=win32 wine explorer /desktop:wechat,1080x700 WeChat.exe
