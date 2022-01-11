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
  end

  def exists?

  end
end
