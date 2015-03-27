# Lajka

Lajka is a simple command-line tool for copying photographs from somewhere to elsewhere. It has only one use and that is to copy photographs and videos from a source directory or volume (such as a memory card) to a destination directory.

* It sorts these photographs and videos first by type (jpeg, raw, video, misc) and then by date
* It does not overwrite existing photographs

The destination directory structure looks like this: 

```
+-- JPEG
|   +-- 2014
|       +-- 2014-12-24
|           +-- R0000621.JPG
|           +-- R0000622.JPG
|           +-- R0000623.JPG
|           +-- R0000624.JPG
|   +-- 2015
|       +-- 2015-01-01
|           +-- R0000630.JPG
|           +-- R0000631.JPG
+-- RAW
|   +-- 2014
|       +-- 2014-12-24
|           +-- R0000621.DNG
|           +-- R0000622.DNG
|           +-- R0000623.DNG
|           +-- R0000624.DNG
|   +-- 2015
|       +-- 2015-01-01
|           +-- R0000630.DNG
|           +-- R0000631.DNG
+-- VIDEO
|   +-- 2014
|       +-- 2014-12-31
|           +-- R0000627.MOV
|           +-- R0000628.MOV
```
