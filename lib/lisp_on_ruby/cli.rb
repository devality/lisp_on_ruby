require "thor"

class Cli < Thor
  desc "read", 'Read and eval file with lisp code'
  method_option :file, :aliases => "-f", :desc => "File name"
  def read
    puts File.read(options[:file])
  end

  desc "test", 'Eval test code'
  def test
    Main.test
  end
end
