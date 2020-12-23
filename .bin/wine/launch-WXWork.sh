#!/usr/bin/env bash
cd /work/wines/office/drive_c/apps/WXWork
#LANG=zh_CN.UTF-8 WINEPREFIX="/work/wines/office" WINEARCH=win32 wine start WXWork.exe
LANG=zh_CN.UTF-8 WINEPREFIX="/work/wines/office" WINEARCH=win32 wine explorer /desktop=wxwork,1080x700 WXWork.exe
