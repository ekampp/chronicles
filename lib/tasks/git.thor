class Git < Thor
  include Thor::Actions

  desc "tag", "creates a git tag based on the current VERSION"
  def tag
    version = `git log --pretty=format:'%h' -n 1`
    run "git tag -a #{version} -m 'Deployed version #{version}'"
    run "git push --tags"
  end
end
