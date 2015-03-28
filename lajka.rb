#!/usr/bin/env ruby

require "rubygems"
require "commander/import"

program :version, "0.0.1"
program :description, "Command-line tool for copying photographs from somewhere to elsewhere."

default_command :copy
never_trace!

jpeg_extensions = %[.jpg .jpeg .jpe .jif .jfif .jfi]
raw_extensions = %[.3fr .ari .arw .bay .crw .cr2 .cap .dcs .dcr .dng .drf .eip .erf .fff .iiq .k25 .kdc .mdc .mef .mos .mrw .nef .nrw .obm .orf .pef .ptx .pxn .r3d .raf .raw .rwl .rw2 .rwz .sr2 .srf .srw .x3f]
video_extensions = %[.mov]

command :copy do |c|
  c.syntax = "lajka run <source> <destination>"
  c.description = "Copies photographs from somewhere to elsewhere"
  c.action do |args, options|
    source = "src/**/*"
    dest = "dest"

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

      dest_full = "#{dest}/#{type}/#{modified_at.year}/#{modified_at.strftime('%F')}"

      FileUtils.mkdir_p dest_full unless File.directory? dest_full
      FileUtils.cp f, dest_full unless File.file? "#{dest_full}/#{filename}"

      puts "Copied photograph #{filename} of type #{type} modified at #{modified_at.strftime('%F')}"
    end
  end
end
