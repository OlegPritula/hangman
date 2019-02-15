# encoding: utf-8
#
# Класс WordReader, отвечающий за чтение слова для игры
class WordReader

  def read_from_file(file_name)
    begin
    # Открываем файл, читаем все строки в массив и закрываем
    file = File.new(file_name, "r:UTF-8")
    lines = file.readlines
    file.close
    rescue SystemCallError
      # Если файл со словами не удалось открыть, нет смысла играть.
      abort "Файл со словами не найден!"
    end
    # Возвращаем случайную строчку (слово) из прочитанного массива
    return lines.sample.chomp
  end
end
