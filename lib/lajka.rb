require "rubygems"

module Lajka
  VERSION = "0.0.4"

  module Format
    JPEG  = %[.jpg .jpeg .jpe .jif .jfif .jfi]
    RAW   = %[.3fr .ari .arw .bay .crw .cr2 .cap .dcs .dcr .dng .drf .eip .erf .fff .iiq .k25 .kdc .mdc .mef .mos .mrw .nef .nrw .obm .orf .pef .ptx .pxn .r3d .raf .raw .rwl .rw2 .rwz .sr2 .srf .srw .x3f]
    VIDEO = %[.avi .mpeg .mpg .mp4 .mov .3gp .mkv]
  end

  module Metadata
    def self.get source
      ext = File.extname(source).downcase
      type = "MISC"
      type = "JPEG" if Lajka::Format::JPEG.include? ext
      type = "RAW" if Lajka::Format::RAW.include? ext
      type = "VIDEO" if Lajka::Format::VIDEO.include? ext

      {
        "file" => File.basename(source),
        "ext" => ext,
        "mtime" => File.mtime(source),
        "ctime" => File.ctime(source),
        "source" => source,
        "type" => type
      }
    end
  end

  class Copier
    def copy source, destination
      metadata = Lajka::Metadata::get source
      destination = Lajka::Copier::get_destination metadata, destination

      Lajka::Copier::mkdir destination
      Lajka::Copier::cp metadata, destination
    end

    private
    def self.get_destination metadata, destination
      "#{destination}/#{metadata['type']}/#{metadata['mtime'].year}/#{metadata['mtime'].strftime('%F')}"
    end

    def self.mkdir dir
      FileUtils.mkdir_p dir unless File.directory? dir
    end

    def self.cp metadata, destination
      return false if File.file? "#{destination}/#{metadata['file']}"

      FileUtils.cp metadata["source"], destination, preserve: true
      true
    end
  end
end

