class Git
  def initialize(path)
    @path = path
  end

  METHODS = [:head, :tags, :remote_fetch, :log, :blame]

  METHODS.each do |method_name|
    class_eval <<-SRC
  def #{method_name}(*args)
    repo.#{method_name}(*args)
  end
SRC
  end

  def commit(id)
    Rails.cache.fetch("git.commit(#{id})") do
      repo.commit(id)
    end
  end

  def repo
    @repo ||= Grit::Repo.new(@path)
  end

end
