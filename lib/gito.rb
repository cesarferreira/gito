require 'colorize'
require 'tmpdir'
require 'fileutils'
require 'gito/version'
require 'gito/project'
require 'gito/config_manager'
require 'openssl'
require 'open3'
require 'optparse'
require 'tempfile'

class MainApp
  def initialize(arguments)

    @url = %w(-h --help -v --version -s --set-editor).include?(arguments.first) ? nil : arguments.shift

    # defaults
    @options = {}
    @options[:app_path] = nil
    @options[:should_edit] = false
    @options[:should_open] = false
    @options[:dryrun] = false
    @options[:editor] = nil
    @options[:setting_up] = false
    @options[:is_temp] = false

    # Parse Options
    create_options_parser(arguments)
  end

  def create_options_parser(args)
    args.options do |opts|
      opts.banner = 'Usage: gito GIT_URL [OPTIONS]'
      opts.separator ''
      opts.separator 'Options'

      opts.on('-s EDITOR', '--set-editor EDITOR', 'Set a custom editor to open the project (e.g. "atom", "subl", "vim", etc.') do |editor|
        @options[:editor] = editor.nil? ? nil : editor
        @options[:setting_up] = true
      end

      opts.on('-e', '--edit', 'Open the project on an editor') do |editor|
        @options[:should_edit] = true
      end

      opts.on('-o', '--open', 'Open the project on Finder') do |edit|
        @options[:should_open] = true
      end

      opts.on('-d', '--dryrun', 'Doesn\'t install the dependencies') do |dryrun|
        @options[:dryrun] = true
      end

      opts.on('-t', '--temp', 'Clones the project into a temporary folder') do |is_temp|
        @options[:is_temp] = true
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

    if @options[:editor].nil?
      @options[:editor] = app_config[:editor]
    else
      config_manager.write_editor @options[:editor]
    end
  end

  def call
    if @options[:setting_up]
      if @options[:editor].nil?
          puts 'New new editor can\'t be empty'.red
        else
          update_configuration
          puts 'Updated the editor to: ' + @options[:editor].yellow
      end
    exit
    end

    if @url.nil?
      puts 'You need to insert a valid GIT URL/folder'
      exit
    end

    # handle the configuration
    update_configuration

    project = Project.new(@url)

    # Clone the repository
    project.clone(@options[:is_temp])

    # Open in editor
    if @options[:should_edit]
      # binding.pry
      project.open_editor @options[:editor]
    end

    # Open in Finder
    if @options[:should_open]
      project.open_folder
    end

    unless @options[:dryrun]
      # Install dependencies
      project.install_dependencies
    end

    # Change to directory
    project.change_directory

  end
end
