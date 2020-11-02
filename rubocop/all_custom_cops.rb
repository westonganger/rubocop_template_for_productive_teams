### Require all custom cops recursively

current_path = File.expand_path(__dir__)

all_cops = File.join(current_path, "**/*.rb")

Dir.glob(all_cops).each do |f|
  require f
end
