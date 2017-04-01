require 'open3'

class AppUtils

  def self.execute(command)
    is_success = system command
    unless is_success
      puts "\n\n======================================================\n\n"
      puts ' Something went wrong while executing this:'.red
      puts "  $ #{command}\n".yellow
      puts "======================================================\n\n"
      exit 1
    end
  end

  def self.is_folder? (path)
    File.directory?(path)
  end
end
