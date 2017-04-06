require 'safe_yaml'

class ConfigManager
	@conf_path = '~/.gito.yml'
	@default_config = {"editor": "atom"}

	def initialize
		SafeYAML::OPTIONS[:default_mode] = :safe
		SafeYAML::OPTIONS[:deserialize_symbols] = true
	end

	def write_editor(new_editor)
		current_config = get
		current_config[:editor] = new_editor
		write(current_config)
	end

	def write(config)
		new_config = config.to_yaml
		File.open(@conf_path, 'w') { |file| file.write(new_config)}
	end

	def get
		if File.exists? (@conf_path)
			file = File.open(@conf_path, "rb")
			contents = file.read
			config = YAML.load(contents, :safe => true)
		else
			write @default_config
		end

		config		
	end
end
