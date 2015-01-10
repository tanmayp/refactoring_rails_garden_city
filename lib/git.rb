class Git
  def initialize(path)
    @path = path
  end

  def head
    repo.head
  end

  def tags
    repo.tags
  end

  def remote_fetch(name)
    repo.remote_fetch(name) unless fetch_disabled?
  end

  def log(commit = 'master', path = nil, options = {})
    repo.log(commit, path, options)
  end

  def commit(id)
    Rails.cache.fetch("git.commit(#{id})") do
      repo.commit(id)
    end
  end

  def blame(file, commit = nil)
    repo.blame(file, commit)
  end

  def repo
    @repo ||= Grit::Repo.new(@path)
  end

end
