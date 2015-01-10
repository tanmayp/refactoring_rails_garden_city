require 'rails_helper'

RSpec.describe Git, :type => :model do
  let(:repo) { Repository.new(name: "refactoring_rails", url: @path)}
  let(:git)  { Git.new(repo.url) }

  around :each do |example|
    Dir.mktmpdir do |dir|
      Dir.chdir(dir) do
        @path = `pwd`.chomp
        `git init .`
        example.run
      end
    end
  end

  context "#head" do
    it "works" do
      expect(git.repo).to receive(:head)
      git.head
    end
  end

  context "#tags" do
    it "works" do
      expect(git.repo).to receive(:tags)
      git.tags
    end
  end

  context "#log" do
    it "works" do
      expect(git.repo).to receive(:log)
      git.log
    end
  end

  context "#commit" do
    before :each do
      Rails.cache.clear
    end

    it "works" do
      expect(git.repo).to receive(:commit)
      git.commit("abc123")
    end

    it "checks the rails cache" do
      expect(Rails.cache).to receive(:fetch).and_call_original
      git.commit("abc123")
    end
  end

  context "#blame" do
    it "works" do
      expect(git.repo).to receive(:blame)
      git.blame("abc123")
    end
  end
end
