require "rubygems"

module Lajka
  VERSION = "0.0.3"

  module Formats
    JPEG  = %[.jpg .jpeg .jpe .jif .jfif .jfi]
    RAW   = %[.3fr .ari .arw .bay .crw .cr2 .cap .dcs .dcr .dng .drf .eip .erf .fff .iiq .k25 .kdc .mdc .mef .mos .mrw .nef .nrw .obm .orf .pef .ptx .pxn .r3d .raf .raw .rwl .rw2 .rwz .sr2 .srf .srw .x3f]
    VIDEO = %[.avi .mpeg .mpg .mp4 .mov .3gp .mkv]
  end

  def self.copy source, destination
    metadata = Lajka::metadata source
    destination = Lajka::destination metadata, destination

    Lajka::mkdir destination
    Lajka::cp metadata, destination
  end

  def self.metadata source
    ext = File.extname(source).downcase
    type = "MISC"
    type = "JPEG" if Lajka::Formats::JPEG.include? ext
    type = "RAW" if Lajka::Formats::RAW.include? ext
    type = "VIDEO" if Lajka::Formats::VIDEO.include? ext

    {
      "file" => File.basename(source),
      "ext" => ext,
      "mtime" => File.mtime(source),
      "ctime" => File.ctime(source),
      "source" => source,
      "type" => type
    }
  end

  private
  def self.destination metadata, destination
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
