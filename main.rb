# encoding: utf-8
#
# Этот код необходим только при использовании русских букв на Windows
if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

# Подключаем модули программы
require_relative "lib/game"
require_relative "lib/result_printer"
require_relative "lib/word_reader"

# Создаем объекты классов
printer = ResultPrinter.new
word_reader = WordReader.new

# Здесь находится файл со словами
words_file_name = File.dirname(__FILE__) + "/data/words.txt"

game = Game.new(word_reader.read_from_file(words_file_name))

while game.status == 0
  printer.print_status(game)
  game.ask_next_letter
end

# Выводим результаты игры
printer.print_status(game)
