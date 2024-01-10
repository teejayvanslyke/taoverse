require 'open-uri'
require 'json'

module Taoverse
  class Extractor
    TEXT_URL = "http://classics.mit.edu/Lao/taote.mb.txt"

    def self.run
      new.run
    end

    def run
      chapters = []
      current_chapter = []
      in_chapter = false

      URI.open(TEXT_URL) do |file|
        file.each_line do |line|
          if line.start_with?("Chapter")
            chapters.push(current_chapter.join("").strip)
            in_chapter = true
            current_chapter = []
          else 
            if in_chapter && !line.start_with?('---') && !line.start_with?('PART')
              current_chapter.push(line)
            end
          end
        end
      end

      File.open('verses.json', 'w') do |file|
        file.write(JSON.pretty_generate(chapters.filter {|c| c.length > 0}))
      end
    end
  end
end
