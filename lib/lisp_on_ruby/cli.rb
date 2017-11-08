require "thor"

class Cli < Thor
  desc "eval_file", 'Read and eval file with lisp code'
  method_option :file, :aliases => "-f", :desc => "File name"
  def eval_file
    code = File.read(options[:file])
    puts eval_code(code, Env.new)
  end

  desc "repl", 'REPL'
  def repl
    env = Env.new
    print "=> "
    while code = STDIN.gets.chomp
      break if code == 'exit'
      puts eval_code(code, env)
      print "=> "
    end
  end

  private
  def eval_code(code, env)
    Interpreter.evaluate(Parser.new.string_to_ast(code), env)
  end
end
