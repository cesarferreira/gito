require 'colorize'
require 'tmpdir'
require 'fileutils'
require 'gito/version'
require 'gito/project'
require 'gito/config_manager'
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
    @editor = nil
    @setting_up = false

    # Parse Options
    create_options_parser(arguments)
  end

  def create_options_parser(args)
    args.options do |opts|
      opts.banner = 'Usage: gito GIT_URL [OPTIONS]'
      opts.separator ''
      opts.separator 'Options'

      opts.on('-s EDITOR', '--set-editor EDITOR', 'Set a custom editor to open the project (e.g. "atom", "subl", "vim", etc.') do |editor|
        @editor = editor.nil? ? nil : editor
        @setting_up = true
      end

      opts.on('-e', '--edit', 'Open the project on an editor') do |editor|
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

  def update_configuration
    config_manager = ConfigManager.new
    app_config = config_manager.get

    if @editor.nil?
      @editor = app_config[:editor]
    else
      config_manager.write_editor @editor
    end
  end

  def call

    if @setting_up
      if @editor.nil?
          puts 'New new editor can\'t be empty'.red
        else
          update_configuration
          puts 'Updated the editor to: ' + @editor.yellow
      end
    exit 1
    end

    if @url.nil?
      puts 'You need to insert a valid GIT URL/folder'
      exit 1
    end

    # handle the configuration
    update_configuration

    project = Project.new(@url)

    # Clone the repository
    project.clone

    # Open in editor
    if @should_edit
      # binding.pry
      project.open_editor @editor
    end

    # Open in Finder
    if @should_open
      project.open_folder
    end

    unless @dryrun
      # Install dependencies
      project.install_dependencies
    end

    # Change to directory
    project.change_directory

  end
end
