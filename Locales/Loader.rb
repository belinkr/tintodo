# encoding: utf-8
require 'i18n'
require 'Tinto/Transformer'

I18n.locale   ||= 'en'
current_path  = File.dirname(__FILE__)
all_files     = Dir.entries(current_path)
locale_files  = all_files.select { |locale_file| locale_file.match /.*yml/ }

locale_files.each do |locale_file| 
  I18n.load_path << File.join([current_path, locale_file])
end

