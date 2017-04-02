require 'colorize'
require 'tmpdir'
require 'fileutils'
require 'gito/version'
require 'gito/project'
require 'openssl'
require 'open3'
require 'optparse'

class MainApp
  def initialize(arguments)

    @url = %w(-h --help -v --version).include?(arguments.first) ? nil : arguments.shift

    # defaults
    @app_path = nil
    @should_edit = false
    @should_open = false

    # Parse Options
    create_options_parser(arguments)
  end

  def create_options_parser(args)
    args.options do |opts|
      opts.banner = 'Usage: gito GIT_URL [OPTIONS]'
      opts.separator ''
      opts.separator 'Options'

      opts.on('-e', '--edit', 'Open the project on an editor') do |edit|
        @should_edit = true
      end

      opts.on('-o', '--open', 'Open the project on Finder') do |edit|
        @should_edit = true
      end

      opts.on('-h', '--help', 'Displays help') do
        puts opts.help
        exit
      end

      opts.on('-v', '--version', 'Displays the version') do
        puts Gito::VERSION
        exit
      end

      opts.parse!
    end
  end

  def get_git_url(url)

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

  def cd_to_url(destination)
    # TODO cd to destination
  end

  def detect_project_type

  end

  def install_dependencies

  end

  def call

    @url = get_git_url(@url)

    if @url.nil?
      puts 'You need to insert a valid GIT URL/folder'
      exit 1
    end

    git_helper = Project.new(@url)

    # clone the repository
    # repository_path = git_helper.clone

    # change directory
    cd_to_url(git_helper.destination)

  end
end
