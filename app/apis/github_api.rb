class GithubApi

  BASE_URL = "https://api.github.com/users/"

  def initialize(username)
    @username = username
  end

  def user
    conn = Faraday.get("#{BASE_URL}#{@username}")
    json_body = JSON.parse(conn.body)
  end

  def repository
    conn = Faraday.get("#{BASE_URL}#{@username}/repos")
    json_body = JSON.parse(conn.body)

    find_most_recently_pushed_repo(json_body)
  end

  def exists?

  end

  private

  def find_most_recently_pushed_repo(repos)
    most_recently_pushed_repo = {}

    placeholder = repos[0]["pushed_at"]

    repos.each do |repo|
      if repo["pushed_at"] > placeholder
        placeholder = repo["pushed_at"]
        
        most_recently_pushed_repo[:name] = repo["name"]
        most_recently_pushed_repo[:pushed_at] = repo["pushed_at"]
        most_recently_pushed_repo[:language] = repo["language"]
        
      end
    end
    most_recently_pushed_repo
  end
end
