require 'pathname'

@directories = 0
@files = {}
arr_files = []

def file_count(pathname)
  pathname.each_child  do |child|
    if child.directory?
      @directories += 1
      file_count child
    else
      add_file_by_extenstion child unless child.extname.nil?
    end
  end
end

def add_file_by_extenstion(pathname)
  if @files[pathname.extname].nil?
    @files[pathname.extname] = 1
  else
    @files[pathname.extname] += 1
  end
end

puts ARGV
puts "Enter Path : "
path = gets.chomp
file_count Pathname.new(path)

@files.each do |extension, count|
  puts "#{extension}\t (#{count})"
  arr_files << { extension: extension, count: count }
end

bigger_content = arr_files.sort_by{ |x| x[:count] }.last
puts "Bigger number of Content #{bigger_content[:extension]}\t (#{bigger_content[:count]})"



