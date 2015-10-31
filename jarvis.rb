require 'fileutils'

# Set ENV Variable
system 'export JARVIS_PATH="/Users/jayxni/Dropbox/jarvis/jarvis/"'

load 'jconfig.rb'
load ENV["JARVIS_PATH"] + 'jlib.rb'

# Load Custom Skin
if @PARAMS[:skin].nil?
  @PARAMS[:skin] = "default"
end
skindir = $JPATH + 'skins/' + @PARAMS[:skin]
FileUtils.rm($JPATH + 'app/assets', :force => true)
FileUtils.rm($JPATH + 'app/views', :force => true)
system 'ln -s ' + skindir + '/assets ' + $JPATH + 'app/assets'
system 'ln -s ' + skindir + '/views ' + $JPATH + 'app/views'

# Load Blueprints
loadBlueprints()

# Ignore upload directory + more
FileUtils.cp($JPATH + 'jarvis.gitignore', '.gitignore')

# Copy over commands file
FileUtils.cp($JPATH + "jcommands.sh", "jcommands.sh")

# Copy over Vendor assets and Application configs
FileUtils.cp_r($JPATH + 'vendor','.')
FileUtils.cp_r($JPATH + 'config','.')
FileUtils.cp_r($JPATH + ASSETS_DIR + '/.', ASSETS_DIR)

# Remove application.css
puts ">>> Removing application CSS  ....."
FileUtils.rm(ASSETS_DIR + 'stylesheets/application.css', :force => true)

if @PARAMS[:use_haml]==true
  puts ">>> Removing application ERB ....."
  FileUtils.rm(VIEWS_DIR + 'layouts/application.html.erb', :force => true)
end

# Set up configs
[ CONFIG_DIR ].each do |d|
  Dir.glob( d + "/**/*" ).each do |f|
    unless File.directory?(f) 
      puts "Adding Blueprints for file: " + f
      parseFile(f)
    end
  end
end

# Set up Gemfile with custom configuration
puts ">>> Setting Up GemFile ......"

GEMFILE = 'Gemfile'
FileUtils.cp($JPATH + GEMFILE, GEMFILE)
parseFile(GEMFILE)

# Install packages
system 'bundle install'

if @PARAMS[:generate_models]
  generateModels()
end

# Copy over MVC
puts ">>> Copying over jarvis MVC ......"

FileUtils.cp_r($JPATH + CTRL_DIR + '/.', CTRL_DIR)
FileUtils.cp_r($JPATH + VIEWS_DIR + '/.', VIEWS_DIR)
FileUtils.cp_r($JPATH + MODEL_DIR + '/.', MODEL_DIR)
FileUtils.cp_r($JPATH + HELPER_DIR + '/.', HELPER_DIR)

if @BLUEPRINTS.include?("carrierwave") || @BLUEPRINTS.include?("image_single")
  FileUtils.cp_r($JPATH + 'app/uploaders' + '/.', 'app/uploaders')
end

# Configure MVC (this might be dangerous... but fix later)

[ APP_DIR, VIEWS_DIR ].each do |d|
  Dir.glob( d + "/**/*" ).each do |f|
    unless File.directory?(f) || f.include?("assets/images")
      puts "Adding Blueprints for file: " + f
      parseFile(f)
    end
  end
end


