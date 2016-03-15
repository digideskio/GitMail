require 'tmpdir'

class Finder
  def initialize(repo_name)
    Dir.mktmpdir("GitMail") do |dir|
      `git clone https://github.com/#{repo_name}.git #{dir}`
      @emails = `git log --pretty=format:'%an %ae'`
    end
  end

  def all_contributors
    @emails.split("\n").uniq.sort
  end
end

if $PROGRAM_NAME == __FILE__
  repo_name = ARGV[0]
  puts Finder.new(repo_name).all_contributors
end
