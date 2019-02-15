# encoding: utf-8
#
# Основной класс игры Game, хранит состояние игры и предоставляет функции для
# развития игры (ввод новых букв, подсчет кол-ва ошибок и т. п.).
require "unicode_utils/downcase"

class Game
  def initialize(slovo)
    small_letters = UnicodeUtils.downcase(slovo)
    @letters = get_letters(small_letters)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = 0
  end

  def get_letters(small_letters)
    if small_letters == nil || small_letters == ""
      abort "Введите слово..."
    end

    return small_letters.encode('UTF-8').split("")
  end

  def next_step(bukva)
    if @status == -1 || @status == 1
      return
    end

    if @good_letters.include?(bukva) || @bad_letters.include?(bukva)
      return
    end

    if @letters.include?(bukva) ||
      bukva == "е" && @letters.include?("ё")||
      bukva == "ё" && @letters.include?("е")||
      bukva == "й" && @letters.include?("и")||
      bukva == "и" && @letters.include?("й")

      @good_letters << bukva

      if bukva == "е"
        @good_letters << "ё"
      end

      if bukva == "ё"
        @good_letters << "е"
      end

      if bukva == "и"
        @good_letters << "й"
      end

      if bukva == "й"
        @good_letters << "и"
      end


      if (@letters - @good_letters).empty?
        @status = 1
      end
    else
      @bad_letters << bukva
      @errors += 1
      if @errors >= 7
        @status = -1
      end
    end
  end

  def ask_next_letter
    puts "\nВведите следующую букву"

    letter = ""
    while letter == ""
      letter = UnicodeUtils.downcase(STDIN.gets.encode("UTF-8").chomp)
    end

    next_step(letter)
  end

  def errors
    @errors
  end

  def letters
    @letters
  end

  def good_letters
    @good_letters
  end

  def bad_letters
    @bad_letters
  end

  def status
    @status
  end
end
