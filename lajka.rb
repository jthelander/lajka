#!/usr/bin/env ruby

require "rubygems"
require "commander/import"

program :version, "0.0.1"
program :description, "Command-line tool for copying photographs from somewhere to elsewhere."
default_command :copy

jpeg_extensions = %[.jpg .jpeg .jpe .jif .jfif .jfi]
raw_extensions = %[.3fr .ari .arw .bay .crw .cr2 .cap .dcs .dcr .dng .drf .eip .erf .fff .iiq .k25 .kdc .mdc .mef .mos .mrw .nef .nrw .obm .orf .pef .ptx .pxn .r3d .raf .raw .rwl .rw2 .rwz .sr2 .srf .srw .x3f]
video_extensions = %[.avi .mpeg .mpg .mp4 .mov .3gp .mkv]

command :copy do |c|
  c.syntax = "lajka run <source> <destination>"
  c.description = "Copies photographs from somewhere to elsewhere"
  c.action do |args, options|
    exit unless args[0] and args[1]
    source = "#{args[0]}/**/*"

    Dir.glob(source).each do |f|
      next unless File.file? f

      filename = File.basename f
      extension = File.extname(f).downcase
      modified_at = File.mtime f
      type = "MISC"

      if jpeg_extensions.include? extension
        type = "JPEG"
      elsif raw_extensions.include? extension
        type = "RAW"
      elsif video_extensions.include? extension
        type = "VIDEO"
      end

      destination = "#{args[1]}/#{type}/#{modified_at.year}/#{modified_at.strftime('%F')}"

      FileUtils.mkdir_p destination unless File.directory? destination
      FileUtils.cp f, destination, preserve: true unless File.file? "#{destination}/#{filename}"

      puts "Copied photograph #{filename} of type #{type} dated at #{modified_at.strftime('%F')}"
    end
  end
end
