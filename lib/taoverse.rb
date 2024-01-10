# frozen_string_literal: true

require_relative "taoverse/version"
require 'json'
require 'colorize'

module Taoverse
  class CLI
    def run
      File.open(File.dirname(__FILE__) + '/../data/verses.json') do |file|
        verses = JSON.parse(file.read)
        index = rand(verses.length - 1)
        puts "Tao-te Ching 道德經".colorize(color: :yellow, mode: :bold)
        puts "Chapter #{index + 1}".colorize(color: :yellow)
        puts ""
        puts verses[index]
      end
    end

    def self.run
      new.run
    end
  end
end
