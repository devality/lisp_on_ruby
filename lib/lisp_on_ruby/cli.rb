require "thor"

class Cli < Thor
  desc "eval_file", 'Read and eval file with lisp code'
  method_option :file, :aliases => "-f", :desc => "File name"
  def eval_file
    file = File.read(options[:file])
    Interpreter.evaluate(Parser.new.string_to_ast(file), Env.new)
  end

  desc "test", 'Eval test code'
  def test
    Main.test
  end
end
