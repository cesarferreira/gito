require 'tmpdir'
require 'fileutils'
require 'uri'
require 'open-uri'
require 'json'
require_relative './app_utils'

class Project
  def initialize(url)
    @base_url = sanitize_url(url)
    @destination_dir = nil
    @destination = destination
    @detector_json_path = 'https://raw.githubusercontent.com/cesarferreira/gito/master/detector.json'
  end

  def sanitize_url(url)
    url = url.split('?').first
    url.chop! if url.end_with? '/'

    is_valid_url = url =~ /\A#{URI::regexp(['http', 'https'])}\z/ || url.include?('git@')

    unless is_valid_url

      valid_shortcut = url.split('/').size == 2

      if valid_shortcut
        url = 'https://github.com/' + url
      else
        url = nil
      end
    end
    url
  end

  def destination
    unless @base_url.include? 'github.com'
      return Digest::SHA256.hexdigest @base_url
    end

    stripped_url = @base_url.gsub('.git', '')
    stripped_url = stripped_url.gsub('.git', '')
    stripped_url = stripped_url.gsub('git@github.com:', '')
    stripped_url = stripped_url.gsub('https://github.com/', '')
    stripped_url.gsub('http://github.com/', '')

    stripped_url.gsub('/','-')
  end

  def change_directory
    # TODO aparently this doesn't work because ruby forks the terminal process and can't communicate with his parent

    # temp_script_name = './temp.sh'
    # AppUtils::execute 'echo "cd '+@destination+'" > ' + temp_script_name
    # AppUtils::execute '. '+temp_script_name
    # AppUtils::execute 'rm -rf ' + temp_script_name

    puts "-------------------------------------------"
    puts "Please change directory"
    puts "cd #{@destination_dir.yellow}"
    puts "-------------------------------------------"
  end

  def install_dependencies
    file  = open(@detector_json_path) {|f| f.read }
    types = JSON.parse(file)
    chosen = nil

    Dir.chdir(@destination_dir)

    types.each do |item|
      if File.exists? (item['file_requirement'])
        puts "#{item['type']} detected...".yellow
        go_inside_and_run item['installation_command']
      end
    end
  end

  def cloneable_url
    starts_with_git = @base_url.split(//).first(4).join.eql? 'git@'
    ends_with_git = @base_url.split(//).last(4).join.eql? '.git'

    # ends with git but doesnt start with git
    return @base_url if ends_with_git && !starts_with_git

    # ends with git but doesnt start with git
    return "#{@base_url}.git" if !ends_with_git && !starts_with_git

    @base_url
  end

  ##
  ## CLONE THE REPOSITORY
  ##
  def clone(is_temp_folder=false)
    cloneable = cloneable_url

    unless is_temp_folder
      prefix = Dir.pwd + '/'
    else
      prefix = Dir.tmpdir + '/gito/'
    end

    @destination_dir = prefix + "#{@destination}"

    if File.directory?(@destination_dir)
      puts "The folder #{@destination_dir.green} is not empty..."
    else
      AppUtils.execute("git clone --depth 1 #{cloneable} #{@destination_dir}")
    end

    @destination_dir
  end

  def open_editor(app)
    puts "Opening editor...".yellow
    go_inside_and_run "#{app} ."
  end

  def open_folder
    puts 'Opening folder...'.yellow
    go_inside_and_run 'open .'
  end

  def go_inside_and_run(command)
    Dir.chdir(@destination_dir) do
      AppUtils::execute command, false
    end
  end
end
