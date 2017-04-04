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
    @dryrun = false

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
        @should_open = true
      end

      opts.on('-d', '--dryrun', 'Doesn\'t install the dependencies') do |dryrun|
        @dryrun = true
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

  def call

    if @url.nil?
      puts 'You need to insert a valid GIT URL/folder'
      exit 1
    end

    project = Project.new(@url)

    # Clone the repository
    project.clone

    # Detect project type
    project.detect_project_type

    unless @dryrun
      # Install dependencies
      project.install_dependencies
    end

    # Open in editor
    if @should_edit
      project.open_editor
    end

    # Open in Finder
    if @should_open
      project.open_folder
    end

    # Change to directory
    project.change_directory


  end
end
